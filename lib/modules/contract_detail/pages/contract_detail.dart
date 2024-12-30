import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/contract_duration.dart';
import '../widgets/contract_fare.dart';
import '../widgets/contract_information.dart';

class Detail extends StatefulWidget {
  final int status;
  const Detail({super.key, required this.status});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int _selectedTab = 0;
  List<String> tab = ['基本資料', '費用', '合約日期', '備註',];
  List<Widget> component = [const ContractInformation(), const ContractFare(), const ContractDuration(), Container()];

  List<String> status = ['待簽約', '執行中', '待續約',];
  List<Color> statusBlock = [const Color(0xFFFFE4E4), const Color(0xFFD9F2E5), const Color(0xFFE3E7EA),];
  List<Color> statusText = [const Color(0xFFFF4444), const Color(0xFF248568), const Color(0xFF7B8A95),];
  late int key;

  @override
  void initState() {
    super.initState();
    key = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Text(
          '好宅紹區套房10F-1',
          style: TextStyle(
            color: Color(0xFF2B2F35),
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [
          Icon(Icons.more_horiz),
          Gap(16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    color: statusBlock[key],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            status[key],
                            style: TextStyle(
                              color: statusText[key],
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            '合約編號 R20241211001',
                            style: TextStyle(
                              color: Color(0xFF5F6E7B),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 108,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.remove_red_eye_outlined),
                            Text(
                              '瀏覽合約',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2B2F35),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (key!=1) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'QRcode',
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
                      const Gap(25),
                      Center(
                        child: QrImageView(
                          data: 'This is a simple QR code',
                          version: QrVersions.auto,
                          size: 131,
                          gapless: false,
                        ),
                      ),
                      const Gap(9),
                    ],
                  ),
                ),
              ],
              const Gap(16),
              Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(tab.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTab = index;
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: _selectedTab == index ? const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 2, color: Color(0xFF986E49)),
                            ),
                          ) : null,
                          child: Text(
                            tab[index],
                            style: TextStyle(
                              color: _selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF333333),
                              fontSize: 15,
                              fontFamily: _selectedTab == index ? 'PingFang SC' : 'PingFang TC',
                              fontWeight: _selectedTab == index ? FontWeight.w500 : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const Gap(16),
              component[_selectedTab],
            ],
          ),
        ),
      ),
    );
  }
}
