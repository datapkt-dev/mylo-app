import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mylo/modules/contract/pages/contract_new_customer.dart';
import '../../../providers/mylo_provider.dart';
import '../data/api.dart';
import '../pages/contract_new_cost.dart';

class ContractNewStep2 extends ConsumerStatefulWidget {
  // 填寫資料
  const ContractNewStep2({super.key});

  @override
  ConsumerState<ContractNewStep2> createState() => _ContractNewStep2State();
}

class _ContractNewStep2State extends ConsumerState<ContractNewStep2> {
  List<dynamic> customerData = [
    // [false, '', '', '', '', '', '', '', []],
  ];
  DateTime? effective;
  DateTime? expiration;
  final TextEditingController controllerNote = TextEditingController();

  List<String> depositTypes= ['每期租金', '固定金額',];
  int? selectedMethodId;
  int rent = 0;
  int depositType = 0;
  int depositMonths = 0;
  late TextEditingController controllerAmount = TextEditingController();
  int total = 0;
  String? selectedExpense;
  List<dynamic> costList = [];
  // Map<dynamic, dynamic> costList = {};

  late TextEditingController controllerRent;

  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late Future<List<dynamic>> futureCostData;
  late List<dynamic> dataList;

  @override
  void initState() {
    super.initState();
    // final initialValue = ref.read(rentProvider).toString();
    // _controller = TextEditingController(text: initialValue);
    final contractData = ref.read(contractDataProvider);
    rent = contractData['rent']['amount'];
    selectedMethodId = contractData['rent']['method_id'];
    // depositMonths = contractData['deposit_months'];
    depositType = contractData['deposit']['deposit_months'] == 0 && contractData['deposit']['deposit_amount'] == null ? 0 : contractData['deposit']['deposit_months'] > 0 ? 0 : 1;
    depositMonths = contractData['deposit']['deposit_months'];
    controllerRent = TextEditingController(text: rent.toString());
    // controllerAmount = TextEditingController(text: contractData['deposit']['deposit_amount'].toString());
    controllerAmount = TextEditingController(
      text: contractData['deposit']?['deposit_amount']?.toString() ?? '',
    );
    effective = contractData['lease_start'] != null
        ? DateTime.parse(contractData['lease_start'])
        : null;
    expiration = contractData['lease_end'] != null
        ? DateTime.parse(contractData['lease_end'])
        : null;
    updateTotal();

    apiService = ApiService(baseUrl: baseUrl);
    futureData = apiService.fetchPayment();
    futureCostData = apiService.fetchCost();
  }

  void updateTotal() {
    setState(() {
      if (depositType == 0) {
        total = rent * depositMonths;
      } else if (depositType == 1) {
        total = (int.tryParse(controllerAmount.text ?? '') ?? 0);
      }
    });
  }

