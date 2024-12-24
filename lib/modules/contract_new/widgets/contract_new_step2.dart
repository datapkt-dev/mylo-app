import 'package:flutter/material.dart';

class ContractNewStep2 extends StatefulWidget {
  const ContractNewStep2({super.key});

  @override
  State<ContractNewStep2> createState() => _ContractNewStep2State();
}

class _ContractNewStep2State extends State<ContractNewStep2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Column(
            children: [
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '費用',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    '這裡是寫一些說明的地方沒有也可不寫',
                    style: TextStyle(
                      color: Color(0xFF5F6E7B),
                      fontSize: 12,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '押金(月)',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 15,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Color(0xFF2B2F35),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    const Text(
                                      '元/月',
                                      style: TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '租金(月)',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 15,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Color(0xFF2B2F35),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    const Text(
                                      '元/月',
                                      style: TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '電度(度)',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF4F6F7),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const Text(
                              '元/度',
                              style: TextStyle(
                                color: Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
              const SizedBox(height: 16,),
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '合約起訖日',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    '這裡是寫一些說明的地方沒有也可不寫',
                    style: TextStyle(
                      color: Color(0xFF5F6E7B),
                      fontSize: 12,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      const Text(
                        '生效日',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF4F6F7),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      const Text(
                        '結束日',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF4F6F7),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
              const SizedBox(height: 16,),
              _block(const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '選擇簽約人數',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    '人數',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    '填寫簽約資料',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 16,),
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '備註',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F6F7),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
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
