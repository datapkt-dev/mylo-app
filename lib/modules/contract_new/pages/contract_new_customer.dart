import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mylo/units/upload_image_widget.dart';

class ContractNewCustomer extends StatefulWidget {
  final List<dynamic> dataPass;
  const ContractNewCustomer({super.key, required this.dataPass});

  @override
  State<ContractNewCustomer> createState() => _ContractNewCustomerState();
}

class _ContractNewCustomerState extends State<ContractNewCustomer> {
  List<String> imgId = ['', '',];
  List<dynamic> customerData = [false, '', '', '', '', '', '', '',];
  DateTime birthday = DateTime.now();
  // [false, '團團', 'H123456789', '2005/12/01', '0912345678', '台中市大雅區民生路三段315號']

  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.dataPass[0]) {
      nameController.text = widget.dataPass[1];
      idController.text = widget.dataPass[2];
      birthday = DateTime.parse(widget.dataPass[3]);
      phoneController.text = widget.dataPass[4];
      cityController.text = widget.dataPass[5];
      districtController.text = widget.dataPass[6];
      addressController.text = widget.dataPass[7];
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    phoneController.dispose();
    cityController.dispose();
    districtController.dispose();
    addressController.dispose();
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
          '編輯簽約人',
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
              customerData[0] = true;
              customerData[1] = nameController.text;
              customerData[2] = idController.text;
              customerData[3] = DateFormat('yyyy-MM-dd').format(birthday);
              customerData[4] = phoneController.text;
              customerData[5] = cityController.text;
              customerData[6] = districtController.text;
              customerData[7] = addressController.text;
              print(customerData);
              Navigator.pop(context, customerData);
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
          const Gap(16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '簽約人',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(8),
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
                      controller: nameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: '簽約人姓名',
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
                  const Gap(24),
                  const Text(
                    '身分證字號',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(8),
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
                      controller: idController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: '簽約人身分證字號',
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
                  const Gap(24),
                  const Text(
                    '生日',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
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
                          birthday = result;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF4F6F7),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: Text('${DateFormat('yyyy/MM/dd').format(birthday)}'),
                    ),
                  ),
                  const Gap(24),
                  const Text(
                    '電話',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(8),
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
                      controller: phoneController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: '簽約人電話',
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
                  const Gap(24),
                  const Text(
                    '戶籍地',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
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
                            controller: cityController,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: '縣市',
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
                      ),
                      const Gap(8),
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
                            controller: districtController,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: '區域',
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
                      ),
                    ],
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F6F7),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: TextField(
                      controller: addressController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: '詳細地址',
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
              const Gap(16),
              _block(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '上傳身分證或居留證',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(16),
                  Stack(
                    children: [
                      UploadImageWidget(
                        onImagePicked: (path) {
                          if (path.isNotEmpty) {
                            setState(() {
                              imgId[0] = path;
                            });
                          }
                          else {
                            print("Invalid file path.");
                          }
                        },
                        child: Image.asset('assets/images/contract_new/fillin_id_f.png'),
                      ),
                      imgId[0] != ''
                          ? Positioned(
                        top: 21,
                        left: 17,
                        child: SizedBox(
                          width: 137,
                          height: 89,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.file(
                              File(imgId[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                  const Gap(16),
                  Stack(
                    children: [
                      UploadImageWidget(
                        onImagePicked: (path) {
                          if (path.isNotEmpty) {
                            setState(() {
                              imgId[1] = path;
                            });
                          }
                          else {
                            print("Invalid file path.");
                          }
                        },
                        child: Image.asset('assets/images/contract_new/fillin_id_b.png'),
                      ),
                      imgId[1] != ''
                          ? Positioned(
                        top: 21,
                        left: 17,
                        child: SizedBox(
                          width: 137,
                          height: 89,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.file(
                              File(imgId[1]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                  const Gap(16),
                  const Text(
                    '注意事項：請確認照片內容清晰、無反光且完整，本照片僅提供XXX本公司OOO使用等備注用語請提供文字',
                    style: TextStyle(
                      color: Color(0xFF5F6E7B),
                      fontSize: 12,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ))
            ],
          ),
        )
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
