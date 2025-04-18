import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/main_accounts/pages/monthly_statistics.dart';

class CommunityStatisticsPage extends StatefulWidget {
  const CommunityStatisticsPage({super.key});

  @override
  State<CommunityStatisticsPage> createState() => _CommunityStatisticsPageState();
}

class _CommunityStatisticsPageState extends State<CommunityStatisticsPage> {
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
                '台北市大安區和平東路88號',
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16,),
              padding: EdgeInsets.symmetric(vertical: 6,),
              child: Row(
                children: [
                  Text(
                    '6個物件',
                    style: TextStyle(
                      color: const Color(0xFF5F6E7B),
                      fontSize: 14,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/index/filter.svg',
                        color: Colors.black,
                      ),
                      SizedBox(width: 4,),
                      Text(
                        '篩選',
                        style: TextStyle(
                          color: const Color(0xFF2B2F35),
                          fontSize: 14,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16,),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/index/sort.svg',
                        color: Colors.black,
                      ),
                      SizedBox(width: 4,),
                      Text(
                        '排序',
                        style: TextStyle(
                          color: const Color(0xFF2B2F35),
                          fontSize: 14,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16,),
                  Row(
                    children: [
                      Icon(Icons.search_rounded,size: 18,),
                      SizedBox(width: 4,),
                      Text(
                        '搜尋',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(6, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyStatisticsPage(),),);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFE3E7EA),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 54,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFFE4E4),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Text(
                                    '未完成',
                                    style: TextStyle(
                                      color: const Color(0xFFFF4444),
                                      fontSize: 12,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\$150,000',
                                  style: TextStyle(
                                    color: const Color(0xFFFF4444),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Text(
                                  '3月帳單',
                                  style: TextStyle(
                                    color: const Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Container(
                                  width: 40,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFF4444),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                  ),
                                  child: Text(
                                    'New',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: GradientProgressBar(progress: 0.2),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '20%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF0A241E),
                                    fontSize: 15,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
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

class GradientProgressBar extends StatelessWidget {
  final double progress;

  const GradientProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: const Color(0xFFE3E7EA),
        borderRadius: BorderRadius.circular(5),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF538), Color(0xFFCEE342)],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
