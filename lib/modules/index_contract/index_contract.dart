import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../contract_detail/pages/contract_detail.dart';
import '../contract/contract_new.dart';

class IndexContractPage extends StatefulWidget {
  const IndexContractPage({super.key});

  @override
  State<IndexContractPage> createState() => _MainContractState();
}

class _MainContractState extends State<IndexContractPage> {
  int _selectedTab = 0;
  List<String> tab = ['全部', '待辦', '執行中', '歷史',];
  List<String> status = ['待簽約', '執行中', '已過期',];
  List<Color> statusBlock = [const Color(0xFFFFE4E4), const Color(0xFFD9F2E5), const Color(0xFFE3E7EA),];
  List<Color> statusText = [const Color(0xFFFF4444), const Color(0xFF248568), const Color(0xFF7B8A95),];

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          Column(
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
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F6F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                      borderRadius: BorderRadius.circular(33),
                    ),
                  ),
                  child: TextField(
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
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
                            Text(
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
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (BuildContext context) {
                                        List<String> status = ['待簽約', '執行中', '已過期',];
                                        List<String> contractor = ['林業務', '陳業務', '王業務',];
                                        List<String> duration = ['近ㄧ週', '近一個月', '近ㄧ年', '自訂'];
                                        int selectedStatus = -1;
                                        int selectedContractor = -1;
                                        int selectedDuration = -1;
                                        return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState) {
                                            return Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16,),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      '篩選方式',
                                                      style: TextStyle(
                                                        color: Color(0xFF222222),
                                                        fontSize: 16,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Gap(16),
                                                    const Text(
                                                      '合約狀態',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontFamily: 'PingFang TC',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    const Gap(8),
                                                    Row(
                                                      children: List.generate(status.length, (index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedStatus = index;
                                                            });
                                                          },
                                                          child: Container(
                                                            margin: const EdgeInsets.only(right: 8,),
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                            decoration: ShapeDecoration(
                                                              color: index == selectedStatus ? const Color(0xFF248568) : Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(width: 1, color: index == selectedStatus ? const Color(0xFF319877) : const Color(0xFFCBD2D6)),
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '${status[index]}',
                                                              style: TextStyle(
                                                                color: index == selectedStatus ? Colors.white : const Color(0xFF2B2F35),
                                                                fontSize: 15,
                                                                fontFamily: 'PingFang TC',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    const Gap(16),
                                                    const Text(
                                                      '立約人',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontFamily: 'PingFang TC',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    const Gap(8),
                                                    Row(
                                                      children: List.generate(contractor.length, (index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedContractor = index;
                                                            });
                                                          },
                                                          child: Container(
                                                            margin: const EdgeInsets.only(right: 8,),
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                            decoration: ShapeDecoration(
                                                              color: index == selectedContractor ? const Color(0xFF248568) : Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(width: 1, color: index == selectedContractor ? const Color(0xFF319877) : const Color(0xFFCBD2D6)),
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '${contractor[index]}',
                                                              style: TextStyle(
                                                                color: index == selectedContractor ? Colors.white : const Color(0xFF2B2F35),
                                                                fontSize: 15,
                                                                fontFamily: 'PingFang TC',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    const Gap(16),
                                                    const Text(
                                                      '查詢區間',
                                                      style: TextStyle(
                                                        color: Color(0xFF2B2F35),
                                                        fontSize: 15,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Gap(8),
                                                    Row(
                                                      children: List.generate(duration.length, (index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedDuration = index;
                                                            });
                                                          },
                                                          child: Container(
                                                            margin: const EdgeInsets.only(right: 8,),
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                            decoration: ShapeDecoration(
                                                              color: index == selectedDuration ? const Color(0xFF248568) : Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(width: 1, color: index == selectedDuration ? const Color(0xFF319877) : const Color(0xFFCBD2D6)),
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '${duration[index]}',
                                                              style: TextStyle(
                                                                color: index == selectedDuration ? Colors.white : const Color(0xFF2B2F35),
                                                                fontSize: 15,
                                                                fontFamily: 'PingFang TC',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    const Gap(16),
                                                    const Text(
                                                      '自訂查詢區間',
                                                      style: TextStyle(
                                                        color: Color(0xFF2B2F35),
                                                        fontSize: 15,
                                                        fontFamily: 'PingFang TC',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    const Gap(8),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 48,
                                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                                      decoration: ShapeDecoration(
                                                        color: Color(0xFFF4F6F7),
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                                          borderRadius: BorderRadius.circular(3),
                                                        ),
                                                      ),
                                                    ),
                                                    const Gap(16),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedStatus = -1;
                                                                selectedContractor = -1;
                                                                selectedDuration = -1;
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              decoration: ShapeDecoration(
                                                                color: Colors.white,
                                                                shape: RoundedRectangleBorder(
                                                                  side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                                                                  borderRadius: BorderRadius.circular(4),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                '清空重選',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Color(0xFF2B2F35),
                                                                  fontSize: 14,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Gap(16),
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedStatus = -1;
                                                                selectedContractor = -1;
                                                                selectedDuration = -1;
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              decoration: ShapeDecoration(
                                                                color: const Color(0xFF319877),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                              ),
                                                              child: const Text(
                                                                '查詢',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 15,
                                                                  fontFamily: 'PingFang SC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
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
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (BuildContext context) {
                                        String? sort;
                                        return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState) {
                                            return Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16,),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      '排序方式',
                                                      style: TextStyle(
                                                        color: Color(0xFF222222),
                                                        fontSize: 16,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Gap(16),
                                                    ListTile(
                                                      title: const Text(
                                                        '約期：近至遠',
                                                        style: TextStyle(
                                                          color: Color(0xFF2B2F35),
                                                          fontSize: 15,
                                                          fontFamily: 'PingFang TC',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      trailing: Radio<String>(
                                                        value: 'new',
                                                        groupValue: sort,
                                                        onChanged: (String? value) {
                                                          setState(() {
                                                            sort = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: const Text(
                                                        '約期：遠至近',
                                                        style: TextStyle(
                                                          color: Color(0xFF2B2F35),
                                                          fontSize: 15,
                                                          fontFamily: 'PingFang TC',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      trailing: Radio<String>(
                                                        value: 'old',
                                                        groupValue: sort,
                                                        onChanged: (String? value) {
                                                          setState(() {
                                                            sort = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/index/sort.svg',
                                    color: Colors.black,
                                  ),
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
                                      MaterialPageRoute(builder: (context) => Detail(status: index % 3,)),
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
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(4), // 保持與 Container 的圓角一致
                                                child: Image.asset(
                                                  'assets/images/contract_new/item_${index%3}.png',
                                                  fit: BoxFit.cover, // 使用 BoxFit
                                                ),
                                              ),
                                            ),
                                            const Gap(12),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    '林口套房',
                                                    style: TextStyle(
                                                      color: Color(0xFF2B2F35),
                                                      fontSize: 16,
                                                      fontFamily: 'PingFang SC',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  const Gap(4),
                                                  const Text(
                                                    '台北市大安區和平西路88號',
                                                    style: TextStyle(
                                                      color: Color(0xFF5F6E7B),
                                                      fontSize: 15,
                                                      fontFamily: 'PingFang TC',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  const Gap(8),
                                                  Row(
                                                    children: [
                                                      // CircleAvatar(
                                                      //   radius: 12,
                                                      //   backgroundColor: Color(0XFFF0F7FE),
                                                      // ),
                                                      // SvgPicture.asset(
                                                      //   width: 24,
                                                      //   height: 24,
                                                      //   index % 2 == 0
                                                      //       ? 'assets/icons/contract_new/customer_female.svg'
                                                      //       : 'assets/icons/contract_new/customer_male.svg',
                                                      // ),
                                                      Image.asset(
                                                        width: 24,
                                                        height: 24,
                                                        index % 2 == 0
                                                            ? 'assets/images/contract_new/customer_female.png'
                                                            : 'assets/images/contract_new/customer_male.png',
                                                      ),
                                                      const Gap(4),
                                                      const Text(
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
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF8C5F42),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContractNew()),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
