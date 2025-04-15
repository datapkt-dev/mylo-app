import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/main_accounts/main_accounts.dart';
import 'package:mylo/modules/main_contract/main_contract.dart';
import 'contract_new/pages/contract_new.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _PageFrameState();
}

class _PageFrameState extends State<IndexPage> {
  int content = 1;

  int _selectedIndex = 0;

  Color _getItemColor(int index) {
    return _selectedIndex == index ? const Color(0xFF8C5F42) : const Color(0x4C222222);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            backgroundColor: Colors.white,
            context: context,
            builder: (BuildContext context) {
              return Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.only(top: 48, left: 16, right: 16,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ContractNew()),
                        );
                      },
                      child: const SizedBox(
                        height: 40,
                        child: Text(
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
                    const SizedBox(
                      height: 40,
                      child: Text(
                        '上傳合約',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                      child: Text(
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
            content = index;
            if (index == 0 || index == 3) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('尚未開放'),
                    content: Text('該功能尚未開放，敬請期待！'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();  // 關閉對話框
                        },
                        child: Text('確定'),
                      ),
                    ],
                  );
                },
              );
            }
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

  Widget _buildContent() {
    switch (content) {
      case 1:
        return MainContract();
      case 2:
        return MainAccounts();
      default:
        return const Center(child: Text("未知層級"));
    }
  }
}