  @override
  void dispose() {
    controllerRent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contractData = ref.watch(contractDataProvider);
    costList = contractData['utility_fees_temp'];
    customerData = contractData['signatories'];
    return SingleChildScrollView(
      child: Column(
        children: [
          _block(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 租金設定區塊
              const Text(
                '費用與押金',
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
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDEE2E6)),
                  borderRadius: BorderRadius.circular(8),
                ),
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
                    const SizedBox(height: 12),
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
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: DropdownButtonFormField<int>(
                                  decoration: const InputDecoration(labelText: '繳費方式'),
                                  value: selectedMethodId,
                                  items: dataList.map((item) {
                                    return DropdownMenuItem<int>(
                                      value: item['method_id'] as int,
                                      child: Text(item['method_name'] as String),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMethodId = value;
                                    });
                                    ref.read(contractDataProvider.notifier).update((map) => {
                                      ...map,
                                      'rent': {
                                        "method_id": selectedMethodId!+2,
                                        "amount": rent,
                                      },
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: controllerRent,
                                  decoration: const InputDecoration(labelText: '每期租金'),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    rent = int.tryParse(value) ?? 0;
                                    ref.read(contractDataProvider.notifier).update((map) => {
                                      ...map,
                                      'rent': {
                                        ...?map['rent'],
                                        "amount": rent,
                                      },
                                    });
                                    updateTotal();
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 押金區塊
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDEE2E6)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.info_outline, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '押金',
                          style: TextStyle(
                            color: Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '計算基準',
                      style: TextStyle(
                        color: Color(0xFF5F6E7B),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(depositTypes.length, (index) {
                        return Row(
                          children: [
                            Radio(
                              value: index,
                              groupValue: depositType,
                              onChanged: (value) {
                                setState(() {
                                  depositType = value!;
                                  if (depositType == 1) {
                                    depositMonths = 0;
                                  }
                                  updateTotal();
                                });
                                ref.read(contractDataProvider.notifier).update((map) => {
                                  ...map,
                                  'deposit': {
                                    "deposit_months": depositMonths,
                                    "deposit_amount": total,
                                  },
                                });
                              },
                              activeColor: Color(0xFF8C5F42),
                            ),
                            Text(depositTypes[index]),
                            SizedBox(width: 16),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (depositType == 0) ...[
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (depositMonths > 0) {
                                  depositMonths--;
                                  // ref.read(contractDataProvider.notifier).update((map) => {
                                  //   ...map,
                                  //   'deposit_months': depositMonths,
                                  // });
                                }
                                updateTotal();
                                ref.read(contractDataProvider.notifier).update((map) => {
                                  ...map,
                                  'deposit': {
                                    "deposit_months": depositMonths,
                                    "deposit_amount": total,
                                  },
                                });
                              });
                            },
                          ),
                          Text('$depositMonths 期'),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                depositMonths++;
                                // ref.read(contractDataProvider.notifier).update((map) => {
                                //   ...map,
                                //   'deposit_months': depositMonths,
                                // });
                                updateTotal();
                                ref.read(contractDataProvider.notifier).update((map) => {
                                  ...map,
                                  'deposit': {
                                    "deposit_months": depositMonths,
                                    "deposit_amount": total,
                                  },
                                });
                              });
                            },
                          ),
                        ]
                        else if (depositType == 1) ...[
                          Container(
                            width: 125,
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F6F7),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            child: TextFormField(
                              controller: controllerAmount,
                              decoration: const InputDecoration(labelText: '押金'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value == '') value = '0';
                                // ref.read(contractDataProvider.notifier).update((map) => {
                                //   ...map,
                                //   'deposit_amount': int.parse(value),
                                // });
                                updateTotal();
                                ref.read(contractDataProvider.notifier).update((map) => {
                                  ...map,
                                  'deposit': {
                                    "deposit_months": depositMonths,
                                    "deposit_amount": total,
                                  },
                                });
                              },
                            ),
                          ),
                        ],
                        const Spacer(),
                        Text(
                          '共計：TWD $total',
                          style: TextStyle(
                            color: Color(0xFF248568),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
          const SizedBox(height: 16,),
          _block(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '生活費用',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final result = await showModalBottomSheet<Map>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setModalState) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: selectedExpense == null
                                        ? _buildExpenseSelection(setModalState)
                                        : _buildExpenseInputForm(setModalState),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                      if (result != null) {
                        print('使用者輸入：$result');
                      }
                      setState(() {
                        selectedExpense = null;
                      });
                    },
                    child: Text('編輯'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContractNewCost()),
                      ).then((result) {
                        print('生活費用返回');
                        print(costList);
                      });
                    },
                    child: Text('編輯'),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Column(
                children: costList
                    .where((item) => item['enable'] == true)
                    .map<Widget>((item) {
                      print(item);
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              item['fee_name'],
                              style: const TextStyle(
                                color: Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDCFCE5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Text(
                                item['method_name'] ?? '未註明',
                                style: const TextStyle(
                                  color: Color(0xFF22C555),
                                  fontSize: 12,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '\$ ${item['pricing']['input'] ?? ''} ${item['unit_title']}',
                              style: const TextStyle(
                                color: Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(thickness: 1, color: Color(0xFFCBD2D6)),
                      ],
                    ),
                  );
                })
                    .toList(),
              )
              // Column(
              //   children: List.generate(costList.length, (index) {
              //     return Container(
              //       width: double.infinity,
              //       padding: const EdgeInsets.only(bottom: 16,),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Text(
              //                 costList[index]['fee_name'],
              //                 style: const TextStyle(
              //                   color: Color(0xFF2B2F35),
              //                   fontSize: 15,
              //                   fontFamily: 'PingFang TC',
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //               if (costList[index]['enable']) ...[
              //                 const SizedBox(width: 8,),
              //                 Container(
              //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //                   decoration: ShapeDecoration(
              //                     color: const Color(0xFFDCFCE5),
              //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              //                   ),
              //                   child: Text(
              //                     costList[index]['method_name'],
              //                     style: TextStyle(
              //                       color: const Color(0xFF22C555),
              //                       fontSize: 12,
              //                       fontFamily: 'PingFang SC',
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ),
              //                 const Spacer(),
              //                 Text(
              //                   '\$ ${costList[index]['pricing']['input'].toString()} ${costList[index]['unit_title']}',
              //                   style: TextStyle(
              //                     color: Color(0xFF2B2F35),
              //                     fontSize: 15,
              //                     fontFamily: 'PingFang TC',
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //               ] else ...[
              //                 const SizedBox(width: 8,),
              //                 Container(
              //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //                   decoration: ShapeDecoration(
              //                     color: const Color(0xFFE3E7EA),
              //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              //                   ),
              //                   child: Text(
              //                     '未註明',
              //                     style: TextStyle(
              //                       color: const Color(0xFF7B8A95),
              //                       fontSize: 12,
              //                       fontFamily: 'PingFang SC',
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ),
              //                 const Spacer(),
              //               ],
              //             ],
              //           ),
              //           const SizedBox(height: 8,),
              //           index < costList.length-1 ? const Divider(thickness: 1, color: Color(0xFFCBD2D6),) : SizedBox.shrink(),
              //         ],
              //       ),
              //     );
              //   }),
              // ),
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
                          ref.read(contractDataProvider.notifier).update((map) => {
                            ...map,
                            // 'lease_start': effective,
                            'lease_start': DateFormat('yyyy-MM-dd').format(effective!),
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
                        child: Text(
                          effective != null
                              ? DateFormat('yyyy/MM/dd').format(effective!)
                              : '選擇生效日期',
                        ),
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
                          ref.read(contractDataProvider.notifier).update((map) => {
                            ...map,
                            // 'lease_end': expiration,
                            'lease_end': DateFormat('yyyy-MM-dd').format(expiration!),
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
                        child: Text(
                          expiration != null
                              ? DateFormat('yyyy/MM/dd').format(expiration!)
                              : '選擇結束日期',
                        ),
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
                      if (customerData.isNotEmpty && customerData.length > 1) {
                        setState(() {
                          customerData.removeLast();
                        });
                      }
                    },
                    child: SvgPicture.asset('assets/icons/contract_new/subtract_button.svg'),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${customerData.length}',
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
                        // customerData.add([false, '', '', '', '', '', '', '', []]);
                        customerData.add({
                          "role": 0,//0:主要簽約人 1:共同簽約人 2:保證人
                          "name": '',
                          "national_id_number": "",
                          "date_of_birth": "",
                          "phone_number": "",
                          "city_name": "",
                          "district_name": "",
                          "detailed_address": "",
                          // "address": {
                          //   "city_name": "",
                          //   "district_name": "",
                          //   "detailed_address": "",
                          // },
                          "id_card_front_url": "",
                          "id_card_back_url":  "",
                        }
                        );
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
                children: List.generate(customerData.length, (index) {
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
                                color: customerData[index]['role'] == 0 ? const Color(0xFFD9F2E5) : const Color(0xFFE3E7EA),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Text(
                                customerData[index]['role'] == 0 ? '主要簽約人' : '共同簽約人',
                                style: TextStyle(
                                  color: customerData[index]['role'] == 0 ? const Color(0xFF248568) : const Color(0xFF7B8A95),
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
                                                  setState(() {
                                                    customerData[index] = {
                                                      "role": result[0],
                                                      "name": result[1],
                                                      "national_id_number": result[2],
                                                      "date_of_birth": result[3],
                                                      "phone_number": result[4],
                                                      "city_name": result[5],
                                                      "district_name": result[6],
                                                      "detailed_address": result[7],
                                                      // "address": {
                                                      //   "city_name": result[5],
                                                      //   "district_name": result[6],
                                                      //   "detailed_address": result[7]
                                                      // },
                                                      "id_card_front_url": result[8][0],
                                                      "id_card_back_url":  result[8][1],
                                                    };
                                                    // customerData.add({
                                                    //   "role": result[0],//0:主要簽約人 1:共同簽約人 2:保證人
                                                    //   "name": result[1],
                                                    //   "national_id_number": result[2],
                                                    //   "date_of_birth": result[3],
                                                    //   "phone_number": result[4],
                                                    //   "address": {
                                                    //     "city_name": result[5],
                                                    //     "district_name": result[6],
                                                    //     "detailed_address": result[7]
                                                    //   },
                                                    //   "id_card_front_url": result[8][0],
                                                    //   "id_card_back_url":  result[8][1],
                                                    // });
                                                  });
                                                  ref.read(contractDataProvider.notifier).update((map) => {
                                                    ...map,
                                                    'signatories': customerData,
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
                                                                setState(() {
                                                                  customerData.removeAt(index);
                                                                });
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
                        if (customerData[index]['role'] == 1) ...[
                          const SizedBox(height: 12,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CircleAvatar(
                              //   radius: 20,
                              //   backgroundColor: Color(0xFFB6E4D0),
                              // ),
                              // SvgPicture.asset('assets/icons/contract_new/customer_female.svg'),
                              Image.asset(width: 20,'assets/images/contract_new/customer_male.png',),
                              const SizedBox(width: 16,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customerData[index]['name'],
                                    style: const TextStyle(
                                      color: Color(0xFF2B2F35),
                                      fontSize: 15,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    customerData[index]['national_id_number'],
                                    style: const TextStyle(
                                      color: Color(0xFF2B2F35),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    customerData[index]['date_of_birth'],
                                    style: const TextStyle(
                                      color: Color(0xFF2B2F35),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    customerData[index]['phone_number'],
                                    style: const TextStyle(
                                      color: Color(0xFF2B2F35),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${(customerData[index]['city_name'] ?? '') + (customerData[index]['district_name'] ?? '') + (customerData[index]['detailed_address'] ?? '')}',
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
                        index < customerData.length-1 ? const Divider(thickness: 1, color: Color(0xFFCBD2D6)) : Container(),
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

  Widget buildExpenseTile({
    required String label,
    required String imagePath,
    required String value,
    required String? selected,
    required void Function() onTap,
  }) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 78,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF319877) : const Color(0xFFF3F3F3),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: const Color(0xFFE3E7EA),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(imagePath),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF5F6E7B),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseSelection(StateSetter setModalState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('生活費用', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  buildExpenseTile(
                    label: '電費',
                    imagePath: 'assets/images/electricity.png',
                    value: 'electricity',
                    selected: selectedExpense,
                    onTap: () {
                      setModalState(() {
                        selectedExpense = '電費';
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  buildExpenseTile(
                    label: '管理費',
                    imagePath: 'assets/images/electricity.png',
                    value: 'electricity',
                    selected: selectedExpense,
                    onTap: () {
                      setModalState(() {
                        selectedExpense = '管理費';
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                children: [
                  buildExpenseTile(
                    label: '水費',
                    imagePath: 'assets/images/electricity.png',
                    value: 'electricity',
                    selected: selectedExpense,
                    onTap: () {
                      setModalState(() {
                        selectedExpense = '水費';
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 78,
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                children: [
                  buildExpenseTile(
                    label: '瓦斯費',
                    imagePath: 'assets/images/electricity.png',
                    value: 'electricity',
                    selected: selectedExpense,
                    onTap: () {
                      setModalState(() {
                        selectedExpense = '瓦斯費';
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 78,
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setModalState(() {
                    // selectedExpense = null; // 點返回，回到支出列表
                  });
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFCBD2D6),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    '返回',
                    style: TextStyle(
                      color: const Color(0xFF2B2F35),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16,),
            Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF319877),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text(
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
          ],
        ),
        const SizedBox(height: 20),
        // 可以加返回、取消等等
      ],
    );
  }

  Widget _buildExpenseInputForm(StateSetter setModalState) {
    TextEditingController amountController = TextEditingController();
    TextEditingController remarkController = TextEditingController();

    List<String> method = ['租客自繳', '含在租金內', '月繳', '季繳', '年繳',];
    int? selectedMethod;

    List<String> billingTypes= ['每單位', '固定金額',];
    int? billing = 0;

    final TextEditingController controller = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$selectedExpense 計費資訊',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        // const SizedBox(height: 16),
        // TextField(
        //   controller: amountController,
        //   keyboardType: TextInputType.number,
        //   decoration: InputDecoration(labelText: '費用金額'),
        // ),
        // const SizedBox(height: 12),
        // TextField(
        //   controller: remarkController,
        //   decoration: InputDecoration(labelText: '備註（可選）'),
        // ),
        // const SizedBox(height: 24),
        // Row(
        //   children: [
        //     Expanded(
        //       child: ElevatedButton(
        //         onPressed: () {
        //           setModalState(() {
        //             selectedExpense = null; // 回到選單畫面
        //           });
        //         },
        //         child: Text('返回'),
        //       ),
        //     ),
        //     const SizedBox(width: 16),
        //     Expanded(
        //       child: ElevatedButton(
        //         onPressed: () {
        //           Navigator.pop(context, {
        //             'type': selectedExpense,
        //             'amount': amountController.text,
        //             'remark': remarkController.text,
        //           });
        //         },
        //         child: Text('儲存'),
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 20),
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.grey, // ← 這裡改未選中的顏色
          ),
          child: Row(
            children: List.generate(billingTypes.length, (index) {
              return Row(
                children: [
                  Radio(
                    value: index,
                    groupValue: billing,
                    onChanged: (value) {
                      setState(() {
                        billing = value;
                        // widget.costData['pricing']['model'] = billing + 1;
                      });
                    },
                    activeColor: const Color(0xFF8C5F42),
                  ),
                  Text(
                    billingTypes[index],
                    style: TextStyle(
                      color: Colors.grey,
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
                      color: const Color(0xFFF4F6F7),
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: // 收費方式 Dropdown
                DropdownButtonFormField<int>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: '收費方式',
                    errorText: null,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  value: selectedMethod,
                  items: List.generate(method.length, (index) {
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text(method[index]),
                    );
                  }),
                  // onChanged: !widget.costData['enable'] ? null : (value) {
                  //   setState(() {
                  //     selectedMethod = value!;
                  //
                  //     final selected = widget.costData['billing_method']
                  //         .firstWhere((item) => item['method_name'] == selectedMethod, orElse: () => null);
                  //
                  //     if (selected != null) {
                  //       selectedMethodId = selected['method_id'];
                  //       widget.costData['method_id'] = selectedMethodId;
                  //     }
                  //
                  //     // widget.costData['method_id'] = selectedMethodId;
                  //     widget.costData['method_name'] = selectedMethod;
                  //     showMethodError = false;
                  //   });
                  // },
                  onChanged: (int? newValue) {
                    // 更新選取的值
                    selectedMethod = newValue;
                    // 如果你在 StatefulWidget 中，記得加 setState()
                    // setState(() {});
                  },
                ),
              ),
            ),
            if (!(selectedMethod == 0 || selectedMethod == 1)) ...[
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
                        color: const Color(0xFFF4F6F7),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: TextFormField(
                    // enabled: widget.costData['enable'],
                    controller: controller,
                    decoration: InputDecoration(
                      // labelText: widget.costData['unit_title'],
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // setState(() {
                      //   widget.costData['pricing']['input'] = value;
                      //   if (value.isNotEmpty) {
                      //     _showErrorBorder = false;
                      //   }
                      // });
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setModalState(() {
                    selectedExpense = null; // 點返回，回到支出列表
                  });
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFCBD2D6),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    '返回',
                    style: TextStyle(
                      color: const Color(0xFF2B2F35),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16,),
            Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF319877),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text(
                      '確定',
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
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class WaterFeeCard extends StatelessWidget {
  const WaterFeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                value: true,
                onChanged: (val) {},
              ),
              const SizedBox(width: 8),
              const Text('水費',
                  style: TextStyle(fontSize: 15, fontFamily: 'PingFang TC')),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
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
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: '收費+方式'),
                    value: '每月',
                    items: const [
                      DropdownMenuItem(value: '每月', child: Text('每月')),
                      DropdownMenuItem(value: '單次', child: Text('單次')),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
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
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: '單價 (TWD)'),
                    keyboardType: TextInputType.number,
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
