import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../index_frame.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> countryCodes = ['TW +886', 'NA +1'];
  int selectedCode = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 35,),
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  color: const Color(0xFFF2F2F2),
                  child: const Text(
                    'LOGO',
                    style: TextStyle(
                      color: Color(0xFFB7B7B7),
                      fontSize: 20,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 14,),
                const Text(
                  'Slogan',
                  style: TextStyle(
                    color: Color(0xFFBFBFBF),
                    fontSize: 16,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 38,),
                Row(
                  children: [
                    Container(
                      width: 124,
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFEEEEEE),),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          value: selectedCode,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                          items: List.generate(countryCodes.length, (index) {
                            return DropdownMenuItem<int>(
                              value: index, // 設定 value 為索引
                              child: Text(countryCodes[index]), // 顯示對應的模式名稱
                            );
                          }),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedCode = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: Container(
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
                        child: const TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '輸入您的手機號碼',
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
                    ),
                  ],
                ),
                const SizedBox(height: 40,),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const IndexFrame()),
                    );
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
                const SizedBox(height: 30,),
                const Text(
                  '或使用社群登入',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 45,),
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFE7E7E7),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: SvgPicture.asset('assets/icons/logo_google.svg'),
                ),
                const SizedBox(height: 30,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '還沒有帳號嗎？',
                      style: TextStyle(
                        color: Color(0xFF454545),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4,),
                    Text(
                      '立即註冊',
                      style: TextStyle(
                        color: Color(0xFFF55572),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '登入即代表同意',
                      style: TextStyle(
                        color: Color(0xFF505050),
                        fontSize: 12,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '使用條款',
                      style: TextStyle(
                        color: Color(0xFFF55572),
                        fontSize: 12,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '和',
                      style: TextStyle(
                        color: Color(0xFF505050),
                        fontSize: 12,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '隱私權政策',
                      style: TextStyle(
                        color: Color(0xFFF55572),
                        fontSize: 12,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
