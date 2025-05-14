import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
    futureData = apiService.fetchCost();
  }

  void _addCustomItem() {
    setState(() {
      // _customItems.add(const WaterFeeCard());
    });
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
              final filteredList = costList.where((item) => item[0] == true).toList();
              print(filteredList);
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
                          (index) => [false, dataList[index]['fee_name'], dataList[index]['billing_method'], dataList[index]['unit_title'], null, '0'],
                    );
                  }
                  return Column(
                    children: List.generate(dataList.length, (index) {
                      return WaterFeeCard(costData: costList[index]);
                    }),
                  );
                },
              ),
              OutlinedButton.icon(
                onPressed: _addCustomItem,
                icon: const Icon(Icons.add, color: Color(0xFF8C5F42)),
                label: const Text(
                  '新增自訂項目',
                  style: TextStyle(color: Color(0xFF8C5F42)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF8C5F42)),
                  foregroundColor: const Color(0xFF8C5F42), // 按下的 splash 也可跟著變色
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  print(costList);
                },
                icon: const Icon(Icons.add, color: Color(0xFF8C5F42)),
                label: const Text(
                  '測試',
                  style: TextStyle(color: Color(0xFF8C5F42)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF8C5F42)),
                  foregroundColor: const Color(0xFF8C5F42), // 按下的 splash 也可跟著變色
                ),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16,),
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
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'PingFang TC',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F6F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: '收費方式',
                      border: InputBorder.none,
                    ),
                    value: selectedMethod, // 預設選項
                    items: widget.costData[2].map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['method_name'], // 或改用 item['method_id'].toString()
                        child: Text(item['method_name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value!;
                        widget.costData[4] = selectedMethod;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F6F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: widget.costData[3],
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        widget.costData[5] = value;
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
