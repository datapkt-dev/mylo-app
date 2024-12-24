import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContractFare extends StatelessWidget {
  const ContractFare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '押金(月)',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            '11000 元/月',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(16),
          Text(
            '租金(月)',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            '11000 元/月',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(16),
          Text(
            '電度(度)',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            '7 元/度',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
