import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/widget_donut_chart.dart';

class PropertyCommunityStatisticsPage extends StatefulWidget {
  const PropertyCommunityStatisticsPage({super.key});

  @override
  State<PropertyCommunityStatisticsPage> createState() => _PropertyCommunityStatisticsPageState();
}

class _PropertyCommunityStatisticsPageState extends State<PropertyCommunityStatisticsPage> {
  int selectedTab = 0;
  List<String> tab = ['數據', '帳單', '合約'];

  double percentage = 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              Text(
                '好好住社區',
                style: TextStyle(
                  color: const Color(0xFF2B2F35),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                '台北市大安區和平東路88號'
                    '',
                style: TextStyle(
                  color: const Color(0xFF5F6E7B),
                  fontSize: 14,
                  fontFamily: 'PingFang TC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16,),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF4ADAAC).withOpacity(0.4),
                    Color(0xFFFFB98D).withOpacity(0.4),
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 76,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFDEE2E6),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            AvatarStack(
                              imagePaths: [
                                'assets/images/contract_new/customer_male.png',
                                'assets/images/contract_new/customer_female.png',
                              ],
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFECE3D5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                '+3',
                                style: TextStyle(
                                  color: const Color(0xFF8C5F42),
                                  fontSize: 14,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '30',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              '物件',
                              style: TextStyle(
                                color: const Color(0xFF5F6E7B),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '整棟代管',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 15,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              '委託方式',
                              style: TextStyle(
                                color: const Color(0xFF5F6E7B),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '30',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              '待繳款',
                              style: TextStyle(
                                color: const Color(0xFF5F6E7B),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '100 %',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              '目前投報率',
                              style: TextStyle(
                                color: const Color(0xFF5F6E7B),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: List.generate(tab.length, (index) {
                return Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: IntrinsicWidth(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: selectedTab == index ? const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: Color(0xFF986E49),
                              ),
                            ),
                          ) : null,
                          child: Text(
                            tab[index],
                            style: TextStyle(
                              color: selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16,),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFDEE2E6),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/pie_chart.svg'),
                                SizedBox(width: 10,),
                                Text(
                                  '入住率',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 16,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 226,
                              child: WidgetDonutChart(
                                data: [
                                  DonutData(value: percentage, color: Color(0xFF319877)),
                                  DonutData(value: 100-percentage, color: Color(0xFFE3E7EA)),
                                ],
                                centerText: '$percentage%',
                                commentText: '入住率',
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 20,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF319877),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '入住率',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  width: 20,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFE3E7EA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '入住率',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarStack extends StatelessWidget {
  final List<String> imagePaths;
  final double size;
  final double overlap;

  const AvatarStack({
    Key? key,
    required this.imagePaths,
    this.size = 40,
    this.overlap = 25, // 每個頭像的左偏移
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + (imagePaths.length - 1) * overlap,
      height: size,
      child: Stack(
        children: List.generate(imagePaths.length, (index) {
          return Positioned(
            right: index * overlap,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
