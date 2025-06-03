import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mylo/units/upload_image_widget.dart';
import '../data/api.dart';

class ContractNewCustomer extends StatefulWidget {
  final Map<String, dynamic> dataPass;
  const ContractNewCustomer({super.key, required this.dataPass});

  @override
  State<ContractNewCustomer> createState() => _ContractNewCustomerState();
}

class _ContractNewCustomerState extends State<ContractNewCustomer> {
  final String baseUrl = 'https://rencoo.com.tw';

  List<String> imgRoute = ['', '',];
  List<dynamic> customerData = List.filled(9, '');
  DateTime birthday = DateTime.now();
  bool native = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedCity;
  String? selectedDistrict;
  final TextEditingController addressController = TextEditingController();

  List<dynamic> cityList = [];
  List<dynamic> districtList = [];

  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  @override
  void initState() {
    super.initState();

    apiService = ApiService(baseUrl: baseUrl);
    futureData = apiService.fetchCity();

    customerData[0] = false;
    nameController.text = widget.dataPass['name'];
    idController.text = widget.dataPass['national_id_number'];
    birthday = (widget.dataPass['date_of_birth'] == null || widget.dataPass['date_of_birth'].isEmpty)
        ? DateTime.now()
        : DateTime.parse(widget.dataPass['date_of_birth']);
    phoneController.text = widget.dataPass['phone_number'];
    selectedCity = widget.dataPass['city_name'] == ''
        ? null
        : widget.dataPass['city_name'];
    districtList = widget.dataPass['district_name'] == ''
        ? []
        : [{'district_code': 0, 'district_name': widget.dataPass['district_name']}];
    selectedDistrict = widget.dataPass['district_name'] == ''
        ? null
        : widget.dataPass['district_name'];
    addressController.text = widget.dataPass['detailed_address'] ?? '';
    // imgRoute = widget.dataPass[''];
    // imgRoute = [];
    }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    phoneController.dispose();
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
              if (nameController.text != '') {
                customerData[0] = 1;
                customerData[1] = nameController.text;
                customerData[2] = idController.text;
                customerData[3] = DateFormat('yyyy-MM-dd').format(birthday);
                customerData[4] = phoneController.text;
                // customerData[5] = cityController.text;
                // customerData[6] = districtController.text;
                customerData[5] = selectedCity;
                customerData[6] = selectedDistrict;
                customerData[7] = addressController.text;
                // customerData[8] = imgRoute;
                customerData[8] = [
                  'https://cdn.example.com/ids/ming_front.jpg',
                  'https://cdn.example.com/ids/ming_back.jpg',
                ];
                print(customerData);
                Navigator.pop(context, customerData);
              } else {
                Fluttertoast.showToast(msg: "請檢查姓名不可為空");
              }
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
                  const SizedBox(height: 8,),
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
                  const SizedBox(height: 24,),
                  const Text(
                    '身分證字號',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8,),
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
                  const SizedBox(height: 24,),
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
                        firstDate: DateTime(1900, 01),
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
                      child: Text(DateFormat('yyyy/MM/dd').format(birthday)),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  const Text(
                    '電話',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8,),
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
                  const SizedBox(height: 24,),
                  const Text(
                    '戶籍地',
                    style: TextStyle(
                      color: Color(0xFF2B2F35),
                      fontSize: 15,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8,),
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
                        cityList = dataList;
                      }
                      return Row(
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
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  // 如果目前還沒有資料或還沒選擇，就顯示 null
                                  value: selectedCity,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("請選擇縣市"), // 當還沒選擇時的顯示
                                  // 下拉選單內容 (items)
                                  items: cityList.map((city) {
                                    return DropdownMenuItem<String>(
                                      value: city['city_name'],  // 實際的 value 是 student_id
                                      child: Text(city['city_name']), // 顯示的文字是學生名稱
                                    );
                                  }).toList(),
                                  // 當使用者選擇某個選項時
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedDistrict = null;
                                      selectedCity = newValue;
                                      // 從 cityList 找到選中的 city 對象
                                      final selectedCityData = cityList.firstWhere(
                                            (city) => city['city_name'] == newValue,
                                        orElse: () => {},
                                      );

                                      // 從選中的 city 資料取得對應的 district
                                      districtList = selectedCityData['district'] ?? [];
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8,),
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
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  // 如果目前還沒有資料或還沒選擇，就顯示 null
                                  value: selectedDistrict,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("請選擇行政區"), // 當還沒選擇時的顯示
                                  // 下拉選單內容 (items)
                                  items: districtList.map((district) {
                                    return DropdownMenuItem<String>(
                                      value: district['district_name'],  // 實際的 value 是 student_id
                                      child: Text(district['district_name']), // 顯示的文字是學生名稱
                                    );
                                  }).toList(),
                                  onTap: () {
                                  },
                                  // 當使用者選擇某個選項時
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedDistrict = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8,),
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
              const SizedBox(height: 16,),
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
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            native = true;
                          });
                        },
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: native ? 4 : 1,
                              color: native ? const Color(0xFF986E49) : const Color(0xFFA6B1BA),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Text(
                        '本國身分證',
                        style: TextStyle(
                          color: native ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
                          fontSize: 14,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.70,
                        ),
                      ),
                      const SizedBox(width: 24,),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            native = false;
                          });
                        },
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: !native ? 4 : 1,
                              color: !native ? const Color(0xFF986E49) : const Color(0xFFA6B1BA),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Text(
                        '外籍居留證',
                        style: TextStyle(
                          color: !native ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
                          fontSize: 14,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Stack(
                    children: [
                      UploadImageWidget(
                        onImagePicked: (path) {
                          if (path.isNotEmpty) {
                            setState(() {
                              imgRoute[0] = path;
                            });
                          }
                          else {
                            print("Invalid file path.");
                          }
                        },
                        child: Image.asset('assets/images/contract_new/fillin_id_f.png'),
                      ),
                      imgRoute[0] != ''
                          ? Positioned(
                        top: 21,
                        left: 17,
                        child: SizedBox(
                          width: 137,
                          height: 89,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.file(
                              File(imgRoute[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Stack(
                    children: [
                      UploadImageWidget(
                        onImagePicked: (path) {
                          if (path.isNotEmpty) {
                            setState(() {
                              imgRoute[1] = path;
                            });
                          }
                          else {
                            print("Invalid file path.");
                          }
                        },
                        child: Image.asset('assets/images/contract_new/fillin_id_b.png'),
                      ),
                      imgRoute[1] != ''
                          ? Positioned(
                        top: 21,
                        left: 17,
                        child: SizedBox(
                          width: 137,
                          height: 89,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.file(
                              File(imgRoute[1]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    '注意事項：請確認照片內容清晰、無反光且完整，本照片僅提供XXX本公司OOO使用等備注用語請提供文字',
                    style: TextStyle(
                      color: Color(0xFF5F6E7B),
                      fontSize: 12,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
