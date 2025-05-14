import 'package:flutter/material.dart';

class ContractNewCost extends StatefulWidget {
  const ContractNewCost({super.key});

  @override
  State<ContractNewCost> createState() => _ContractNewCostState();
}

class _ContractNewCostState extends State<ContractNewCost> {
  final List<Widget> _customItems = [];

  void _addCustomItem() {
    setState(() {
      _customItems.add(const WaterFeeCard());
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          '生活費用',
          style: TextStyle(
            color: Color(0xFF2B2F35),
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Text(
              '確認',
              style: TextStyle(
                color: Color(0xFF8C5F42),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: _block(Column(
              children: [
                const WaterFeeCard(),
                ..._customItems,
                OutlinedButton.icon(
                  onPressed: _addCustomItem,
                  icon: const Icon(Icons.add, color: Color(0xFF8C5F42)),
                  label: const Text(
                    '新增自訂項目',
                    style: TextStyle(color: Color(0xFF8C5F42)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF8C5F42)),
                    foregroundColor: const Color(0xFF8C5F42), // 按下的 splash 也可跟著變色
                  ),
                ),
              ],
            ),
          ),
        ),
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

class WaterFeeCard extends StatelessWidget {
  const WaterFeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16,),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDEE2E6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Switch(
                activeColor: const Color(0xFF8C5F42),
                value: true,
                onChanged: (val) {},
              ),
              const SizedBox(width: 8),
              const Text('水費',
                  style: TextStyle(fontSize: 15, fontFamily: 'PingFang TC')),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F6F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: '收費+方式'),
                    value: '每月',
                    items: const [
                      DropdownMenuItem(value: '每月', child: Text('每月')),
                      DropdownMenuItem(value: '單次', child: Text('單次')),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F6F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: '單價 (TWD)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
