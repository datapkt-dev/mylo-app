import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContractDuration extends StatelessWidget {
  const ContractDuration({super.key});

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
            '合約起訖日',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '這裡是寫一些說明的地方沒有也可不寫',
            style: TextStyle(
              color: Color(0xFF5F6E7B),
              fontSize: 12,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.60,
            ),
          ),
          Gap(16),
          Text(
            '2024/12/12 ~2025/12/11',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
