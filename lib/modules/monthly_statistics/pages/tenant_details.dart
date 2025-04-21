import 'package:flutter/material.dart';

class TenantDetailsPage extends StatefulWidget {
  const TenantDetailsPage({super.key});

  @override
  State<TenantDetailsPage> createState() => _TenantDetailsPageState();
}

class _TenantDetailsPageState extends State<TenantDetailsPage> {
  List<String> tabs = ['M2-12A', 'M2-12A電費', 'M2-13A', '車位C88'];
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Text(
            '帳務詳情',
            style: TextStyle(
              color: const Color(0xFF2B2F35),
              fontSize: 16,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16,),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9F2E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/contract_new/customer_female.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            '陳房客',
                            style: TextStyle(
                              color: const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '3月份應繳',
                            style: TextStyle(
                              color: const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            '\$20,000',
                            style: TextStyle(
                              color: const Color(0xFF2B2F35),
                              fontSize: 24,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            '繳款截止日 2025/02/28',
                            style: TextStyle(
                              color: const Color(0xFF5F6E7B),
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
                SizedBox(height: 10,),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xFFCBD2D6),
                      ),
                    ),
                  ),
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8,),
                          alignment: Alignment.center,
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
                              color: selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF333333),
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFCBD2D6),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '租期',
                            style: TextStyle(
                              color: const Color(0xFF5F6E7B),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '2024/01/01～2025/12/31',
                            style: TextStyle(
                              color: const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '租約固定金',
                            style: TextStyle(
                              color: const Color(0xFF5F6E7B),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '1000元/月',
                            style: TextStyle(
                              color: const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '水費',
                            style: TextStyle(
                              color: const Color(0xFF5F6E7B),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '200元/月',
                            style: TextStyle(
                              color: const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '電費',
                            style: TextStyle(
                              color: const Color(0xFF5F6E7B),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '7元/度',
                            style: TextStyle(
                              color: const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '合計',
                            style: TextStyle(
                              color: const Color(0xFF5F6E7B),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '\$10400',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
