import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mylo/modules/contract/pages/contract_new_customer.dart';
import '../../../providers/mylo_provider.dart';
import '../data/api.dart';
import '../pages/contract_new_cost.dart';
import 'block_container.dart';

class ContractNewStep2 extends ConsumerStatefulWidget {
  // 填寫資料
  const ContractNewStep2({super.key});

  @override
  ConsumerState<ContractNewStep2> createState() => _ContractNewStep2State();
}

class _ContractNewStep2State extends ConsumerState<ContractNewStep2> {
  List<dynamic> customerData = [];
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
  int? selectedExpenseId;
  int selected = -1;
  List<dynamic> costList = [];

  late TextEditingController controllerRent;

  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;
  late List<dynamic> expenseData;

  @override
  void initState() {
    super.initState();
    final contractData = ref.read(contractDataProvider);
    rent = contractData['rent']['amount'];
    selectedMethodId = contractData['rent']['method_id'];
    depositType = contractData['deposit']['deposit_months'] == 0 && contractData['deposit']['deposit_amount'] == null ? 0 : contractData['deposit']['deposit_months'] > 0 ? 0 : 1;
    depositMonths = contractData['deposit']['deposit_months'];
    controllerRent = TextEditingController(text: rent.toString());
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
    loadData();
  }

  void loadData() async {
    expenseData = await apiService.fetchCost();
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

  void initBottomSheet() {
    setState(() {
      selectedExpense = null;
      selectedExpenseId = null;
    });
  }

  void updateDepositAndTotal() {
    ref.read(contractDataProvider.notifier).update((map) => {
      ...map,
      'deposit': {
        "deposit_months": depositMonths,
        "deposit_amount": total,
      },
    });
  }

  Future<dynamic> showExpenseBottomSheet(BuildContext context) {
    return showModalBottomSheet(
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
                      : _buildExpenseInputForm(setModalState, selectedExpenseId!),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void updateCostListAndContract(dynamic result) {
    if (result == null) return;
    // 檢查 costList 是否已存在相同 fee_name 與 fee_id 的資料
    int index = costList.indexWhere((item) =>
    item['fee_name'] == result['fee_name'] &&
        item['fee_id'] == result['fee_id']);
    if (index != -1) {
      // 已存在 → 更新該筆資料
      costList[index] = result;
    } else {
      // 不存在 → 新增
      costList.add(result);
    }
    // 同步更新到 contractDataProvider
    ref.read(contractDataProvider.notifier).update((map) => {
      ...map,
      'utility_fees': costList,
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
    costList = contractData['utility_fees'];
    customerData = contractData['signatories'];
    return SingleChildScrollView(
      child: Column(
        children: [
          BlockContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        '租金(期)',
                        style: TextStyle(
                          color: const Color(0xFF2B2F35),
                          fontSize: 16,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '繳費方式 ',
                                      style: TextStyle(
                                        color: const Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF4F6F7),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          isExpanded: true,
                                          value: selectedMethodId,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          hint: const Text("請選擇"),
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
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '每期租金 ',
                                      style: TextStyle(
                                        color: const Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 8,),
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
                                        controller: controllerRent,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          hintText: '每期租金',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF7B8A95),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
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
                                  ],
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
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDEE2E6)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '押金',
                        style: TextStyle(
                          color: const Color(0xFF2B2F35),
                          fontSize: 16,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '計算基準',
                        style: TextStyle(
                          color: Color(0xFF5F6E7B),
                          fontSize: 12,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                  updateDepositAndTotal();
                                },
                                activeColor: Color(0xFF319877),
                              ),
                              Text(
                                depositTypes[index],
                                style: TextStyle(
                                  color: depositType == index ? Color(0xFF319877) : Color(0xFF333333),
                                  fontSize: 14,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 16),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          if (depositType == 0) ...[
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  if (depositMonths > 0) {
                                    depositMonths--;
                                  }
                                  updateTotal();
                                  updateDepositAndTotal();
                                });
                              },
                            ),
                            Text('$depositMonths 期'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  depositMonths++;
                                  updateTotal();
                                  updateDepositAndTotal();
                                });
                              },
                            ),
                            const Spacer(),
                          ]
                          else if (depositType == 1) ...[
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: TextField(
                                  controller: controllerAmount,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    hintText: '請輸入固定金額',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF7B8A95),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value == '') value = '0';
                                    updateTotal();
                                    updateDepositAndTotal();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                          ],
                          Text(
                            '共計：TWD $total',
                            style: TextStyle(
                              color: Color(0xFF248568),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: const Color(0xFFFF4444),
                          ),
                          Expanded(
                            child: Text(
                              '根據中華民國內政部(租賃住宅市場發展及管理條例)規定，一般租賃契約押金額度最高不得超過兩個月租金。',
                              style: TextStyle(
                                color: const Color(0xFFFF4444),
                                fontSize: 14,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          BlockContainer(
            child: Column(
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
                        final result = await showExpenseBottomSheet(context);
                        updateCostListAndContract(result);
                        initBottomSheet();
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                Column(
                  children: List.generate(costList.length, (index) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                costList[index]['fee_name'],
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
                                  color: costList[index]['pricing']['input'] != null ? const Color(0xFFFFE4E4) : const Color(0xFFECE3D5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  costList[index]['method_name'],
                                  style: TextStyle(
                                    color: costList[index]['pricing']['input'] != null ? const Color(0xFFFF4444) : const Color(0xFF986E49),
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              if (costList[index]['pricing']['input'] != 0) ...[
                                Text(
                                  '\$ ${costList[index]['pricing']['input'] ?? ''} ${costList[index]['unit_title']}',
                                  style: const TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ]
                              else ...[
                                const Text(
                                  '-',
                                  style: TextStyle(
                                    color: Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    selectedExpense = costList[index]['fee_name'];
                                    selectedExpenseId = costList[index]['fee_id'];
                                  });
                                  final result = await showExpenseBottomSheet(context);
                                  updateCostListAndContract(result);
                                  initBottomSheet();
                                },
                                child: const Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          // ➔ 只有在不是最後一個 item 時才顯示 Divider
                          if (index != costList.length - 1) ...[
                            const SizedBox(height: 8),
                            const Divider(thickness: 1, color: Color(0xFFCBD2D6)),
                          ],
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
          const SizedBox(height: 16,),
          BlockContainer(
            child: Column(
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
                                : 'YYYY/MM/DD',
                            style: TextStyle(
                              color: effective != null
                                  ? const Color(0xFF2B2F35)
                                  : const Color(0xFF7B8A95),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
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
                                : 'YYYY/MM/DD',
                            style: TextStyle(
                              color: expiration != null
                                  ? const Color(0xFF2B2F35)
                                  : const Color(0xFF7B8A95),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
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
          const SizedBox(height: 16,),
          BlockContainer(
            child: Column(
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
                          customerData.add({
                            "role": 0,//0:主要簽約人 1:共同簽約人 2:保證人
                            "name": '',
                            "national_id_number": "",
                            "date_of_birth": "",
                            "phone_number": "",
                            "city_name": "",
                            "district_name": "",
                            "detailed_address": "",
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
                                  color: customerData[index]['name'] == '' ? const Color(0xFFE3E7EA) : const Color(0xFFD9F2E5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  customerData[index]['name'] == '' ? '未完成' : '已完成',
                                  style: TextStyle(
                                    color: customerData[index]['name'] == '' ? const Color(0xFF7B8A95) : const Color(0xFF248568),
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
                                                        "id_card_front_url": result[8][0],
                                                        "id_card_back_url":  result[8][1],
                                                      };
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
                          if (customerData[index]['name'] != '') ...[
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
                                    Row(
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
                                        SizedBox(width: 8,),
                                        if (customerData[index]['role'] == 0) ...[
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: const Color(0xFFFF4444),
                                                ),
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                            ),
                                            child: Text(
                                              '主繳款人',
                                              style: TextStyle(
                                                color: const Color(0xFFFF4444),
                                                fontSize: 12,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          BlockContainer(
            child: Column(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpenseTile({required String label, required Widget image, required void Function() onTap, required bool selected,}) {
    final isSelected = selected;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 78,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFD9F2E5) : const Color(0xFFF3F3F3),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected ? Color(0xFF319877) : const Color(0xFFE3E7EA),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: Align(
                alignment: Alignment.center,
                child: image,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF319877) : const Color(0xFF5F6E7B),
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
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(expenseData.length, (index) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 52) / 3,
              child: buildExpenseTile(
                label: expenseData[index]['fee_name'],
                image: _getExpenseIcon(expenseData[index]['fee_name']),
                selected: selected == index,
                onTap: () {
                  setModalState(() {
                    selected = index;
                  });
                },
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                  setModalState(() {
                    selectedExpense = expenseData[selected]['fee_name'];
                    selectedExpenseId = expenseData[selected]['fee_id'];
                  });
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
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildExpenseInputForm(StateSetter setModalState, int id) {
    final Map<String, dynamic> selectedFee = expenseData.firstWhere(
          (item) => item['fee_id'] == id,
    );
    int index = costList.indexWhere((item) => item['fee_id'] == id);

    List<dynamic> method = selectedFee['billing_method'];
    int? selectedMethod;

    final List<String> billingTypes= ['每單位', '固定金額',];
    int? billing;

    final TextEditingController controller = TextEditingController();

    if (index != -1) {
      selectedMethod = costList[index]['method_id'];
      billing = costList[index]['method_id']-1;
      controller.text = costList[index]['pricing']['input'].toString();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            '$selectedExpense 計費資訊',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '繳費方式',
          style: TextStyle(
            color: const Color(0xFF2B2F35),
            fontSize: 15,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
          child:
          DropdownButtonFormField<int>(
            isExpanded: true,
            hint: const Text("繳費方式"),
            decoration: InputDecoration(
              errorText: null,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            value: selectedMethod,
            items: List.generate(method.length, (index) {
              return DropdownMenuItem<int>(
                value: method[index]['method_id'],
                child: Text(method[index]['method_name']),
              );
            }),
            onChanged: (int? newValue) {
              selectedMethod = newValue;
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '計費方式',
          style: TextStyle(
            color: const Color(0xFF2B2F35),
            fontSize: 15,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
          child:
          DropdownButtonFormField<int>(
            isExpanded: true,
            hint: const Text("計費方式"),
            decoration: InputDecoration(
              errorText: null,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            value: billing,
            items: List.generate(billingTypes.length, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(billingTypes[index]),
              );
            }),
            onChanged: (int? newValue) {
              billing = newValue;
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '金額',
          style: TextStyle(
            color: const Color(0xFF2B2F35),
            fontSize: 15,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: 1,
                  decoration: const InputDecoration(
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
              Text(
                '${selectedFee['unit_title']}',
                style: TextStyle(
                  color: const Color(0xFF2B2F35),
                  fontSize: 15,
                  fontFamily: 'PingFang TC',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setModalState(() {
                    selectedExpense = null;
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
                  Navigator.pop(context, {
                    "fee_name": selectedFee['fee_name'],
                    "fee_id": id,
                    "pricing": {
                      "model": billing!+1,
                      "input": int.tryParse(controller.text) ?? 0,
                      "currency": "TWD"
                    },
                    "method_id": selectedMethod,
                    "method_name": selectedFee['billing_method']
                      .firstWhere((m) => m['method_id'] == selectedMethod)['method_name'],
                    "unit_title": selectedFee['unit_title'],
                  });
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
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _getExpenseIcon(String feeName) {
    switch (feeName) {
      case '電費':
        return SvgPicture.asset('assets/icons/cost_bill/electricity.svg', width: 17, height: 22);
      case '水費':
        return SvgPicture.asset('assets/icons/cost_bill/water.svg');
      case '瓦斯費':
        return SvgPicture.asset('assets/icons/cost_bill/gas.svg', color: const Color(0xFF5F6E7B),);
      case '管理費':
        return SvgPicture.asset('assets/icons/cost_bill/management_cost.svg', width: 17, height: 22);
      case '清潔費':
        return SvgPicture.asset('assets/icons/cost_bill/clean.svg', width: 17, height: 22);
      default:
        return const SizedBox(width: 17, height: 22);
    }
  }
}
