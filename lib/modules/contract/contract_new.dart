import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylo/modules/contract/widgets/contract_new_step1.dart';
import 'package:mylo/modules/contract/widgets/contract_new_step2.dart';
import 'package:mylo/modules/contract/widgets/contract_new_step3.dart';
import 'package:mylo/modules/contract/widgets/contract_new_step4.dart';
import 'package:mylo/modules/contract/widgets/contract_new_step5.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'data/api.dart';
import 'package:mylo/providers/mylo_provider.dart';

class ContractNew extends ConsumerStatefulWidget {
  const ContractNew({super.key});

  @override
  ConsumerState<ContractNew> createState() => _ContractNewState();
}

class _ContractNewState extends ConsumerState<ContractNew> {
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

    // 延迟修改 provider，等 build 完再执行
    Future.microtask(() {
      print('初始化新合約');
      // 初始化 contractDataProvider
      ref.read(contractDataProvider.notifier).state = {
        "property_id": 0,
        "lease_start": null,
        "lease_end": null,
        "rent": {
          "method_id": null,//月繳
          "amount": 0,
        },
        "deposit":{
          "deposit_months": 0,      // 0 = 固定金額, 1 = 期數
          "deposit_amount": null,
        },
        // "rent": 0,
        // "deposit_months": 0,
        // "deposit_amount": 0,
        "utility_fees": [],
        // "utility_fees_temp": [],
        "signatories": [],
        "checklist": {
          "appliances": [],
          "furnitures": [],
        },
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final contractData = ref.watch(contractDataProvider);
    int selectedItem = contractData['property_id'];
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
              if (_currentStep > 0) {
                _currentStep -= 1;
              } else {
                Navigator.pop(context);
              }
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
                      _processes[index],
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
                  onTap: () async {
                    final currentData = ref.read(contractDataProvider);
                    if (_currentStep == 0 && currentData['property_id'] == 0) {
                      Fluttertoast.showToast(msg: "請選擇物件");
                    } else if (_currentStep == 2) {
                      final updatedData = ref.read(contractDataProvider);
                      // print(updatedData['utility_fees']);
                      await apiService.postNewContract(updatedData);
                      // setState(() {
                      //   _currentStep = _currentStep+1;
                      // });
                    } else {
                      setState(() {
                        _currentStep = _currentStep+1;
                      });
                    }
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
                ),
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
        return ContractNewStep1();
      case 1:
        return ContractNewStep2();
      case 2:
        return ContractNewStep3();
      case 3:
        return ContractNewStep4();
      case 4:
        return ContractNewStep5();
      default:
        return Center(
          child: Text('不存在頁面'),
        );
    }
  }
}
