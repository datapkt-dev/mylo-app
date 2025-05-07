import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/api.dart';

class LoginVerifying extends StatefulWidget {
  final String id;
  const LoginVerifying({super.key, required this.id});

  @override
  State<LoginVerifying> createState() => _LoginVerifyingState();
}

class _LoginVerifyingState extends State<LoginVerifying> {
  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;

  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  Timer? timer;
  Duration duration = const Duration(minutes: 3, seconds: 55);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() {
        setState(() {});
      });
    }
    startTimer();
    apiService = ApiService(baseUrl: baseUrl);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (duration.inSeconds == 0) {
          timer.cancel();
          showAlertDialog(context);
        } else {
          duration -= const Duration(seconds: 1);
        }
      });
    });
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("時間到！"),
          content: const Text("倒數計時結束。"),
          actions: [
            TextButton(
              child: const Text("確定"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  OutlineInputBorder getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1.0),
    );
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((focusNode) => focusNode.dispose());
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight= MediaQuery.of(context).size.height;
    // double hScale = screenHeight/812;
    // double wScale = screenWidth/375;

    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final seconds = strDigits(duration.inSeconds.remainder(60));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        // title: Text('OTP 驗證'),
        // centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32,),
            Text(
              '輸入驗證碼',
              style: TextStyle(
                color: const Color(0xFF454545),
                fontSize: 24,
                fontFamily: 'PingFang TC',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.30,
              ),
            ),
            SizedBox(height: 16,),
            Text(
              '+886 926***567',
              style: TextStyle(
                color: const Color(0xFF454545),
                fontSize: 16,
                fontFamily: 'Noto Sans TC',
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(controllers.length, (index) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: focusNodes[index].hasFocus ? const Color(0xFFF55572) : const Color(0xFFEEEEEE),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      cursorColor: const Color(0xFF333333),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: (50 - 24) / 2),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) {
                        if (value.length == 1 && index < focusNodes.length - 1) {
                          focusNodes[index + 1].requestFocus();
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '重寄驗證碼($minutes:$seconds)',
                  style: TextStyle(
                    color: const Color(0xFFF55572),
                    fontSize: 14,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36,),
            GestureDetector(
              onTap: () {
                apiService.submitOTP(context, widget.id, controllers);
              },
              child: Container(
                height: 44,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF55572),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  shadows: [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Text(
                  '下一步',
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
      ),
    );
  }
}
