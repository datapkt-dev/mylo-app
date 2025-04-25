import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetBill extends StatefulWidget {
  const WidgetBill({super.key});

  @override
  State<WidgetBill> createState() => _WidgetBillState();
}

class _WidgetBillState extends State<WidgetBill> {
  int selectedTab = 0;
  List<String> tabs = ['帳單列表', '支出列表',];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: List.generate(tabs.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  setState(() {
                    selectedTab = index;
                  });
                });
              },
              child: Container(
                width: 90,
                height: 32,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 12,),
                decoration: ShapeDecoration(
                  color: selectedTab == index ? const Color(0xFFD9F2E5) :const Color(0xFFF4F6F7),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: selectedTab == index ? const Color(0xFF319877) : const Color(0xFFCBD2D6),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTab == index ? const Color(0xFF319877) : const Color(0xFFA6B1BA),
                    fontSize: 15,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text(
              '區間總額Ｘ元',
              style: TextStyle(
                color: const Color(0xFF5F6E7B),
                fontSize: 14,
                fontFamily: 'PingFang TC',
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/index/filter.svg',
                  color: Colors.black,
                ),
                SizedBox(width: 4,),
                Text(
                  '篩選',
                  style: TextStyle(
                    color: const Color(0xFF2B2F35),
                    fontSize: 14,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16,),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/index/sort.svg',
                  color: Colors.black,
                ),
                SizedBox(width: 4,),
                Text(
                  '排序',
                  style: TextStyle(
                    color: const Color(0xFF2B2F35),
                    fontSize: 14,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: const Color(0xFF319877),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.add),
              Text(
                '新增支出',
                style: TextStyle(
                  color: const Color(0xFF2B2F35),
                  fontSize: 14,
                  fontFamily: 'Noto Sans TC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Column(
          children: List.generate(2, (index) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10,),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: const Color(0xFFDEE2E6),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '2025年1月',
                        style: TextStyle(
                          color: const Color(0xFF2B2F35),
                          fontSize: 14,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$12,000',
                        style: TextStyle(
                          color: const Color(0xFFFF4444),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9F2E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(width: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '林房客',
                                style: TextStyle(
                                  color: const Color(0xFF2B2F35),
                                  fontSize: 16,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 8,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFF4444),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  '欠',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFF4444),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  '逾',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Row(
                            children: [
                              Text(
                                '租約固定金',
                                style: TextStyle(
                                  color: const Color(0xFF525D68),
                                  fontSize: 14,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 8,),
                              Text(
                                '\$16,000',
                                style: TextStyle(
                                  color: const Color(0xFFFF4444),
                                  fontSize: 14,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

