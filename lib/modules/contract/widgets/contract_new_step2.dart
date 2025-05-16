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
  List<List<dynamic>> customerData = [
    [false, '', '', '', '', '', '', '',],
  ];
  DateTime effective = DateTime.now();
  DateTime expiration = DateTime.now();
  final TextEditingController controllerNote = TextEditingController();

  List<String> depositTypes= ['每月租金', '固定金額',];
  int rent = 0;
  int depositType = 0;
  int depositMonths = 0;
  late TextEditingController controllerAmount = TextEditingController();
  int total = 0;
  // List<List<dynamic>> costList = [];
  Map<dynamic, dynamic> costList = {};

  late TextEditingController controllerRent;

  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  @override
  void initState() {
    super.initState();
    // final initialValue = ref.read(rentProvider).toString();
    // _controller = TextEditingController(text: initialValue);
    final contractData = ref.read(contractDataProvider);
    rent = contractData['rent'];
    depositMonths = contractData['deposit_months'];
    controllerRent = TextEditingController(text: rent.toString());
    controllerAmount = TextEditingController(text: contractData['deposit_amount'].toString());
    costList = contractData['utility_fees'];
  }

  void updateTotal() {
    setState(() {
      if (depositType == 0) {
        total = rent * depositMonths;
      } else if (depositType == 1) {
        total = rent + int.parse(controllerAmount.text.isEmpty ? '0' : controllerAmount.text);
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
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
                              decoration: const InputDecoration(labelText: '幣別'),
                              value: null,
                              items: const [
                                DropdownMenuItem(value: 'TWD', child: Text('TWD')),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
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
                              controller: controllerRent,
                              decoration: const InputDecoration(labelText: '每月租金'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                rent = int.tryParse(value) ?? 0;
                                ref.read(contractDataProvider.notifier).update((map) => {
                                  ...map,
                                  'rent': rent,
                                });
                                updateTotal();
                              },
                            ),
                          ),
                        ),
                      ],
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
                                  updateTotal();
                                });
                              },
                              activeColor: Color(0xFF8C5F42),
                            ),
                            Text(depositTypes[index]),
                            SizedBox(width: 16),
                          ],
                        );
                      }),
                      // children: [
                      //   Radio(
                      //     value: true,
                      //     groupValue: true,
                      //     onChanged: (_) {},
                      //     activeColor: Color(0xFF8C5F42),
                      //   ),
                      //   const Text('每月租金'),
                      //   const SizedBox(width: 16),
                      //   Radio(
                      //     value: false,
                      //     groupValue: true,
                      //     onChanged: (_) {},
                      //     activeColor: Color(0xFF8C5F42),
                      //   ),
                      //   const Text('固定金額'),
                      // ],
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
                                  ref.read(contractDataProvider.notifier).update((map) => {
                                    ...map,
                                    'deposit_months': depositMonths,
                                  });
                                }
                                updateTotal();
                              });
                            },
                          ),
                          Text('$depositMonths 個月'),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                depositMonths++;
                                ref.read(contractDataProvider.notifier).update((map) => {
                                  ...map,
                                  'deposit_months': depositMonths,
                                });
                                updateTotal();
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
                                ref.read(contractDataProvider.notifier).update((map) => {
                                  ...map,
                                  'deposit_amount': int.parse(value),
                                });
                                updateTotal();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContractNewCost()),
                      ).then((result) {
                        print('生活費用返回');
                        print(ref.read(contractDataProvider)['utility_fees'].length);
                        print(costList);
                      });
                    },
                    child: Text('編輯'),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Column(
                children: List.generate(costList.length, (index) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 16,),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              costList[index][1],
                              style: const TextStyle(
                                color: Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            if (costList[index][0]) ...[
                              const SizedBox(width: 8,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFDCFCE5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  costList[index][4],
                                  style: TextStyle(
                                    color: const Color(0xFF22C555),
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '\$ ${costList[index][5]} ${costList[index][3]}',
                                style: TextStyle(
                                  color: Color(0xFF2B2F35),
                                  fontSize: 15,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ] else ...[
                              const SizedBox(width: 8,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE3E7EA),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  '未註明',
                                  style: TextStyle(
                                    color: const Color(0xFF7B8A95),
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8,),
                        index < costList.length-1 ? const Divider(thickness: 1, color: Color(0xFFCBD2D6)) : SizedBox.shrink(),
                      ],
                    ),
                  );
                }),
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
                        child: Text(DateFormat('yyyy/MM/dd').format(effective)),
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
                        customerData.add([false, '', '', '', '', '', '', '',]);
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
                                                print('result');
                                                print(result);
                                                if (result != null) {
                                                  print('not result');
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
