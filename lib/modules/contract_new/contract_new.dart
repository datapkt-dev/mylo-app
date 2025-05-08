import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mylo/modules/contract_new/pages/contract_new_customer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../units/upload_image_widget.dart';
import '../index_property/data/api.dart';

class ContractNew extends StatefulWidget {
  const ContractNew({super.key});

  @override
  State<ContractNew> createState() => _ContractNewState();
}

class _ContractNewState extends State<ContractNew> {
  final int _totalStages = 5;
  final List<String> _processes = ['選擇物件', '填寫資料', '屋況點交', '預覽合約', '完成合約',];
  int _currentStep = 0;

  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;

  late Future<List<dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
    futureData = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF2B2F35),
          ),
          onPressed: () {
            setState(() {
              _currentStep > 0
                  ? _currentStep-=1
                  : Navigator.pop(context);
            });
          },
        ),
        title: Text(
          _processes[_currentStep],
          style: const TextStyle(
            color: Color(0xFF2B2F35),
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 10,),
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
                    padding: const EdgeInsets.only(top: 10,),
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
                  if (index <= _currentStep) {
                    // 完成的節點
                    if (index == _currentStep) {
                      return const DotIndicator(
                        size: 16,
                        color: Color(0xFFB6E4D0),
                        child: DotIndicator(
                          size: 8,
                          color: Color(0xFF248568),
                        ),
                      );
                    } else {
                      return const DotIndicator(
                        size: 10,
                        color: Color(0xFF248568),
                      );
                    }
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
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildLayer(),
            ),
          ),
          if (_currentStep != 4) ...[
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentStep = _currentStep+1;
                      });
                    },
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
                  )
              ),
            ),
          ],
        ],
      )
    );
  }

  Widget _buildLayer() {
    switch (_currentStep) {
      case 0:
        return step0();
      case 1:
        return step1();
      case 2:
        return step2();
      case 3:
        return step3();
      case 4:
        return step4();
      default:
        return Center(
          child: Text('不存在頁面'),
        );
    }
  }

  int _selectedItem = -1;
  late List<dynamic> dataList;

  Widget step0() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          SizedBox(height: 16,),
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
              }
              return Column(
                children: List.generate(dataList.length, (index) {
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4), // 保持與 Container 的圓角一致
                              child: Image.asset(
                                'assets/images/contract_new/item_${index%3}.png',
                                fit: BoxFit.cover, // 使用 BoxFit
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataList[index]['title'],
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 4,),
                                Text(
                                  dataList[index]['address'],
                                  style: TextStyle(
                                    color: Color(0xFF5F6E7B),
                                    fontSize: 12,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 16,),
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
              );
            },
          ),
        ],
      ),
    );
  }

  int count = 1;
  List<List<dynamic>> customerData = [
    [false, '團團', 'H123456789', '2005/12/01', '0912345678', '台中市', '大雅區', '民生路三段315號',],
    [false, '林旺', 'A987654321', '2000/01/01', '0987654321', '台中市', '大雅區', '民生路三段315號'],
    [false, '', '', '', '', ''],
  ];
  final TextEditingController controllerDeposit = TextEditingController();
  final TextEditingController controllerRent = TextEditingController();
  final TextEditingController controllerElectricity = TextEditingController();
  DateTime effective = DateTime.now();
  DateTime expiration = DateTime.now();
  final TextEditingController controllerNote = TextEditingController();

  Widget step1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '費用',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    '這裡是寫一些說明的地方沒有也可不寫',
                    style: TextStyle(
                      color: Color(0xFF5F6E7B),
                      fontSize: 12,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '押金(月)',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 15,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controllerDeposit,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Color(0xFF2B2F35),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    const Text(
                                      '元/月',
                                      style: TextStyle(
                                        color: Color(0xFF2B2F35),
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '租金(月)',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 15,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controllerRent,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Color(0xFF2B2F35),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    const Text(
                                      '元/月',
                                      style: TextStyle(
                                        color: Color(0xFF2B2F35),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '電度(度)',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF4F6F7),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controllerElectricity,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const Text(
                              '元/度',
                              style: TextStyle(
                                color: Color(0xFF2B2F35),
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
                ],
              )),
              const SizedBox(height: 16,),
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '合約起訖日',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    '這裡是寫一些說明的地方沒有也可不寫',
                    style: TextStyle(
                      color: Color(0xFF5F6E7B),
                      fontSize: 12,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      const Text(
                        '生效日',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            var result = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023, 01),
                              lastDate: DateTime(2026, 12),
                              locale: const Locale('zh', 'TW'),
                            );
                            if (result != null) {
                              setState(() {
                                effective = result;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F6F7),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            child: Text('${DateFormat('yyyy/MM/dd').format(effective)}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      const Text(
                        '結束日',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            var result = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023, 01),
                              lastDate: DateTime(2026, 12),
                            );
                            if (result != null) {
                              setState(() {
                                expiration = result;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F6F7),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            child: Text(DateFormat('yyyy/MM/dd').format(expiration)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
              const SizedBox(height: 16,),
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '選擇簽約人數',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      const Text(
                        '人數',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            count > 1 ? count -= 1 : null;
                          });
                        },
                        child: SvgPicture.asset('assets/icons/contract_new/subtract_button.svg'),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$count',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            count < 3 ? count += 1 : null;
                          });
                        },
                        child: SvgPicture.asset('assets/icons/contract_new/add_button.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    '填寫簽約資料',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Column(
                    children: List.generate(count, (index) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 16,),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '簽約人 ${index+1}',
                                  style: const TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: ShapeDecoration(
                                    color: customerData[index][0] == true ? const Color(0xFFD9F2E5) : const Color(0xFFE3E7EA),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Text(
                                    customerData[index][0] == true ? '已完成' : '未完成',
                                    style: TextStyle(
                                      color: customerData[index][0] == true ? const Color(0xFF248568) : const Color(0xFF7B8A95),
                                      fontSize: 12,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.60,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: const Center(
                                                    child: Text(
                                                      '編輯簽約人',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(0xFF007AFF),
                                                        fontSize: 17,
                                                        fontFamily: 'PingFang TC',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                ),
                                                onTap: () {
                                                  // 編輯簽約人操作
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ContractNewCustomer(dataPass: customerData[index],)),
                                                  ).then((result) {
                                                    if (result != null) {
                                                      print(result);
                                                      setState(() {
                                                        customerData[index] = result;
                                                      });
                                                    }
                                                  });
                                                },
                                              ),
                                              Divider(height: 1, color: Colors.grey.shade300),
                                              ListTile(
                                                title: const Center(
                                                    child: Text(
                                                      '刪除簽約人',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(0xFFFF3B30),
                                                        fontSize: 17,
                                                        fontFamily: 'PingFang TC',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                ),
                                                onTap: () {
                                                  // 刪除簽約人操作
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor: const Color(0xFFFFDFDF).withOpacity(0.4),
                                                              child: CircleAvatar(
                                                                radius: 16,
                                                                backgroundColor: const Color(0xFFFFDFDF),
                                                                child: SvgPicture.asset('assets/icons/contract_new/trash.svg'),
                                                              ),
                                                            ),
                                                            const SizedBox(height: 16,),
                                                            const Text(
                                                              '刪除此簽約人',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Color(0xFF2B2F35),
                                                                fontSize: 16,
                                                                fontFamily: 'PingFang SC',
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            const SizedBox(height: 8,),
                                                            const Text(
                                                              '您是否要刪除此簽約人？',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Color(0xFF5F6E7B),
                                                                fontSize: 15,
                                                                fontFamily: 'PingFang TC',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Expanded(
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    height: 38,
                                                                    alignment: Alignment.center,
                                                                    decoration: ShapeDecoration(
                                                                      color: Colors.white,
                                                                      shape: RoundedRectangleBorder(
                                                                        side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                                                                        borderRadius: BorderRadius.circular(4),
                                                                      ),
                                                                    ),
                                                                    child: const Text(
                                                                      '取消',
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
                                                              const SizedBox(width: 12,),
                                                              Expanded(
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    height: 38,
                                                                    alignment: Alignment.center,
                                                                    decoration: ShapeDecoration(
                                                                      color: Colors.white,
                                                                      shape: RoundedRectangleBorder(
                                                                        side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                                                                        borderRadius: BorderRadius.circular(4),
                                                                      ),
                                                                    ),
                                                                    child: const Text(
                                                                      '刪除',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        color: Color(0xFFFF4444),
                                                                        fontSize: 14,
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
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              Divider(height: 1, color: Colors.grey.shade300),
                                              ListTile(
                                                title: const Center(
                                                  child: Text(
                                                    '取消',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFF007AFF),
                                                      fontSize: 17,
                                                      fontFamily: 'PingFang TC',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    '編輯',
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
                            if (customerData[index][0] == true) ...[
                              const SizedBox(width: 12,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CircleAvatar(
                                  //   radius: 20,
                                  //   backgroundColor: Color(0xFFB6E4D0),
                                  // ),
                                  // SvgPicture.asset('assets/icons/contract_new/customer_female.svg'),
                                  Image.asset(width: 20,'assets/images/contract_new/customer_male.png',),
                                  const SizedBox(height: 16,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        customerData[index][1],
                                        style: const TextStyle(
                                          color: Color(0xFF2B2F35),
                                          fontSize: 15,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        customerData[index][2],
                                        style: const TextStyle(
                                          color: Color(0xFF2B2F35),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        customerData[index][3],
                                        style: const TextStyle(
                                          color: Color(0xFF2B2F35),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        customerData[index][4],
                                        style: const TextStyle(
                                          color: Color(0xFF2B2F35),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        customerData[index][5]+customerData[index][6]+customerData[index][7],
                                        style: const TextStyle(
                                          color: Color(0xFF2B2F35),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                            const SizedBox(height: 8,),
                            index < count-1 ? const Divider(thickness: 1, color: Color(0xFFCBD2D6)) : Container(),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              )),
              const SizedBox(height: 16,),
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '備註',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F6F7),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: TextField(
                      controller: controllerNote,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: '請輸入備註',
                        hintStyle: TextStyle(
                          color: Color(0xFF7B8A95),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  List<List<dynamic>> furniture = [
    ['雙人床床架', false, [], ''],
    ['床頭櫃', false, [], ''],
    ['沙發', false, [], ''],
  ];
  List<List<dynamic>> appliance = [
    ['電風扇', false, [], ''],
    ['冰箱', false, [], ''],
    ['電視', false, [], ''],
    ['電視遙控器', false, [], ''],
    ['冷氣', false, [], ''],
    ['冷氣遙控器', false, [], ''],
  ];
  List<dynamic> imgRoute = [];
  final TextEditingController descriptionController = TextEditingController();

  Widget step2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _block(Column(
            children: [
              Row(
                children: [
                  const Text(
                    '家具',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    '${furniture.length}項',
                    style: const TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16,),
              Column(
                children: List.generate(furniture.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < furniture.length-1 ? 16 : 0,),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        furniture[index][2] != []
                                            ? imgRoute = furniture[index][2]
                                            : imgRoute = [];
                                        furniture[index][3] != ''
                                            ? descriptionController.text = furniture[index][3]
                                            : descriptionController.text = '';
                                        final result = await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(16),),
                                          ),
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom,
                                              ),
                                              child: StatefulBuilder(
                                                builder: (BuildContext context, StateSetter setState) {
                                                  return Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16,),
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '${furniture[index][0]}',
                                                            style: const TextStyle(
                                                              color: Color(0xFF222222),
                                                              fontSize: 18,
                                                              fontFamily: 'PingFang TC',
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 12,),
                                                          Wrap(
                                                            runSpacing: 12,
                                                            spacing: 12,
                                                            children: List.generate(imgRoute.length+1, (index) {
                                                              if (index == imgRoute.length) {
                                                                if (imgRoute.length < 4) {
                                                                  return UploadImageWidget(
                                                                    onImagePicked: (path) {
                                                                      if (imgRoute.length<4) {
                                                                        if (path.isNotEmpty) {
                                                                          setState(() {
                                                                            imgRoute.add(path);
                                                                          });
                                                                        }
                                                                        else {
                                                                          print("Invalid file path.");
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                      width: 80,
                                                                      height: 80,
                                                                      alignment: Alignment.center,
                                                                      decoration: ShapeDecoration(
                                                                        color: Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: Color(0xFF319877)),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          SvgPicture.asset(
                                                                            width: 14,
                                                                            height: 14,
                                                                            'assets/icons/contract_new/camera.svg',
                                                                          ),
                                                                          const SizedBox(height: 8,),
                                                                          Text(
                                                                            '上傳 $index/4',
                                                                            style: const TextStyle(
                                                                              color: Color(0xFF5F6E7B),
                                                                              fontSize: 14,
                                                                              fontFamily: 'PingFang TC',
                                                                              fontWeight: FontWeight.w400,
                                                                              letterSpacing: 0.70,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              } else {
                                                                return Stack(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 80,
                                                                      height: 80,
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        child: Image.file(
                                                                          File(imgRoute[index]),
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      top: 3,
                                                                      right: 4,
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            imgRoute.removeAt(index);
                                                                          });
                                                                        },
                                                                        child: SvgPicture.asset('assets/icons/contract_new/delete.svg'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                            }),
                                                          ),
                                                          const SizedBox(height: 8,),
                                                          const Text(
                                                            '備註',
                                                            style: TextStyle(
                                                              color: Color(0xFF2B2F35),
                                                              fontSize: 15,
                                                              fontFamily: 'PingFang TC',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 8,),
                                                          Container(
                                                            height: 48,
                                                            width: double.infinity,
                                                            padding: const EdgeInsets.symmetric(horizontal: 16,),
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFFF4F6F7),
                                                              shape: RoundedRectangleBorder(
                                                                side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                                                borderRadius: BorderRadius.circular(3),
                                                              ),
                                                            ),
                                                            child: TextField(
                                                              controller: descriptionController,
                                                              maxLines: 1,
                                                              decoration: const InputDecoration(
                                                                hintText: '備註說明',
                                                                hintStyle: TextStyle(
                                                                  color: Color(0xFF2B2F35),
                                                                  fontSize: 15,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                border: InputBorder.none,
                                                              ),
                                                              onChanged: (value) {},
                                                            ),
                                                          ),
                                                          const SizedBox(height: 24,),
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (imgRoute.isNotEmpty) {
                                                                List<dynamic> img = [imgRoute, descriptionController.text];
                                                                Navigator.pop(context, img);
                                                              } else {
                                                                Navigator.pop(context, '');
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: double.infinity,
                                                              alignment: Alignment.center,
                                                              decoration: ShapeDecoration(
                                                                color: const Color(0xFF8C5F42),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                              ),
                                                              child: const Text(
                                                                '確定',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                        if (result == null) {
                                          print("使用者未點擊確定，返回值為 null");
                                        } else {
                                          setState(() {
                                            furniture[index][2] = result[0];
                                            furniture[index][3] = result[1];
                                            furniture[index][1] = true;
                                          });
                                        }
                                      },
                                      child: SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                    ),
                                    const SizedBox(width: 8,),
                                    Text(
                                      '${furniture[index][0]} X1',
                                      style: const TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  '\$5600',
                                  style: TextStyle(
                                    color: Color(0xFF5F6E7B),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.70,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: furniture[index][1],
                                activeColor: const Color(0xFF8C5F42),
                                onChanged: (bool value) async {
                                  setState(() {
                                    furniture[index][1] = !furniture[index][1];
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (furniture[index][2].isNotEmpty && furniture[index][1]) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F6F7),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Wrap(
                                  runSpacing: 12,
                                  spacing: 12,
                                  children: List.generate(furniture[index][2].length, (indexNd) {
                                    return SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.file(
                                          File(furniture[index][2][indexNd]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                Text(
                                  '${furniture[index][3]}',
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
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ),
              const Divider(height: 48, thickness: 1, color: Color(0xFFCBD2D6),),
              Row(
                children: [
                  const Text(
                    '家電',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    '${appliance.length}項',
                    style: const TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Column(
                children: List.generate(appliance.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < appliance.length-1 ? 16 : 0,),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        appliance[index][2] != []
                                            ? imgRoute = appliance[index][2]
                                            : imgRoute = [];
                                        appliance[index][3] != ''
                                            ? descriptionController.text = appliance[index][3]
                                            : descriptionController.text = '';
                                        final result = await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                          ),
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom,
                                              ),
                                              child: StatefulBuilder(
                                                builder: (BuildContext context, StateSetter setState) {
                                                  return Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16,),
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '${appliance[index][0]}',
                                                            style: const TextStyle(
                                                              color: Color(0xFF222222),
                                                              fontSize: 18,
                                                              fontFamily: 'PingFang TC',
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 12,),
                                                          Wrap(
                                                            runSpacing: 12,
                                                            spacing: 12,
                                                            children: List.generate(imgRoute.length+1, (index) {
                                                              if (index == imgRoute.length) {
                                                                return UploadImageWidget(
                                                                  onImagePicked: (path) {
                                                                    if (imgRoute.length<4) {
                                                                      if (path.isNotEmpty) {
                                                                        setState(() {
                                                                          imgRoute.add(path);
                                                                        });
                                                                      }
                                                                      else {
                                                                        print("Invalid file path.");
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                    width: 80,
                                                                    height: 80,
                                                                    alignment: Alignment.center,
                                                                    decoration: ShapeDecoration(
                                                                      color: Colors.white,
                                                                      shape: RoundedRectangleBorder(
                                                                        side: const BorderSide(width: 1, color: Color(0xFF319877)),
                                                                        borderRadius: BorderRadius.circular(3),
                                                                      ),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                          width: 14,
                                                                          height: 14,
                                                                          'assets/icons/contract_new/camera.svg',
                                                                        ),
                                                                        const SizedBox(height: 8,),
                                                                        Text(
                                                                          '上傳 $index/4',
                                                                          style: const TextStyle(
                                                                            color: Color(0xFF5F6E7B),
                                                                            fontSize: 14,
                                                                            fontFamily: 'PingFang TC',
                                                                            fontWeight: FontWeight.w400,
                                                                            letterSpacing: 0.70,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return SizedBox(
                                                                  width: 80,
                                                                  height: 80,
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(3),
                                                                    child: Image.file(
                                                                      File(imgRoute[index]),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            }),
                                                          ),
                                                          const SizedBox(height: 8,),
                                                          const Text(
                                                            '備註',
                                                            style: TextStyle(
                                                              color: Color(0xFF2B2F35),
                                                              fontSize: 15,
                                                              fontFamily: 'PingFang TC',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 8,),
                                                          Container(
                                                            height: 48,
                                                            width: double.infinity,
                                                            padding: const EdgeInsets.symmetric(horizontal: 16,),
                                                            decoration: ShapeDecoration(
                                                              color: const Color(0xFFF4F6F7),
                                                              shape: RoundedRectangleBorder(
                                                                side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                                                borderRadius: BorderRadius.circular(3),
                                                              ),
                                                            ),
                                                            child: TextField(
                                                              controller: descriptionController,
                                                              maxLines: 1,
                                                              decoration: const InputDecoration(
                                                                hintText: '備註說明',
                                                                hintStyle: TextStyle(
                                                                  color: Color(0xFF2B2F35),
                                                                  fontSize: 15,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                                border: InputBorder.none,
                                                              ),
                                                              onChanged: (value) {},
                                                            ),
                                                          ),
                                                          const SizedBox(height: 24,),
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (imgRoute.isNotEmpty) {
                                                                List<dynamic> img = [imgRoute, descriptionController.text];
                                                                Navigator.pop(context, img);
                                                              } else {
                                                                Navigator.pop(context, '');
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: double.infinity,
                                                              alignment: Alignment.center,
                                                              decoration: ShapeDecoration(
                                                                color: const Color(0xFF8C5F42),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                              ),
                                                              child: const Text(
                                                                '確定',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                        if (result == null) {
                                          print("使用者未點擊確定，返回值為 null");
                                        } else {
                                          setState(() {
                                            appliance[index][2] = result[0];
                                            appliance[index][3] = result[1];
                                            appliance[index][1] = true;
                                          });
                                        }
                                      },
                                      child: SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                    ),
                                    const SizedBox(width: 8,),
                                    Text(
                                      '${appliance[index][0]} X1',
                                      style: const TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  '\$5600',
                                  style: TextStyle(
                                    color: Color(0xFF5F6E7B),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.70,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: appliance[index][1],
                                activeColor: const Color(0xFF8C5F42),
                                onChanged: (bool value) async {
                                  setState(() {
                                    appliance[index][1] = !appliance[index][1];
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (appliance[index][2].isNotEmpty && appliance[index][1]) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F6F7),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Wrap(
                                  runSpacing: 12,
                                  spacing: 12,
                                  children: List.generate(appliance[index][2].length, (indexNd) {
                                    return SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.file(
                                          File(appliance[index][2][indexNd]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                Text(
                                  appliance[index][3],
                                  style: const TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),),
          const SizedBox(height: 16,),
          _block(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '影片',
                style: TextStyle(
                  color: Color(0xFF2B2F35),
                  fontSize: 15,
                  fontFamily: 'PingFang TC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFF319877)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/contract_new/video-recorder.svg'),
                      const SizedBox(height: 8,),
                      const Text(
                        '上傳1/1',
                        style: TextStyle(
                          color: Color(0xFF5F6E7B),
                          fontSize: 14,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.70,
                        ),
                      )
                    ],
                  )
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget step3() {
    return Column(
      children: [
        const Text(
          '合約名稱ＯＯＯＯＯＯＯ',
          style: TextStyle(
            color: Color(0xFF2B2F35),
            fontSize: 15,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: SfPdfViewer.network('https://rencoo.com.tw/images/contract.pdf'),
          ),
        ),
      ],
    );
  }

  Widget step4() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30,),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '好宅紹區套房10F-1',
              style: TextStyle(
                color: Color(0xFF2B2F35),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: QrImageView(
                data: 'This is a simple QR code',
                version: QrVersions.auto,
                size: 150,
                gapless: false,
              ),
            ),
            const SizedBox(height: 30,),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '簽約人 1',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '簽約人 2',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '簽約人 3',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '立約人 ',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '合約起迄日',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '合約編號',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '團團',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '林旺',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '李ＯＯ',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '林業務',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '2024/12/11 ～2025/12/10',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'RENT20241211001',
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 38,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF8C5F42),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text(
                        '完成',
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
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Container(
                    height: 38,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      '分享',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
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
  }

  Widget _block(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
