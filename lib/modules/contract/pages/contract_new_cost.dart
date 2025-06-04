import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../providers/mylo_provider.dart';
import '../data/api.dart';

class ContractNewCost extends ConsumerStatefulWidget {
  const ContractNewCost({super.key});

  @override
  ConsumerState<ContractNewCost> createState() => _ContractNewCostState();
}

class _ContractNewCostState extends ConsumerState<ContractNewCost> {
  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  // final List<Widget> _customItems = [WaterFeeCard(),];
  List<Map<String, dynamic>> costList = [];
  // Map<String,  dynamic> costList = {};

  List<GlobalKey<_WaterFeeCardState>> _cardKeys = [];

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
    futureData = apiService.fetchCost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final data = ref.watch(contractDataProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          '生活費用',
          style: TextStyle(
            color: Color(0xFF2B2F35),
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              bool hasError = false;

              for (int i = 0; i < costList.length; i++) {
                if (costList[i]['enable'] == true) {
                  // 收費方式為空
                  if (costList[i]['method_name'] == null || costList[i]['method_name'].toString().isEmpty) {
                    _cardKeys[i].currentState?.showMethodValidationError();
                    hasError = true;
                  }
                  if (!(costList[i]['method_name'] == '租客自繳' || costList[i]['method_name'] == '包含在租金')) {
                    // 單價為空
                    if (costList[i]['pricing']['input'] == null || costList[i]['pricing']['input'].toString().isEmpty) {
                      _cardKeys[i].currentState?.showError(true);
                      hasError = true;
                    }
                  }
                }
              }

              if (hasError) {
                Fluttertoast.showToast(msg: "請檢查所有啟用項目的必填欄位");
                return;
              }

              ref.read(contractDataProvider.notifier).update((map) => {
                ...map,
                'utility_fees_temp': costList,
              });
              Navigator.pop(context);
            },
            child: const Text(
              '確認',
              style: TextStyle(
                color: Color(0xFF8C5F42),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: _block(Column(
            children: [
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
                    final contractData = ref.watch(contractDataProvider);
                    if (contractData['utility_fees_temp'].isNotEmpty) {
                      costList = contractData['utility_fees_temp'];
                    } else {
                      dataList = snapshot.data!;
                      costList = List.generate(
                        dataList.length,
                            (index) => {
                          'fee_id': dataList[index]['fee_id'],
                          'fee_name': dataList[index]['fee_name'],
                          'billing_method': dataList[index]['billing_method'],
                          'unit_title': dataList[index]['unit_title'],
                          // 新增欄位
                          'enable': false,
                          'pricing': {
                            'model': 1,
                            'input': null,
                            'currency': 'TWD',
                          },
                          'method_id': null,
                          'method_name': null,
                        },
                      );

                      // costList = {
                      //   for (var item in dataList)
                      //     item['fee_name'].toString(): {
                      //       'selected': false,
                      //       'amount': null,
                      //       "method_id": null,
                      //       'billing_method': item['billing_method'],
                      //       'unit_title': item['unit_title'],
                      //     }
                      // };
                    }
                    _cardKeys.clear(); // 清除舊的
                    _cardKeys = List.generate(costList.length, (index) => GlobalKey<_WaterFeeCardState>());
                  }
                  return Column(
                    children: List.generate(costList.length, (index) {
                      return WaterFeeCard(
                        key: _cardKeys[index],
                        costData: costList[index],
                      );
                    }),

                    // children: costList.entries.map((entry) {
                    //   final index = costList.keys.toList().indexOf(entry.key);
                    //   return WaterFeeCard(
                    //     key: _cardKeys[index],
                    //     costData: entry.value,
                    //   );
                    // }).toList()
                  );
                },
              ),
            ],
          )),
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

class WaterFeeCard extends StatefulWidget {
  final Map<String, dynamic> costData;
  const WaterFeeCard({super.key, required this.costData});

  @override
  State<WaterFeeCard> createState() => _WaterFeeCardState();
}

class _WaterFeeCardState extends State<WaterFeeCard> {
  String? selectedMethod;
  int? selectedMethodId;
  final TextEditingController _controller = TextEditingController();
  bool _showErrorBorder = false;
  bool showMethodError = false;

  List<String> billingTypes= ['每單位', '固定金額',];
  int billing = 0;

  @override
  void initState() {
    super.initState();
    _controller.text = '';
    if (widget.costData['enable']) {
      selectedMethodId = widget.costData['method_id'];
      selectedMethod = widget.costData['method_name'];
      _controller.text = widget.costData['pricing']['input'].toString();
      billing = widget.costData['pricing']['model'];
    }
  }

  void showError(bool show) {
    setState(() {
      _showErrorBorder = show;
    });
  }

  void showMethodValidationError() {
    setState(() {
      showMethodError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDEE2E6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Switch(
                activeColor: const Color(0xFF8C5F42),
                value: widget.costData['enable'],
                onChanged: (val) {
                  setState(() {
                    widget.costData['enable'] = val;
                  });
                },
              ),
              const SizedBox(width: 8),
              Text(
                widget.costData['fee_name'],
                style: const TextStyle(fontSize: 15, fontFamily: 'PingFang TC'),
              ),
            ],
          ),
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.grey, // ← 這裡改未選中的顏色
            ),
            child: Row(
              children: List.generate(billingTypes.length, (index) {
                final isEnabled = widget.costData['enable'];
                return Row(
                  children: [
                    Radio(
                      value: index,
                      groupValue: billing,
                      onChanged: isEnabled
                          ? (value) {
                        setState(() {
                          billing = value as int;
                          widget.costData['pricing']['model'] = billing + 1;
                        });
                      }
                          : null,
                      activeColor: isEnabled ? const Color(0xFF8C5F42) : Colors.grey,
                    ),
                    Text(
                      billingTypes[index],
                      style: TextStyle(
                        color: isEnabled ? Colors.black : Colors.grey, // 禁用時變灰
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F6F7),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: showMethodError ? Colors.red : const Color(0xFFF4F6F7),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: // 收費方式 Dropdown
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: '收費方式',
                      errorText: showMethodError ? '請選擇收費方式' : null,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    value: selectedMethod,
                    items: widget.costData['billing_method'].map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['method_name'],
                        child: Text(item['method_name']),
                      );
                    }).toList(),
                    onChanged: !widget.costData['enable'] ? null : (value) {
                      setState(() {
                        selectedMethod = value!;

                        final selected = widget.costData['billing_method']
                            .firstWhere((item) => item['method_name'] == selectedMethod, orElse: () => null);

                        if (selected != null) {
                          selectedMethodId = selected['method_id'];
                          widget.costData['method_id'] = selectedMethodId;
                        }

                        // widget.costData['method_id'] = selectedMethodId;
                        widget.costData['method_name'] = selectedMethod;
                        showMethodError = false;
                      });
                    },
                  ),
                ),
              ),
              if (!(selectedMethod == '租客自繳' || selectedMethod == '包含在租金')) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F6F7),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: _showErrorBorder ? Colors.red : const Color(0xFFF4F6F7),
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: TextFormField(
                      enabled: widget.costData['enable'],
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: widget.costData['unit_title'],
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          widget.costData['pricing']['input'] = value;
                          if (value.isNotEmpty) {
                            _showErrorBorder = false;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
