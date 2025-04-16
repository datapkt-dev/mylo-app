import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/main_accounts/pages/community_statistics.dart';

class CommunityWidget extends StatefulWidget {
  const CommunityWidget({super.key});

  @override
  State<CommunityWidget> createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends State<CommunityWidget> {
  int selectedType = 0;
  List<String> types = ['全部', '包租', '代管'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 16,),
                Row(
                  children: List.generate(types.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          setState(() {
                            selectedType = index;
                          });
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 32,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 8,),
                        decoration: ShapeDecoration(
                          color: selectedType == index ? const Color(0xFFD9F2E5) :const Color(0xFFF4F6F7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: selectedType == index ? const Color(0xFF319877) : const Color(0xFFCBD2D6),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          types[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedType == index ? const Color(0xFF319877) : const Color(0xFFA6B1BA),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 16,),
              ],
            ),
            SizedBox(height: 10,),
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
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16,),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CommunityStatisticsPage(),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
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
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF319877),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  '部分代管',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '林口套房',
                                        style: TextStyle(
                                          color: const Color(0xFF2B2F35),
                                          fontSize: 16,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        '台北市大安區和平西路88號',
                                        style: TextStyle(
                                          color: const Color(0xFF5F6E7B),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Container(
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
                                          '2F-1',
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
                                  Spacer(),
                                  Container(
                                    width: 72,
                                    height: 72,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFD9F2E5),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: Image.asset(
                                      'assets/images/property.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8,),
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
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    '待請款',
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
                                  ),
                                ],
                              ),
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
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
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
