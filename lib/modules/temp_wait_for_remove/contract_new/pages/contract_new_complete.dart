import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ContractNewComplete extends StatelessWidget {
  const ContractNewComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30,),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '好宅紹區套房10F-1',
                  style: TextStyle(
                    color: Color(0xFF2B2F35),
                    fontSize: 16,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(30),
                Center(
                  child: QrImageView(
                    data: 'This is a simple QR code',
                    version: QrVersions.auto,
                    size: 150,
                    gapless: false,
                  ),
                ),
                const Gap(30),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '簽約人 1',
                          style: TextStyle(
                            color: Color(0xFF5F6E7B),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '簽約人 2',
                          style: TextStyle(
                            color: Color(0xFF5F6E7B),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '簽約人 3',
                          style: TextStyle(
                            color: Color(0xFF5F6E7B),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '立約人 ',
                          style: TextStyle(
                            color: Color(0xFF5F6E7B),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '合約起迄日',
                          style: TextStyle(
                            color: Color(0xFF5F6E7B),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '合約編號',
                          style: TextStyle(
                            color: Color(0xFF5F6E7B),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Gap(40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '團團',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '林旺',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '李ＯＯ',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '林業務',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          '2024/12/11 ～2025/12/10',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(20),
                        Text(
                          'RENT20241211001',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 38,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF8C5F42),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Text(
                          '完成',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Container(
                        height: 38,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          '分享',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
