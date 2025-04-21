import 'package:flutter/material.dart';
import 'package:mylo/modules/monthly_statistics/widgets/monthly_statistics_widget_property.dart';
import 'package:mylo/modules/monthly_statistics/widgets/monthly_statistics_widget_tenant.dart';

class MonthlyStatisticsPage extends StatefulWidget {
  const MonthlyStatisticsPage({super.key});

  @override
  State<MonthlyStatisticsPage> createState() => _MonthlyStatisticsPageState();
}

class _MonthlyStatisticsPageState extends State<MonthlyStatisticsPage> {
  int selectedTab = 0;
  List<String> tabs = ['房客', '物件',];

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
                '2025 年 01 月帳單',
                style: TextStyle(
                  color: const Color(0xFF986E49),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '本月已收',
                      style: TextStyle(
                        color: const Color(0xFF5F6E7B),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '\$397,400',
                      style: TextStyle(
                        color: const Color(0xFFFF4444),
                        fontSize: 24,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GradientProgressBar(progress: 0.5),
                        ),
                        SizedBox(width: 8,),
                        Text(
                          '100%',
                          style: TextStyle(
                            color: const Color(0xFF2B2F35),
                            fontSize: 15,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
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
                              '\$397,400',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              '本月應收',
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
                                fontSize: 15,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              '已收款',
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
                              '待收款',
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
                              '待確認',
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
              children: List.generate(tabs.length, (index) {
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
                            tabs[index],
                            style: TextStyle(
                              color: selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedTab) {
      case 0:
        return MonthlyStatisticsWidgetTenant();
      case 1:
        return MonthlyStatisticsWidgetProperty();
      default:
        return const Center(child: Text("未知層級"));
    }
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
                    colors: [Color(0xFFFFF538), Color(0xFF029767)],
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
