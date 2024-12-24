import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContractInformation extends StatelessWidget {
  const ContractInformation({super.key});

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
            '簽約人',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            '王先生',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(16),
          Text(
            '身分證字號',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            'H1234567890',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(16),
          Text(
            '生日',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            '1988/12/12',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(16),
          Text(
            '電話',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            '09123456789',
            style: TextStyle(
              color: Color(0xFF0A241E),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(16),
          Text(
            '戶籍地',
            style: TextStyle(
              color: Color(0xFF2B2F35),
              fontSize: 15,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(5),
          Text(
            '台北市大安區和平東路88號',
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
