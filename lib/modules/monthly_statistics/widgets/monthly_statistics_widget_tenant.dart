import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../pages/tenant_details.dart';

class MonthlyStatisticsWidgetTenant extends StatefulWidget {
  const MonthlyStatisticsWidgetTenant({super.key});

  @override
  State<MonthlyStatisticsWidgetTenant> createState() => _MonthlyStatisticsWidgetTenantState();
}

class _MonthlyStatisticsWidgetTenantState extends State<MonthlyStatisticsWidgetTenant> {
  bool paid = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16,),
            padding: EdgeInsets.symmetric(vertical: 6,),
            child: Row(
              children: [
                Text(
                  '6個物件',
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
                SizedBox(width: 16,),
                Row(
                  children: [
                    Icon(Icons.search_rounded,size: 18,),
                    SizedBox(width: 4,),
                    Text(
                      '搜尋',
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
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TenantDetailsPage(),),);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => TenantDetailsPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0); // 從下往上
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: const Color(0xFFE3E7EA),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 54,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFE4E4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  '未繳款',
                                  style: TextStyle(
                                    color: const Color(0xFFFF4444),
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                width: 72,
                                height: 72,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFB6E4D0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(height: 5,),
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
                                        SizedBox(width: 8,),
                                        Text(
                                          '扣除金',
                                          style: TextStyle(
                                            color: const Color(0xFF525D68),
                                            fontSize: 14,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        Text(
                                          '\$4,000',
                                          style: TextStyle(
                                            color: const Color(0xFFFF4444),
                                            fontSize: 14,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor: Colors.white,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(horizontal: 16,),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(height: 30,),
                                                            Center(
                                                              child: Text(
                                                                '應繳項目',
                                                                style: TextStyle(
                                                                  color: const Color(0xFF2B2F35),
                                                                  fontSize: 16,
                                                                  fontFamily: 'PingFang SC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 16,),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '租約固定金',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 8,),
                                                                Text(
                                                                  '\$14500',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFFFF4444),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '已繳費',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                Transform.scale(
                                                                  scale: 0.8,
                                                                  child: Switch(
                                                                    value: paid,
                                                                    activeColor: const Color(0xFF8C5F42),
                                                                    onChanged: (bool value) async {
                                                                      setState(() {
                                                                        paid = !paid;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '水費(月)',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '\$5600',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '水費(月)',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '\$5600',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '水費(月)',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '\$5600',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 24,),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    height: 40,
                                                                    alignment: Alignment.center,
                                                                    decoration: ShapeDecoration(
                                                                      color: Colors.white,
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          width: 1,
                                                                          color: const Color(0xFFCBD2D6),
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(4),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      '返回',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        color: const Color(0xFF2B2F35),
                                                                        fontSize: 14,
                                                                        fontFamily: 'Poppins',
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 16,),
                                                                Expanded(
                                                                  child: Container(
                                                                    height: 40,
                                                                    alignment: Alignment.center,
                                                                    decoration: ShapeDecoration(
                                                                      color: const Color(0xFF319877),
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                                    ),
                                                                    child: Text(
                                                                      '確定',
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
                                                              ],
                                                            ),
                                                            SizedBox(height: 50,),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 4),
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: const Color(0xFFCCCCCC),
                                                  ),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                                'M2-12A',
                                                style: TextStyle(
                                                  color: const Color(0xFF333333),
                                                  fontSize: 12,
                                                  fontFamily: 'PingFang TC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor: Colors.white,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(horizontal: 16,),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(height: 30,),
                                                            Center(
                                                              child: Text(
                                                                '應繳項目',
                                                                style: TextStyle(
                                                                  color: const Color(0xFF2B2F35),
                                                                  fontSize: 16,
                                                                  fontFamily: 'PingFang SC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 16,),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'M3-12A電費',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Transform.scale(
                                                                  scale: 0.8,
                                                                  child: Switch(
                                                                    value: paid,
                                                                    activeColor: const Color(0xFF8C5F42),
                                                                    onChanged: (bool value) async {
                                                                      setState(() {
                                                                        paid = !paid;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '電費(度)',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 12,),
                                                                Text(
                                                                  '\$6/度',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 12,),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '上期電度',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF5F6E7B),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 12,),
                                                                Text(
                                                                  '150度',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 12,),
                                                                Text(
                                                                  '\$900',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFFFF4444),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                SizedBox(
                                                                  height: 70,
                                                                  width: 70,
                                                                  child: Image.asset('assets/images/electricity_meter.png'),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(height: 16,),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '本期電度',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 12,),
                                                                Container(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                                                                  decoration: ShapeDecoration(
                                                                    color: const Color(0xFFF4F6F7),
                                                                    shape: RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                        width: 1,
                                                                        color: const Color(0xFFF4F6F7),
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(3),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        '200',
                                                                        style: TextStyle(
                                                                          color: const Color(0xFF2B2F35),
                                                                          fontSize: 15,
                                                                          fontFamily: 'PingFang TC',
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 10,),
                                                                      Text(
                                                                        '度',
                                                                        style: TextStyle(
                                                                          color: const Color(0xFF7B8A95),
                                                                          fontSize: 15,
                                                                          fontFamily: 'PingFang TC',
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(width: 12,),
                                                                Text(
                                                                  '\$1200',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFFFF4444),
                                                                    fontSize: 15,
                                                                    fontFamily: 'PingFang TC',
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                SizedBox(
                                                                  height: 70,
                                                                  width: 70,
                                                                  child: Image.asset('assets/images/electricity_meter.png'),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 24,),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    height: 40,
                                                                    alignment: Alignment.center,
                                                                    decoration: ShapeDecoration(
                                                                      color: Colors.white,
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          width: 1,
                                                                          color: const Color(0xFFCBD2D6),
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(4),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      '返回',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        color: const Color(0xFF2B2F35),
                                                                        fontSize: 14,
                                                                        fontFamily: 'Poppins',
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 16,),
                                                                Expanded(
                                                                  child: Container(
                                                                    height: 40,
                                                                    alignment: Alignment.center,
                                                                    decoration: ShapeDecoration(
                                                                      color: const Color(0xFF319877),
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                                    ),
                                                                    child: Text(
                                                                      '確定',
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
                                                              ],
                                                            ),
                                                            SizedBox(height: 50,),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 4),
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFF319877),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: const Color(0xFFCCCCCC),
                                                  ),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                                'M2-12A電費',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'PingFang TC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 4),
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: const Color(0xFFCCCCCC),
                                                ),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: Text(
                                              '車位C88',
                                              style: TextStyle(
                                                color: const Color(0xFF333333),
                                                fontSize: 12,
                                                fontFamily: 'PingFang TC',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 4),
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: const Color(0xFFCCCCCC),
                                                ),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: Text(
                                              '車位C88',
                                              style: TextStyle(
                                                color: const Color(0xFF333333),
                                                fontSize: 12,
                                                fontFamily: 'PingFang TC',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
