import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ContractNewStep3 extends StatefulWidget {
  const ContractNewStep3({super.key});

  @override
  State<ContractNewStep3> createState() => _ContractNewStep3State();
}

class _ContractNewStep3State extends State<ContractNewStep3> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _block(Column(
            children: [
              const Row(
                children: [
                  Text(
                    '家具',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(10),
                  Text(
                    '3項',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < 2 ? 16 : 0,),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                const Gap(8),
                                const Text(
                                  '雙人床床架 X1',
                                  style: TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              '\$5600',
                              style: TextStyle(
                                color: Color(0xFF5F6E7B),
                                fontSize: 14,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.70,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: light,
                            activeColor: const Color(0xFF8C5F42),
                            onChanged: (bool value) {
                              setState(() {
                                light = value;
                              });
                            },
                          ),
                        )

                      ],
                    ),
                  );
                }),
              ),
              const Divider(height: 48, thickness: 1, color: Color(0xFFCBD2D6),),
              const Row(
                children: [
                  Text(
                    '家具',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(10),
                  Text(
                    '3項',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Column(
                children: List.generate(6, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < 5 ? 16 : 0,),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                const Gap(8),
                                const Text(
                                  '雙人床床架 X1',
                                  style: TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              '\$5600',
                              style: TextStyle(
                                color: Color(0xFF5F6E7B),
                                fontSize: 14,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.70,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: light,
                            activeColor: const Color(0xFF8C5F42),
                            onChanged: (bool value) {
                              setState(() {
                                light = value;
                              });
                            },
                          ),
                        )

                      ],
                    ),
                  );
                }),
              ),
            ],
          ),),
          const Gap(16),
          _block(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '影片',
                style: TextStyle(
                  color: Color(0xFF2B2F35),
                  fontSize: 15,
                  fontFamily: 'PingFang TC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF319877)),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icons/contract_new/video-recorder.svg'),
                    const Gap(8),
                    const Text(
                      '上傳1/1',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.70,
                      ),
                    )
                  ],
                )
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _block(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
