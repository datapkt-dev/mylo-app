import 'package:flutter/material.dart';

class PropertyDetailsPage extends StatefulWidget {
  const PropertyDetailsPage({super.key});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  List<String> tabs = ['基本資訊', '本月應收帳單', '本月物件支出',];
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SizedBox(
            height: 300,
            child: Image.asset('assets/images/property_internal.png'),
          ),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                centerTitle: false,
                title: Text(
                  '物件詳情',
                  style: TextStyle(
                    color: const Color(0xFF2B2F35),
                    fontSize: 16,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16,),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Text(
                              '2025 年 01 月帳務',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: const Color(0xFF986E49),
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4,),
                            Text(
                              '好好住社區 301',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 20,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '台北市大安區和平東路88號',
                              style: TextStyle(
                                color: const Color(0xFF5F6E7B),
                                fontSize: 14,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: double.infinity,
                              height: 67,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33333333),
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '出租中',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFFFF4444),
                                            fontSize: 16,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text(
                                          '狀態',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF5F6E7B),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '16000',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF2B2F35),
                                            fontSize: 16,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text(
                                          '本月應收',
                                          style: TextStyle(
                                            color: const Color(0xFF5F6E7B),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '1200',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF2B2F35),
                                            fontSize: 16,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text(
                                          '本月支出',
                                          style: TextStyle(
                                            color: const Color(0xFF5F6E7B),
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
                            Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 16,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(tabs.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTab = index;
                                      });
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      decoration: selectedTab == index ? const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 2,
                                            color: Color(0xFF986E49),
                                          ),
                                        ),
                                      ) : null,
                                      child: Text(
                                        tabs[index],
                                        style: TextStyle(
                                          color: selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              '房東',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/contract_new/customer_female.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '張詩盈',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '0912345678',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 20,
                              thickness: 1,
                            ),
                            Text(
                              '房客',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/contract_new/customer_male.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '李宇傑',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '0912345678',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 4,
                          offset: Offset(0, -1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF986E49),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        '新增收付',
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
                  SizedBox(height: 35,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
