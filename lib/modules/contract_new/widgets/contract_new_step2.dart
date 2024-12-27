import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mylo/modules/contract_new/pages/contract_new_customer.dart';

class ContractNewStep2 extends StatefulWidget {
  // 填寫資料
  const ContractNewStep2({super.key});

  @override
  State<ContractNewStep2> createState() => _ContractNewStep2State();
}

class _ContractNewStep2State extends State<ContractNewStep2> {
  int count = 1;
  List<List<dynamic>> customerData = [
    [false, '團團', 'H123456789', '2005/12/01', '0912345678', '台中市', '大雅區', '民生路三段315號',],
    [false, '林旺', 'A987654321', '2000/01/01', '0987654321', '台中市', '大雅區', '民生路三段315號'],
    [false, '', '', '', '', ''],
  ];
  DateTime effective = DateTime.now();
  DateTime expiration = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                            child: Text('${DateFormat('yyyy/MM/dd').format(expiration)}'),
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
                      const Gap(16),
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
                      const Gap(16),
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
                                const Gap(8),
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
                                                            const Gap(16),
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
                                                            const Gap(8),
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
                                                              const Gap(12),
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
                              const Gap(12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CircleAvatar(
                                  //   radius: 20,
                                  //   backgroundColor: Color(0xFFB6E4D0),
                                  // ),
                                  // SvgPicture.asset('assets/icons/contract_new/customer_female.svg'),
                                  Image.asset(width: 20,'assets/images/contract_new/customer_male.png',),
                                  const Gap(16),
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
                            const Gap(8),
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
