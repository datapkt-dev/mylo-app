import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mylo/modules/contract/pages/contract_new.dart';
import 'contract/pages/contract_detail.dart';

class PageFrame extends StatefulWidget {
  const PageFrame({super.key});

  @override
  State<PageFrame> createState() => _PageFrameState();
}

class _PageFrameState extends State<PageFrame> {
  int _selectedIndex = 0;
  int _selectedTab = 0;
  List<Widget> pages = [];
  List<String> tab = ['全部', '待辦', '執行中', '歷史',];
  List<String> status = ['待簽約', '執行中', '已過期',];
  List<Color> statusBlock = [const Color(0xFFFFE4E4), const Color(0xFFD9F2E5), const Color(0xFFE3E7EA),];
  List<Color> statusText = [const Color(0xFFFF4444), const Color(0xFF248568), const Color(0xFF7B8A95),];

  Color _getItemColor(int index) {
    return _selectedIndex == index ? const Color(0xFF8C5F42) : const Color(0x4C222222);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE3C2),
              Color(0xFFC4A580),
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              scrolledUnderElevation: 0,
              centerTitle: false,
              title: const Text(
                '合約',
                style: TextStyle(
                  color: Color(0xFF603E33),
                  fontSize: 20,
                  fontFamily: 'PingFang TC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: const [
                Icon(
                  size: 25,
                  Icons.notifications_none,
                  color: Color(0xFF2B2F35),
                ),
                SizedBox(width: 24),
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF4F6F7),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                    borderRadius: BorderRadius.circular(33),
                  ),
                ),
                child: TextField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: '搜尋關鍵字',
                    hintStyle: TextStyle(
                      color: Color(0xFF5F6E7B),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16,),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                          ),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(tab.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTab = index;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 25,),
                                  decoration: _selectedTab == index ? const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 2, color: Color(0xFF986E49)),
                                    ),
                                  ) : null,
                                  child: Text(
                                    tab[index],
                                    style: TextStyle(
                                      color: _selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF333333),
                                      fontSize: 15,
                                      fontFamily: _selectedTab == index ? 'PingFang SC' : 'PingFang TC',
                                      fontWeight: _selectedTab == index ? FontWeight.w500 : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          const Text(
                            '6筆合約',
                            style: TextStyle(
                              color: Color(0xFF5F6E7B),
                              fontSize: 14,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 200,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text('Modal BottomSheet'),
                                              ElevatedButton(
                                                child: const Text('Close BottomSheet'),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/index/filter.svg',
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(4),
                              const Text(
                                '篩選',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 14,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.70,
                                ),
                              )
                            ],
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/index/sort.svg',
                                color: Colors.black,
                              ),
                              const Gap(4),
                              const Text(
                                '排序',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 14,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.70,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Gap(5),
                      Column(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5,),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Detail()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFE3E7EA)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: ShapeDecoration(
                                            color: statusBlock[index%3],
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                          child: Text(
                                            status[index%3],
                                            style: TextStyle(
                                              color: statusText[index%3],
                                              fontSize: 12,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text(
                                          '2025/11/11 到期',
                                          style: TextStyle(
                                            color: Color(0xFF2B2F35),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(8),
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFE3E7EA),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                          ),
                                        ),
                                        const Gap(12),
                                        const Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '林口套房',
                                                style: TextStyle(
                                                  color: Color(0xFF2B2F35),
                                                  fontSize: 16,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Gap(4),
                                              Text(
                                                '台北市大安區和平西路88號',
                                                style: TextStyle(
                                                  color: Color(0xFF5F6E7B),
                                                  fontSize: 15,
                                                  fontFamily: 'PingFang TC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Gap(8),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor: const Color(0XFFF0F7FE),
                                                  ),
                                                  Gap(4),
                                                  Text(
                                                    '王房客',
                                                    style: TextStyle(
                                                      color: Color(0xFF2B2F35),
                                                      fontSize: 14,
                                                      fontFamily: 'PingFang TC',
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: 0.70,
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
                            )
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              _buildBottomNavigationBarItem(
                0,
                'assets/icons/frame/index.svg',
                '首頁',),
              _buildBottomNavigationBarItem(
                1,
                'assets/icons/frame/contract.svg',
                '合約',
              ),
              const SizedBox(width: 25),
              Container(
                margin: const EdgeInsets.only(top: 28),
                // child: Text(
                //   '靜坐',
                //   style: TextStyle(color: Color(0xFFFF6160),),
                // ),
              ),
              const SizedBox(width: 25),
              _buildBottomNavigationBarItem(
                2,
                'assets/icons/frame/accounts.svg',
                '帳務',
              ),
              _buildBottomNavigationBarItem(
                3,
                'assets/icons/frame/index.svg',
                '我的',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ContractNew()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16,),
                          // color: Colors.red,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '新增合約',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16,),
                        // color: Colors.orange,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '上傳合約',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16,),
                        // color: Colors.yellow,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '自訂合約',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          setState(() {
            _selectedIndex = 4;
          });
        },
        child: Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(34),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 0),
                color: Color(0x11000000),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF8C5F42),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/frame/auction.svg',
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Expanded _buildBottomNavigationBarItem(int index, String iconPath, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28,
              height: 28,
              color: _getItemColor(index),
              colorBlendMode: BlendMode.srcIn,
            ),
            Text(label, style: TextStyle(color: _getItemColor(index))),
          ],
        ),
      ),
    );
  }
}
