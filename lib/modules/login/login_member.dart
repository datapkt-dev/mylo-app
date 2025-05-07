import 'package:flutter/material.dart';
import '../index_frame.dart';
import 'data/api.dart';

class LoginMember extends StatefulWidget {
  final String id;
  const LoginMember({super.key, required this.id});

  @override
  State<LoginMember> createState() => _LoginMemberState();
}

class _LoginMemberState extends State<LoginMember> {
  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscure = true;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
    _accountController.text = widget.id;
  }

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
                        child: TextField(
                          enabled: false,
                          maxLines: 1,
                          controller: _accountController,
                          decoration: InputDecoration(
                            hintText: '輸入帳號',
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
                SizedBox(height: 20,),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _passwordController,
                          obscureText: obscure,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '請輸入密碼',
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: obscure ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: Checkbox(
                        value: rememberMe,
                        activeColor: Color(0xFFF55572),
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 4,),
                    Text(
                      '記住我',
                      style: TextStyle(
                        color: const Color(0xFF454545),
                        fontSize: 14,
                        fontFamily: 'Noto Sans TC',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '忘記密碼',
                      style: TextStyle(
                        color: const Color(0xFFF55572),
                        fontSize: 14,
                        fontFamily: 'Noto Sans TC',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    apiService.login(context, _accountController.text, _passwordController.text);
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
                const SizedBox(height: 42,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '如有借款需求請ＯＯLine官方',
                      style: TextStyle(
                        color: const Color(0xFF454545),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4,),
                    Text(
                      '興達LINE官方',
                      style: TextStyle(
                        color: const Color(0xFFF55572),
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
