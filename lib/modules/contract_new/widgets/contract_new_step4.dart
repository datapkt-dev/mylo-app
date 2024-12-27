import 'package:flutter/material.dart';

class ContractNewStep4 extends StatefulWidget {
  const ContractNewStep4({super.key});

  @override
  State<ContractNewStep4> createState() => _ContractNewStep4State();
}

class _ContractNewStep4State extends State<ContractNewStep4> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFCBD2D6)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          '合約名稱ＯＯＯＯＯＯＯ',
          style: TextStyle(
            color: Color(0xFF2B2F35),
            fontSize: 15,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
