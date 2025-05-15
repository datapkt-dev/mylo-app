import 'package:flutter/material.dart';
import '../data/api.dart';

class ContractNewStep1 extends StatefulWidget {
  // 選擇物件
  const ContractNewStep1({super.key});

  @override
  State<ContractNewStep1> createState() => _ContractNewStep1State();
}

class _ContractNewStep1State extends State<ContractNewStep1> {
  int? _selectedItem;

  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
    futureData = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
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
              textInputAction: TextInputAction.search,
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
              onSubmitted: (value) {
                setState(() {
                  futureData = apiService.fetchData(keyword: value);
                });
              },
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
                if (dataList.isEmpty) {
                  return Center(
                    child: Text('目前沒有物件可供選擇'),
                  );
                }
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
                                  dataList[index]['detailed_address'],
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
}
