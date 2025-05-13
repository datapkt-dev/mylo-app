import 'package:flutter/material.dart';

class UtilityFeesPage extends StatefulWidget {
  const UtilityFeesPage({super.key});

  @override
  State<UtilityFeesPage> createState() => _UtilityFeesPageState();
}

class _UtilityFeesPageState extends State<UtilityFeesPage> {
  final List<Widget> _customItems = [];
  int _depositMonths = 0;

  void _addCustomItem() {
    setState(() {
      _customItems.add(const WaterFeeCard());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新增物件')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 租金設定區塊
          const Text('預設租金與費用', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFDEE2E6)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('租金', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: '幣別'),
                        value: null,
                        items: const [
                          DropdownMenuItem(value: 'TWD', child: Text('TWD')),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: '每月租金'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 押金區塊
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFDEE2E6)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.info_outline, size: 16),
                    SizedBox(width: 4),
                    Text('租金和押金', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('計算基準*', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Radio(value: true, groupValue: true, onChanged: (_) {}),
                    const Text('每月租金'),
                    const SizedBox(width: 16),
                    Radio(value: false, groupValue: true, onChanged: (_) {}),
                    const Text('固定金額'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (_depositMonths > 0) _depositMonths--;
                        });
                      },
                    ),
                    Text('$_depositMonths 個月'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          _depositMonths++;
                        });
                      },
                    ),
                    const Spacer(),
                    Text('共計：TWD 0'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const WaterFeeCard(),
          const SizedBox(height: 16),
          ..._customItems,
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _addCustomItem,
            icon: const Icon(Icons.add),
            label: const Text('新增自訂項目'),
          ),
        ],
      ),
    );
  }
}

class WaterFeeCard extends StatelessWidget {
  const WaterFeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              Switch(value: true, onChanged: (val) {}),
              const SizedBox(width: 8),
              const Text('水費',
                  style: TextStyle(fontSize: 15, fontFamily: 'PingFang TC')),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: '收費方式'),
                  value: '每月',
                  items: const [
                    DropdownMenuItem(value: '每月', child: Text('每月')),
                    DropdownMenuItem(value: '單次', child: Text('單次')),
                  ],
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: '單價 (TWD)'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}