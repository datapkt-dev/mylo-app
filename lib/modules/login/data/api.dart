import 'package:flutter/material.dart';
import 'dart:convert';
// import 'model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mylo/modules/index_frame.dart';
import 'package:mylo/modules/login/changing_password.dart';
import 'package:mylo/modules/login/login_member.dart';
import 'package:mylo/modules/login/login_verifying.dart';
import '../login.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<String> getOTP(BuildContext context, String id) async {
    String urlString = '$baseUrl/api/v1/auth/validate?staff_no=$id';
    final url = Uri.parse(urlString);
    final response = await http.get(url);
    print(json.decode(response.body)['message']);
    print(response.statusCode);

    if (response.statusCode == 200) {
      String decodedResponse = response.body;
      Map<String, dynamic> responseData = json.decode(decodedResponse);

      switch (responseData['code'] as int) {
        case 0:
          return 'pass';
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginVerifying(id: id)),
          );
          return 'verifying';
        default:
          return 'unknown';
      }
    } else {
      final errorMsg = json.decode(response.body)['message'] ?? 'Unknown error';
      Fluttertoast.showToast(msg: errorMsg);
      return 'error';
    }
  }

  void login(BuildContext context, String account, String password) async {
    String url = '$baseUrl/api/v1/login';

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "staff_no": account,
      "password": password,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        print('登入成功: $decoded');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IndexFrame()),
        );
      } else {
        print('登入失敗: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('發生錯誤: $e');
    }
  }

  void submitOTP(BuildContext context, String account, dynamic controllers) async{
    String otpCode = controllers.map((controller) => controller.text).join();

    if(otpCode.length < 4) {
      // 用戶可能沒有輸入完整的OTP
      Fluttertoast.showToast(msg: "請輸入完整的OTP碼");
      // _showCustomErrorDialog(context, "請輸入完整的OTP碼");
    } else {
      // OTP碼已輸入完整，處理otpCode
      print("完整的OTP碼是：$otpCode");
      // 可以在這裡添加更多的處理，比如發送到後端進行驗證等等

      String url = '$baseUrl/api/v1/auth/verify-code';

      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        "staff_no": account,
        "code": otpCode,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        final jsonData = json.decode(decodedResponse);
        print(jsonData);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChangingPassword(id: account,)),
        );
      } else {
        Fluttertoast.showToast(msg: "驗證失敗");
      }
    }
  }

  void submitNewPassword(BuildContext context, String account, String password) async{
    String url = '$baseUrl/api/v1/auth/set-password';

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "staff_no": account,
      "password": password,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        print('密碼變更成功: $decoded');
        final result = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/complete.svg'),
                  const SizedBox(height: 20,),
                  const Text(
                    '密碼設定完成',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 60,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3C69E8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '確定',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        print('登入失敗: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('發生錯誤: $e');
    }
  }

}