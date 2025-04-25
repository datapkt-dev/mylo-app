import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/index_property/widgets/widget_donut_chart.dart';

class WidgetData extends StatelessWidget {
  const WidgetData({super.key});

  final double percentage = 60;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
