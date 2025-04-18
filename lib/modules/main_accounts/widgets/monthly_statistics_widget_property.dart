import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MonthlyStatisticsWidgetProperty extends StatefulWidget {
  const MonthlyStatisticsWidgetProperty({super.key});

  @override
  State<MonthlyStatisticsWidgetProperty> createState() => _MonthlyStatisticsWidgetPropertyState();
}

class _MonthlyStatisticsWidgetPropertyState extends State<MonthlyStatisticsWidgetProperty> {
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
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityStatisticsPage(),),);
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
                          Container(
                            width: 54,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFE4E4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              '未出租',
                              style: TextStyle(
                                color: const Color(0xFFFF4444),
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.60,
                              ),
                            ),
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
                                      'M2-12A',
                                      style: TextStyle(
                                        color: const Color(0xFF2B2F35),
                                        fontSize: 16,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4,),
                                    Text(
                                      '林房客',
                                      style: TextStyle(
                                        color: const Color(0xFF2B2F35),
                                        fontSize: 14,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
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
