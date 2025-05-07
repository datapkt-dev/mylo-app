import 'package:flutter/material.dart';

import '../../units/auth_service.dart';
import '../login/login.dart';

class IndexProfilePage extends StatefulWidget {
  const IndexProfilePage({super.key});

  @override
  State<IndexProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<IndexProfilePage> {
  final AuthService authStorage = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '蠟筆小新',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 18,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        '0912345678',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 16,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 11,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white /* white */,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 8,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '設定',
                      style: TextStyle(
                        color: Color(0xFF6A6A6A),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const ProfileEditPage()),
                        // );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 13,),
                        child: Row(
                          children: [
                            Text(
                              '個人資料',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 16,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 13,),
                      child: Row(
                        children: [
                          Text(
                            '重設密碼',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 16,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 13,),
                      child: Row(
                        children: [
                          Text(
                            '刪除帳號',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 16,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  await authStorage.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 44,
                  padding: const EdgeInsets.all(10),
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
                    '登出',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
