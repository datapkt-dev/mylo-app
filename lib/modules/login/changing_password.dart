import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'data/api.dart';

class ChangingPassword extends StatefulWidget {
  final String id;
  const ChangingPassword({super.key, required this.id});

  @override
  State<ChangingPassword> createState() => _ChangingPasswordState();
}

class _ChangingPasswordState extends State<ChangingPassword> {
  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 23,),
                Text(
                  '設定密碼',
                  style: TextStyle(
                    color: const Color(0xFF454545),
                    fontSize: 24,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.30,
                  ),
                ),
                const SizedBox(height: 16,),
                Text(
                  '輸入密碼',
                  style: TextStyle(
                    color: const Color(0xFF454545),
                    fontSize: 16,
                    fontFamily: 'Noto Sans TC',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4,),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFEEEEEE),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    obscureText: true,
                    maxLines: 1,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: '請輸入密碼(8~16英數字)',
                      hintStyle: TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 16,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: 16,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                Text(
                  '再次輸入密碼',
                  style: TextStyle(
                    color: const Color(0xFF454545),
                    fontSize: 16,
                    fontFamily: 'Noto Sans TC',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4,),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFEEEEEE),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    obscureText: true,
                    maxLines: 1,
                    controller: _checkController,
                    decoration: InputDecoration(
                      hintText: '請輸入密碼(8~16英數字)',
                      hintStyle: TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 16,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: 16,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 41,),
                GestureDetector(
                  onTap: () {
                    if(_passwordController.text == _checkController.text) {
                      apiService.submitNewPassword(context, widget.id, _passwordController.text);
                    } else {
                      Fluttertoast.showToast(msg: "請確認密碼是否正確");
                    }
                  },
                  child: Container(
                    height: 46,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF55572),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: const Text(
                      '登入',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
