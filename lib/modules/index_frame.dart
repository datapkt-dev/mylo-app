import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/index_accounts/index_accounts.dart';
import 'package:mylo/modules/index_contract/index_contract.dart';
import 'package:mylo/modules/index_profile/index_profile.dart';
import 'package:mylo/modules/index_property/index_property.dart';
import 'data/api.dart';
import 'index_page/index_page.dart';

class IndexFrame extends StatefulWidget {
  const IndexFrame({super.key});

  @override
  State<IndexFrame> createState() => _PageFrameState();
}

class _PageFrameState extends State<IndexFrame> {
  final String baseUrl = 'https://rencoo.com.tw';

  int selectedIndex = 2;

  Color getItemColor(int index) {
    return selectedIndex == index ? const Color(0xFF8C5F42) : const Color(0x4C222222);
  }

  final Set<int> selectedIndices = {};

  final List<Map<String, String>> items = [
    {'title': '好好住社區', 'subtitle': '台北市大安區敦化南路88號', 'tag': '部分代管'},
    {'title': '勤美學', 'subtitle': '台北市大安區敦化南路88號', 'tag': '部分包租'},
    {'title': '富田ㄧ號', 'subtitle': '台北市大安區敦化南路88號', 'tag': '部分代管'},
    {'title': '好好睡社區', 'subtitle': '台北市大安區敦化南路88號', 'tag': '部分代管'},
  ];

  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  @override
  void initState() {
    super.initState();

    apiService = ApiService(baseUrl: baseUrl);

    futureData = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '選擇社區',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '發生錯誤: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        dataList = snapshot.data!;
                        print(dataList);
                      }
                      return Column(
                        children: List.generate(dataList.length, (index) {
                          return Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              leading: ClipOval(
                                child: Image.network(
                                  'http://rencoo.com.tw/${dataList[index]['avatar_url']}',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                '${dataList[index]['first_name']}${dataList[index]['last_name']} (4)',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 14,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              children: List.generate(items.length, (index) {
                                final item = items[index];
                                final isSelected = selectedIndices.contains(index);

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedIndices.remove(index);
                                      } else {
                                        selectedIndices.add(index);
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.symmetric(horizontal: 4,),
                                    decoration: ShapeDecoration(
                                      color: isSelected ? Color(0xFFF6F6F6) : Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Stack(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(width: 1, color: const Color(0xFFDEE2E6)),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: Image.asset(
                                                'assets/images/property.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 40,
                                              height: 11,
                                              alignment: Alignment.center,
                                              decoration: ShapeDecoration(
                                                color: item['tag'] == '部分包租' ? Color(0xFFB3885C) : Color(0xFF319877),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                                item['tag']!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontFamily: 'PingFang TC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                        item['title']!,
                                        style: TextStyle(
                                          color: const Color(0xFF2B2F35),
                                          fontSize: 14,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        item['subtitle']!,
                                        style: TextStyle(
                                          color: const Color(0xFF5F6E7B),
                                          fontSize: 12,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // no trailing
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            )
          ),
        ),
      ),
      body: _buildContent(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 15,
              offset: Offset(0.0, 0.75),
            ),
          ],
        ),
        child: BottomAppBar(
          color: const Color(0xFFFFFFFF),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // _buildBottomNavigationBarItem(
              //   0,
              //   'assets/icons/frame/index.svg',
              //   '首頁',
              // ),
              _buildBottomNavigationBarItem(
                1,
                'assets/icons/frame/property.svg',
                '物件',
              ),
              _buildBottomNavigationBarItem(
                2,
                'assets/icons/frame/contract.svg',
                '合約',
              ),
              // const SizedBox(width: 25),
              // Container(
              //   margin: const EdgeInsets.only(top: 28),
              //   // child: Text(
              //   //   '靜坐',
              //   //   style: TextStyle(color: Color(0xFFFF6160),),
              //   // ),
              // ),
              // const SizedBox(width: 25),
              _buildBottomNavigationBarItem(
                3,
                'assets/icons/frame/accounts.svg',
                '帳務',
              ),
              _buildBottomNavigationBarItem(
                4,
                'assets/icons/frame/profile.svg',
                '我的',
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     showModalBottomSheet(
      //       backgroundColor: Colors.white,
      //       context: context,
      //       builder: (BuildContext context) {
      //         return Container(
      //           width: double.infinity,
      //           height: 200,
      //           padding: const EdgeInsets.only(top: 48, left: 16, right: 16,),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               GestureDetector(
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) => const ContractNew()),
      //                   );
      //                 },
      //                 child: const SizedBox(
      //                   height: 40,
      //                   child: Text(
      //                     '新增合約',
      //                     style: TextStyle(
      //                       color: Color(0xFF222222),
      //                       fontSize: 16,
      //                       fontFamily: 'PingFang TC',
      //                       fontWeight: FontWeight.w500,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 height: 40,
      //                 child: Text(
      //                   '上傳合約',
      //                   style: TextStyle(
      //                     color: Color(0xFF2B2F35),
      //                     fontSize: 15,
      //                     fontFamily: 'PingFang TC',
      //                     fontWeight: FontWeight.w400,
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 height: 40,
      //                 child: Text(
      //                   '自訂合約',
      //                   style: TextStyle(
      //                     color: Color(0xFF2B2F35),
      //                     fontSize: 15,
      //                     fontFamily: 'PingFang TC',
      //                     fontWeight: FontWeight.w400,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //     setState(() {
      //       selectedIndex = 4;
      //     });
      //   },
      //   child: Container(
      //     width: 68,
      //     height: 68,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(34),
      //       boxShadow: const [
      //         BoxShadow(
      //           blurRadius: 10,
      //           offset: Offset(0, 0),
      //           color: Color(0x11000000),
      //         ),
      //       ],
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(4),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: const Color(0xFF8C5F42),
      //           borderRadius: BorderRadius.circular(30),
      //         ),
      //         child: Center(
      //           child: SvgPicture.asset(
      //             'assets/icons/frame/auction.svg',
      //             width: 40,
      //             height: 40,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Expanded _buildBottomNavigationBarItem(int index, String iconPath, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28,
              height: 28,
              color: getItemColor(index),
              colorBlendMode: BlendMode.srcIn,
            ),
            Text(label, style: TextStyle(color: getItemColor(index))),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedIndex) {
      case 0:
        return IndexPage();
      case 1:
        return IndexPropertyPage();
      case 2:
        return IndexContractPage();
      case 3:
        return IndexAccountPage();
      case 4:
        return IndexProfilePage();
      default:
        return const Center(child: Text("未知層級"));
    }
  }
}
