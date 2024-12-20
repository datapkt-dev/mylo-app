import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timelines/timelines.dart';

class ContractNew extends StatefulWidget {
  const ContractNew({super.key});

  @override
  State<ContractNew> createState() => _ContractNewState();
}

class _ContractNewState extends State<ContractNew> {
  final int _totalStages = 5;
  final List<String> _processes = ['選擇物件', '填寫資料', '屋況點交', '預覽合約', '完成合約',];
  int _currentStage = 0;
  int _selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          '選擇物件',
          style: TextStyle(
            color: Color(0xFF2B2F35),
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          alignment: Alignment.topCenter,
                          child: Timeline.tileBuilder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            theme: TimelineThemeData(
                              direction: Axis.horizontal,
                              connectorTheme: const ConnectorThemeData(space: 8.0, thickness: 1.0),
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              itemCount: _totalStages,
                              itemExtentBuilder: (_, __) {
                                return (MediaQuery.of(context).size.width - 30) / _totalStages;
                              },
                              oppositeContentsBuilder: (context, index) {
                                return Container();
                              },
                              contentsBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(top: 10,),
                                  child: Text(
                                    '${_processes[index]}',
                                    style: const TextStyle(
                                      color: Color(0xFF2B2F35),
                                      fontSize: 14,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.70,
                                    ),
                                  ),
                                );
                              },
                              indicatorBuilder: (_, index) {
                                if (index <= _currentStage) {
                                  // 完成的節點
                                  return const DotIndicator(
                                    size: 10.0,
                                    color: Color(0xFF248568),
                                  );
                                } else {
                                  // 未完成的節點
                                  return const DotIndicator(
                                    size: 10.0,
                                    color: Color(0xFFE3E7EA),
                                  );
                                }
                              },
                              connectorBuilder: (_, index, type) {
                                return const SolidLineConnector(
                                  color: Color(0xFFE3E7EA),
                                  thickness: 1.0,
                                );

                              },
                            ),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF4F6F7),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          child: TextField(
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: '搜尋物件',
                              hintStyle: TextStyle(
                                color: Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF5F6E7B),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: List.generate(6, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedItem = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16,),
                            padding: const EdgeInsets.all(16),
                            decoration: ShapeDecoration(
                              color: _selectedItem == index ? const Color(0xFFF7F4EF) : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: _selectedItem == index ? const Color(0xFF8C5F42) : const Color(0xFFDEE2E6),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFE3E7EA),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                const Gap(10),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '物件A',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Gap(4),
                                      Text(
                                        '台北市大安區和平西路88號',
                                        style: TextStyle(
                                          color: Color(0xFF5F6E7B),
                                          fontSize: 12,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Gap(16),
                                      Text(
                                        '套房',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14,
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
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 56,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 21),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33333333),
                    blurRadius: 4,
                    offset: Offset(0, -2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: const Color(0xFF8C5F42),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text(
                  '下一步',
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
          )
        ],
      )
    );
  }
}
