import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../units/upload_image_widget.dart';
import '../data/api.dart';

class ContractNewStep3 extends StatefulWidget {
  // 屋況點交
  const ContractNewStep3({super.key});

  @override
  State<ContractNewStep3> createState() => _ContractNewStep3State();
}

class _ContractNewStep3State extends State<ContractNewStep3> {
  List<dynamic> furniture = [];
  List<dynamic> appliance = [];
  bool _dataInitialized = false;

  final TextEditingController descriptionController = TextEditingController();

  final String baseUrl = 'https://rencoo.com.tw';
  late final ApiService apiService;
  late Future<Map<String, dynamic>> futureData;
  late Map<String, dynamic> dataList;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
    futureData = apiService.fetchEquipment();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              if (snapshot.hasData && !_dataInitialized) {
                dataList = snapshot.data!;

                furniture = dataList['furnitures'];
                appliance = dataList['appliances'];

                furniture = furniture.map((item) {
                  return {
                    ...item,
                    'available': false,
                    'img': [],
                    'caption': '',
                  };
                }).toList();

                appliance = appliance.map((item) {
                  return {
                    ...item,
                    'available': false,
                    'img': [],
                    'caption': '',
                  };
                }).toList();

                _dataInitialized = true;
              }
              return _block(Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        '家具',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        '${furniture.length}項',
                        style: const TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16,),
                  Column(
                    children: List.generate(furniture.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: index < furniture.length-1 ? 16 : 0,),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final result = await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor: Colors.white,
                                              context: context,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(16),),
                                              ),
                                              builder: (BuildContext context) {
                                                List<dynamic> imgRoute = List.from(furniture[index]['img']);
                                                TextEditingController descriptionController = TextEditingController(
                                                  text: furniture[index]['caption'] ?? '',
                                                );
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return Container(
                                                        width: double.infinity,
                                                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16,),
                                                        child: SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                '${furniture[index]['furniture_name']}',
                                                                style: const TextStyle(
                                                                  color: Color(0xFF222222),
                                                                  fontSize: 18,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 12,),
                                                              Wrap(
                                                                runSpacing: 12,
                                                                spacing: 12,
                                                                children: List.generate(imgRoute.length+1, (index) {
                                                                  if (index == imgRoute.length) {
                                                                    if (imgRoute.length < 4) {
                                                                      return UploadImageWidget(
                                                                        onImagePicked: (path) {
                                                                          if (imgRoute.length<4) {
                                                                            if (path.isNotEmpty) {
                                                                              setState(() {
                                                                                imgRoute.add(path);
                                                                              });
                                                                            }
                                                                            else {
                                                                              print("Invalid file path.");
                                                                            }
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          width: 80,
                                                                          height: 80,
                                                                          alignment: Alignment.center,
                                                                          decoration: ShapeDecoration(
                                                                            color: Colors.white,
                                                                            shape: RoundedRectangleBorder(
                                                                              side: const BorderSide(width: 1, color: Color(0xFF319877)),
                                                                              borderRadius: BorderRadius.circular(3),
                                                                            ),
                                                                          ),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                width: 14,
                                                                                height: 14,
                                                                                'assets/icons/contract_new/camera.svg',
                                                                              ),
                                                                              const SizedBox(height: 8,),
                                                                              Text(
                                                                                '上傳 $index/4',
                                                                                style: const TextStyle(
                                                                                  color: Color(0xFF5F6E7B),
                                                                                  fontSize: 14,
                                                                                  fontFamily: 'PingFang TC',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.70,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return SizedBox.shrink();
                                                                    }
                                                                  }
                                                                  else {
                                                                    return Stack(
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 80,
                                                                          height: 80,
                                                                          child: ClipRRect(
                                                                            borderRadius: BorderRadius.circular(3),
                                                                            child: Image.file(
                                                                              File(imgRoute[index]),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top: 3,
                                                                          right: 4,
                                                                          child: GestureDetector(
                                                                            onTap: () {
                                                                              setState(() {
                                                                                imgRoute.removeAt(index);
                                                                              });
                                                                            },
                                                                            child: SvgPicture.asset('assets/icons/contract_new/delete.svg'),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }
                                                                }),
                                                              ),
                                                              const SizedBox(height: 8,),
                                                              const Text(
                                                                '備註',
                                                                style: TextStyle(
                                                                  color: Color(0xFF2B2F35),
                                                                  fontSize: 15,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 8,),
                                                              Container(
                                                                height: 48,
                                                                width: double.infinity,
                                                                padding: const EdgeInsets.symmetric(horizontal: 16,),
                                                                decoration: ShapeDecoration(
                                                                  color: const Color(0xFFF4F6F7),
                                                                  shape: RoundedRectangleBorder(
                                                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                                                    borderRadius: BorderRadius.circular(3),
                                                                  ),
                                                                ),
                                                                child: TextField(
                                                                  controller: descriptionController,
                                                                  maxLines: 1,
                                                                  decoration: const InputDecoration(
                                                                    hintText: '備註說明',
                                                                    hintStyle: TextStyle(
                                                                      color: Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                    border: InputBorder.none,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 24,),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  final description = descriptionController.text;
                                                                  final images = List.from(imgRoute);

                                                                  Navigator.pop(context, {
                                                                    'submit': true,
                                                                    'images': images,
                                                                    'caption': description,
                                                                  });
                                                                },
                                                                child: Container(
                                                                  height: 40,
                                                                  width: double.infinity,
                                                                  alignment: Alignment.center,
                                                                  decoration: ShapeDecoration(
                                                                    color: const Color(0xFF8C5F42),
                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                                  ),
                                                                  child: const Text(
                                                                    '確定',
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 16,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                            if (result != null) {
                                              final images = result['images'] as List?;
                                              final caption = result['caption']?.toString().trim();

                                              final hasData = (images != null && images.isNotEmpty) || (caption != null && caption.isNotEmpty);

                                              setState(() {
                                                furniture[index]['available'] = hasData;
                                                furniture[index]['img'] = images ?? [];
                                                furniture[index]['caption'] = caption ?? '';
                                              });

                                              print(hasData ? '更新資料' : '清除資料');
                                            } else {
                                              print("使用者未點擊確定，返回值為 null");
                                            }
                                          },
                                          child: SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                        ),
                                        const SizedBox(width: 8,),
                                        Text(
                                          '${furniture[index]['furniture_name']} X${furniture[index]['qty']}',
                                          style: const TextStyle(
                                            color: Color(0xFF2B2F35),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\$${furniture[index]['price']}',
                                      style: TextStyle(
                                        color: Color(0xFF5F6E7B),
                                        fontSize: 14,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value: furniture[index]['available'] ?? false,
                                    activeColor: const Color(0xFF8C5F42),
                                    onChanged: (bool value) async {
                                      setState(() {
                                        furniture[index]['available'] = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (furniture[index]['available']) ...[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Wrap(
                                      runSpacing: 12,
                                      spacing: 12,
                                      children: List.generate(furniture[index]['img'].length, (indexNd) {
                                        return SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(3),
                                            child: Image.file(
                                              File(furniture[index]['img'][indexNd]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    Text(
                                      '${furniture[index]['caption']}',
                                      style: TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 14,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }),
                  ),
                  const Divider(height: 48, thickness: 1, color: Color(0xFFCBD2D6),),
                  Row(
                    children: [
                      const Text(
                        '家電',
                        style: TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        '${appliance.length}項',
                        style: const TextStyle(
                          color: Color(0xFF2B2F35),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Column(
                    children: List.generate(appliance.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: index < appliance.length-1 ? 16 : 0,),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final result = await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor: Colors.white,
                                              context: context,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                              ),
                                              builder: (BuildContext context) {
                                                List<dynamic> imgRoute = List.from(appliance[index]['img']);
                                                TextEditingController descriptionController = TextEditingController(
                                                  text: appliance[index]['caption'] ?? '',
                                                );
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return Container(
                                                        width: double.infinity,
                                                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16,),
                                                        child: SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                '${appliance[index]['appliance_name']}',
                                                                style: const TextStyle(
                                                                  color: Color(0xFF222222),
                                                                  fontSize: 18,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 12,),
                                                              Wrap(
                                                                runSpacing: 12,
                                                                spacing: 12,
                                                                children: List.generate(imgRoute.length+1, (index) {
                                                                  if (index == imgRoute.length) {
                                                                    if (imgRoute.length < 4) {
                                                                      return UploadImageWidget(
                                                                        onImagePicked: (path) {
                                                                          if (imgRoute.length<4) {
                                                                            if (path.isNotEmpty) {
                                                                              setState(() {
                                                                                imgRoute.add(path);
                                                                              });
                                                                            }
                                                                            else {
                                                                              print("Invalid file path.");
                                                                            }
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          width: 80,
                                                                          height: 80,
                                                                          alignment: Alignment.center,
                                                                          decoration: ShapeDecoration(
                                                                            color: Colors.white,
                                                                            shape: RoundedRectangleBorder(
                                                                              side: const BorderSide(width: 1, color: Color(0xFF319877)),
                                                                              borderRadius: BorderRadius.circular(3),
                                                                            ),
                                                                          ),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                width: 14,
                                                                                height: 14,
                                                                                'assets/icons/contract_new/camera.svg',
                                                                              ),
                                                                              const SizedBox(height: 8,),
                                                                              Text(
                                                                                '上傳 $index/4',
                                                                                style: const TextStyle(
                                                                                  color: Color(0xFF5F6E7B),
                                                                                  fontSize: 14,
                                                                                  fontFamily: 'PingFang TC',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.70,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return SizedBox.shrink();
                                                                    }
                                                                  }
                                                                  else {
                                                                    return Stack(
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 80,
                                                                          height: 80,
                                                                          child: ClipRRect(
                                                                            borderRadius: BorderRadius.circular(3),
                                                                            child: Image.file(
                                                                              File(imgRoute[index]),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top: 3,
                                                                          right: 4,
                                                                          child: GestureDetector(
                                                                            onTap: () {
                                                                              setState(() {
                                                                                imgRoute.removeAt(index);
                                                                              });
                                                                            },
                                                                            child: SvgPicture.asset('assets/icons/contract_new/delete.svg'),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }
                                                                }),
                                                              ),
                                                              const SizedBox(height: 8,),
                                                              const Text(
                                                                '備註',
                                                                style: TextStyle(
                                                                  color: Color(0xFF2B2F35),
                                                                  fontSize: 15,
                                                                  fontFamily: 'PingFang TC',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 8,),
                                                              Container(
                                                                height: 48,
                                                                width: double.infinity,
                                                                padding: const EdgeInsets.symmetric(horizontal: 16,),
                                                                decoration: ShapeDecoration(
                                                                  color: const Color(0xFFF4F6F7),
                                                                  shape: RoundedRectangleBorder(
                                                                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                                                                    borderRadius: BorderRadius.circular(3),
                                                                  ),
                                                                ),
                                                                child: TextField(
                                                                  controller: descriptionController,
                                                                  maxLines: 1,
                                                                  decoration: const InputDecoration(
                                                                    hintText: '備註說明',
                                                                    hintStyle: TextStyle(
                                                                      color: Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                    border: InputBorder.none,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 24,),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  final description = descriptionController.text;
                                                                  final images = List.from(imgRoute);

                                                                  Navigator.pop(context, {
                                                                    'submit': true,
                                                                    'images': images,
                                                                    'caption': description,
                                                                  });
                                                                },
                                                                child: Container(
                                                                  height: 40,
                                                                  width: double.infinity,
                                                                  alignment: Alignment.center,
                                                                  decoration: ShapeDecoration(
                                                                    color: const Color(0xFF8C5F42),
                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                                  ),
                                                                  child: const Text(
                                                                    '確定',
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 16,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                            if (result != null) {
                                              final images = result['images'] as List?;
                                              final caption = result['caption']?.toString().trim();

                                              final hasData = (images != null && images.isNotEmpty) || (caption != null && caption.isNotEmpty);

                                              setState(() {
                                                appliance[index]['available'] = hasData;
                                                appliance[index]['img'] = images ?? [];
                                                appliance[index]['caption'] = caption ?? '';
                                              });

                                              print(hasData ? '更新資料' : '清除資料');
                                            } else {
                                              print("使用者未點擊確定，返回值為 null");
                                            }
                                          },
                                          child: SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                        ),
                                        const SizedBox(width: 8,),
                                        Text(
                                          '${appliance[index]['appliance_name']} X${appliance[index]['qty']}',
                                          style: const TextStyle(
                                            color: Color(0xFF2B2F35),
                                            fontSize: 15,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\$${appliance[index]['price']}',
                                      style: TextStyle(
                                        color: Color(0xFF5F6E7B),
                                        fontSize: 14,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value: appliance[index]['available'] ?? false,
                                    activeColor: const Color(0xFF8C5F42),
                                    onChanged: (bool value) async {
                                      setState(() {
                                        appliance[index]['available'] = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (appliance[index]['available']) ...[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F6F7),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Wrap(
                                      runSpacing: 12,
                                      spacing: 12,
                                      children: List.generate(appliance[index]['img'].length, (indexNd) {
                                        return SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(3),
                                            child: Image.file(
                                              File(appliance[index]['img'][indexNd]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    Text(
                                      '${appliance[index]['caption']}',
                                      style: const TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 14,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),);
            },
          ),
          const SizedBox(height: 16,),
          _block(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '影片',
                style: TextStyle(
                  color: Color(0xFF2B2F35),
                  fontSize: 15,
                  fontFamily: 'PingFang TC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFF319877)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/contract_new/video-recorder.svg'),
                      const SizedBox(height: 8,),
                      const Text(
                        '上傳1/1',
                        style: TextStyle(
                          color: Color(0xFF5F6E7B),
                          fontSize: 14,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.70,
                        ),
                      )
                    ],
                  )
              )
            ],
          ))
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
