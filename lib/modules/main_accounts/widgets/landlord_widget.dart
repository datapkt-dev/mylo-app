import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/main_accounts/widgets/community_widget.dart';

class LandlordWidget extends StatefulWidget {
  const LandlordWidget({super.key});

  @override
  State<LandlordWidget> createState() => _LandlordWidgetState();
}

class _LandlordWidgetState extends State<LandlordWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16,),
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
              SizedBox(width: 16,),
            ],
          ),
          SizedBox(height: 8,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return FractionallySizedBox(
                            heightFactor: 0.85,
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 16,),
                                      child: Text(
                                        '陳房東',
                                        style: TextStyle(
                                          color: const Color(0xFF2B2F35),
                                          fontSize: 16,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                ),
                                SizedBox(height: 20,),
                                CommunityWidget(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10, right: 16, left: 16,),
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: const Color(0xFFDEE2E6),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 24,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF986E49),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              '包租',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w500,
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
                                  color: Color(0xFFD9F2E5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Image.asset('assets/images/user.png'),
                              ),
                              SizedBox(width: 12,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '王房東',
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
                                        '平均月收益',
                                        style: TextStyle(
                                          color: const Color(0xFF525D68),
                                          fontSize: 14,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        '\$200,000',
                                        style: TextStyle(
                                          color: const Color(0xFFFF4444),
                                          fontSize: 14,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Text(
                                        '12',
                                        style: TextStyle(
                                          color: const Color(0xFF319877),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        '物件',
                                        style: TextStyle(
                                          color: const Color(0xFF319877),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 8,),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                          color: const Color(0xFF319877),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        '待繳',
                                        style: TextStyle(
                                          color: const Color(0xFF319877),
                                          fontSize: 15,
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
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      )
    );
  }
}
