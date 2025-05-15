import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/api.dart';

class ContractNewCost extends StatefulWidget {
  const ContractNewCost({super.key});

  @override
  State<ContractNewCost> createState() => _ContractNewCostState();
}

class _ContractNewCostState extends State<ContractNewCost> {
  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  // final List<Widget> _customItems = [WaterFeeCard(),];
  List<List<dynamic>> costList = [];

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
                if (costList[i][0] == true) {
                  // 收費方式為空
                  if (costList[i][4] == null || costList[i][4].toString().isEmpty) {
                    _cardKeys[i].currentState?.showMethodValidationError();
                    hasError = true;
                  }
                  // 單價為空
                  if (costList[i][5] == null || costList[i][5].toString().isEmpty) {
                    _cardKeys[i].currentState?.showError(true);
                    hasError = true;
                  }
                }
              }

              if (hasError) {
                Fluttertoast.showToast(msg: "請檢查所有啟用項目的必填欄位");
                return;
              }

              final filteredList = costList.where((item) => item[0] == true).toList();
              Navigator.pop(context, filteredList);
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
                    dataList = snapshot.data!;
                    costList = List.generate(
                      dataList.length,
                          (index) => [false, dataList[index]['fee_name'], dataList[index]['billing_method'], dataList[index]['unit_title'], null, ''],
                    );
                    _cardKeys.clear(); // 清除舊的
                    _cardKeys = List.generate(dataList.length, (index) => GlobalKey<_WaterFeeCardState>());
                  }
                  return Column(
                    children: List.generate(dataList.length, (index) {
                      return WaterFeeCard(
                        key: _cardKeys[index],
                        costData: costList[index],
                      );
                    }),
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
  final List<dynamic> costData;
  const WaterFeeCard({super.key, required this.costData});

  @override
  State<WaterFeeCard> createState() => _WaterFeeCardState();
}

class _WaterFeeCardState extends State<WaterFeeCard> {
  String? selectedMethod;
  final TextEditingController _controller = TextEditingController();
  bool _showErrorBorder = false;
  bool showMethodError = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.costData[5] ?? '';
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
                value: widget.costData[0],
                onChanged: (val) {
                  setState(() {
                    widget.costData[0] = val;
                  });
                },
              ),
              const SizedBox(width: 8),
              Text(
                widget.costData[1],
                style: const TextStyle(fontSize: 15, fontFamily: 'PingFang TC'),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                    items: widget.costData[2].map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['method_name'],
                        child: Text(item['method_name']),
                      );
                    }).toList(),
                    onChanged: !widget.costData[0] ? null : (value) {
                      setState(() {
                        selectedMethod = value!;
                        widget.costData[4] = selectedMethod;
                        showMethodError = false;
                      });
                    },
                  ),
                ),
              ),
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
                    enabled: widget.costData[0],
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: widget.costData[3],
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        widget.costData[5] = value;
                        if (value.isNotEmpty) {
                          _showErrorBorder = false;
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
