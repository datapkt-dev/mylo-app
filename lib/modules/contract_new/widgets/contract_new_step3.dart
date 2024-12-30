import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../units/upload_image_widget.dart';

class ContractNewStep3 extends StatefulWidget {
  // 屋況點交
  const ContractNewStep3({super.key});

  @override
  State<ContractNewStep3> createState() => _ContractNewStep3State();
}

class _ContractNewStep3State extends State<ContractNewStep3> {
  bool light = true;
  List<List<dynamic>> furniture = [
    ['雙人床床架', false, [], ''],
    ['床頭櫃', false, [], ''],
    ['沙發', false, [], ''],
  ];
  List<List<dynamic>> appliance = [
    ['電風扇', false, [], ''],
    ['冰箱', false, [], ''],
    ['電視', false, [], ''],
    ['電視遙控器', false, [], ''],
    ['冷氣', false, [], ''],
    ['冷氣遙控器', false, [], ''],
  ];
  List<dynamic> imgRoute = [];
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _block(Column(
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
                  const Gap(10),
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
              const Gap(16),
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
                                        furniture[index][2] != []
                                            ? imgRoute = furniture[index][2]
                                            : imgRoute = [];
                                        furniture[index][3] != ''
                                            ? descriptionController.text = furniture[index][3]
                                            : descriptionController.text = '';
                                        final result = await showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(16),),
                                          ),
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
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
                                                          '${furniture[index][0]}',
                                                          style: const TextStyle(
                                                            color: Color(0xFF222222),
                                                            fontSize: 18,
                                                            fontFamily: 'PingFang TC',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const Gap(12),
                                                        Wrap(
                                                          runSpacing: 12,
                                                          spacing: 12,
                                                          children: List.generate(imgRoute.length+1, (index) {
                                                            if (index == imgRoute.length) {
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
                                                                      const Gap(8),
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
                                                              return SizedBox(
                                                                width: 80,
                                                                height: 80,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(3),
                                                                  child: Image.file(
                                                                    File(imgRoute[index]),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                        ),
                                                        const Gap(8),
                                                        const Text(
                                                          '備註',
                                                          style: TextStyle(
                                                            color: Color(0xFF2B2F35),
                                                            fontSize: 15,
                                                            fontFamily: 'PingFang TC',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        const Gap(8),
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
                                                            onChanged: (value) {},
                                                          ),
                                                        ),
                                                        const Gap(24),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (imgRoute.isNotEmpty) {
                                                              List<dynamic> img = [imgRoute, descriptionController.text];
                                                              Navigator.pop(context, img);
                                                            } else {
                                                              Navigator.pop(context, '');
                                                            }
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
                                                  )
                                                );
                                              },
                                            );
                                          },
                                        );
                                        if (result == null) {
                                          print("使用者未點擊確定，返回值為 null");
                                        } else {
                                          setState(() {
                                            furniture[index][2] = result[0];
                                            furniture[index][3] = result[1];
                                          });
                                        }
                                      },
                                      child: SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                    ),
                                    const Gap(8),
                                    Text(
                                      '${furniture[index][0]} X1',
                                      style: const TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  '\$5600',
                                  style: TextStyle(
                                    color: Color(0xFF5F6E7B),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.70,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: furniture[index][1],
                                activeColor: const Color(0xFF8C5F42),
                                onChanged: (bool value) async {
                                  setState(() {
                                    furniture[index][1] = !furniture[index][1];
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (furniture[index][2].isNotEmpty && furniture[index][1]) ...[
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
                                  children: List.generate(furniture[index][2].length, (indexNd) {
                                    return SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.file(
                                          File(furniture[index][2][indexNd]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                Text(
                                  '${furniture[index][3]}',
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
                          )
                        ]
                      ],
                    )
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
                  const Gap(10),
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
              const Gap(16),
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
                                        appliance[index][2] != []
                                            ? imgRoute = appliance[index][2]
                                            : imgRoute = [];
                                        appliance[index][3] != ''
                                            ? descriptionController.text = appliance[index][3]
                                            : descriptionController.text = '';
                                        final result = await showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                          ),
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
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
                                                          '${appliance[index][0]}',
                                                          style: const TextStyle(
                                                            color: Color(0xFF222222),
                                                            fontSize: 18,
                                                            fontFamily: 'PingFang TC',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const Gap(12),
                                                        Wrap(
                                                          runSpacing: 12,
                                                          spacing: 12,
                                                          children: List.generate(imgRoute.length+1, (index) {
                                                            if (index == imgRoute.length) {
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
                                                                      const Gap(8),
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
                                                              return SizedBox(
                                                                width: 80,
                                                                height: 80,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(3),
                                                                  child: Image.file(
                                                                    File(imgRoute[index]),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                        ),
                                                        const Gap(8),
                                                        const Text(
                                                          '備註',
                                                          style: TextStyle(
                                                            color: Color(0xFF2B2F35),
                                                            fontSize: 15,
                                                            fontFamily: 'PingFang TC',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        const Gap(8),
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
                                                            onChanged: (value) {},
                                                          ),
                                                        ),
                                                        const Gap(24),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (imgRoute.isNotEmpty) {
                                                              List<dynamic> img = [imgRoute, descriptionController.text];
                                                              Navigator.pop(context, img);
                                                            } else {
                                                              Navigator.pop(context, '');
                                                            }
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
                                            );
                                          },
                                        );
                                        if (result == null) {
                                          print("使用者未點擊確定，返回值為 null");
                                        } else {
                                          setState(() {
                                            appliance[index][2] = result[0];
                                            appliance[index][3] = result[1];
                                          });
                                        }
                                      },
                                      child: SvgPicture.asset('assets/icons/contract_new/camera.svg'),
                                    ),
                                    const Gap(8),
                                    Text(
                                      '${appliance[index][0]} X1',
                                      style: const TextStyle(
                                        color: Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  '\$5600',
                                  style: TextStyle(
                                    color: Color(0xFF5F6E7B),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.70,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: appliance[index][1],
                                activeColor: const Color(0xFF8C5F42),
                                onChanged: (bool value) async {
                                  setState(() {
                                    appliance[index][1] = !appliance[index][1];
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (appliance[index][2].isNotEmpty && appliance[index][1]) ...[
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
                                  children: List.generate(appliance[index][2].length, (indexNd) {
                                    return SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.file(
                                          File(appliance[index][2][indexNd]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                Text(
                                  appliance[index][3],
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
                          )
                        ],
                      ]
                    ),
                  );
                }),
              ),
            ],
          ),),
          const Gap(16),
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
              const Gap(16),
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
                    const Gap(8),
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
