import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/index_accounts/index_accounts.dart';
import 'package:mylo/modules/index_contract/index_contract.dart';
import 'package:mylo/modules/index_property/index_property.dart';
import 'contract_new/contract_new.dart';

class IndexFrame extends StatefulWidget {
  const IndexFrame({super.key});

  @override
  State<IndexFrame> createState() => _PageFrameState();
}

class _PageFrameState extends State<IndexFrame> {
  int selectedIndex = 0;

  Color getItemColor(int index) {
    return selectedIndex == index ? const Color(0xFF8C5F42) : const Color(0x4C222222);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,),
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
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Image.asset(
                      width: 24,
                      height: 24,
                      'assets/images/contract_new/customer_male.png',
                    ),
                    title: const Text(
                      '林小閔 (4)',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    tilePadding: EdgeInsets.zero,         // 取消標題區的 padding
                    childrenPadding: EdgeInsets.zero,     // 取消展開內容的 padding
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好住社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '勤美學',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '富田ㄧ號',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好睡社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Image.asset(
                      width: 24,
                      height: 24,
                      'assets/images/contract_new/customer_male.png',
                    ),
                    title: const Text(
                      '林小閔 (4)',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    tilePadding: EdgeInsets.zero,         // 取消標題區的 padding
                    childrenPadding: EdgeInsets.zero,     // 取消展開內容的 padding
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好住社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '勤美學',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '富田ㄧ號',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好睡社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Image.asset(
                      width: 24,
                      height: 24,
                      'assets/images/contract_new/customer_male.png',
                    ),
                    title: const Text(
                      '林小閔 (4)',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    tilePadding: EdgeInsets.zero,         // 取消標題區的 padding
                    childrenPadding: EdgeInsets.zero,     // 取消展開內容的 padding
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好住社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '勤美學',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '富田ㄧ號',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好睡社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Image.asset(
                      width: 24,
                      height: 24,
                      'assets/images/contract_new/customer_male.png',
                    ),
                    title: const Text(
                      '林小閔 (4)',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    tilePadding: EdgeInsets.zero,         // 取消標題區的 padding
                    childrenPadding: EdgeInsets.zero,     // 取消展開內容的 padding
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好住社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '勤美學',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '富田ㄧ號',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
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
                        title: Text(
                          '好好睡社區',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 14,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '台北市大安區敦化南路88號',
                          style: TextStyle(
                            color: const Color(0xFF5F6E7B),
                            fontSize: 12,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              _buildBottomNavigationBarItem(
                0,
                'assets/icons/frame/property.svg',
                '物件',),
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
            selectedIndex = 4;
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
            selectedIndex = index;
            if (index == 3) {
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
        return IndexPropertyPage();
      case 1:
        return IndexContractPage();
      case 2:
        return IndexAccountPage();
      default:
        return const Center(child: Text("未知層級"));
    }
  }
}
