import 'package:flutter/material.dart';

class UpgradedMailListPage extends StatefulWidget {
  const UpgradedMailListPage({Key? key}) : super(key: key);

  @override
  State<UpgradedMailListPage> createState() => _UpgradedMailListPageState();
}

class _UpgradedMailListPageState extends State<UpgradedMailListPage> {
  bool isSelecting = false;
  Set<int> selectedItems = {};

  // 改成可變 List
  List<String> mails = [
    '來自祥的需求 - 兒童程式設計',
    '來自林O靜的需求 - 電腦課程',
    'Figma 留言通知',
    '來自 Tamxxx 的需求 - 電腦課程',
    'Figma 留言通知',
  ];

  // 下拉選單的選項
  final List<String> shareChannels = [
    'Email',
    'Slack',
    'Telegram',
    'Copy Link',
  ];

  void _enterSelection(int index) {
    setState(() {
      isSelecting = true;
      selectedItems.add(index);
    });
  }

  void _toggleItem(int index) {
    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index);
        if (selectedItems.isEmpty) {
          isSelecting = false;
        }
      } else {
        selectedItems.add(index);
      }
    });
  }

  void _selectAllToggle() {
    setState(() {
      if (selectedItems.length == mails.length) {
        selectedItems.clear();
        isSelecting = false;
      } else {
        selectedItems = Set<int>.from(List.generate(mails.length, (i) => i));
        isSelecting = true;
      }
    });
  }

  void _deleteSelected() {
    final toRemove = selectedItems.toList()..sort((a, b) => b.compareTo(a));
    setState(() {
      for (final idx in toRemove) {
        mails.removeAt(idx);
      }
      selectedItems.clear();
      isSelecting = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已刪除選取的信件')),
    );
  }

  void _onSharePressed() {
    // 呼叫底部面板
    showModalBottomSheet(
      context: context,
      // 設為 true 可以讓 bottom sheet 滑動到安全區外
      isScrollControlled: true,
      builder: (context) {
        String? selectedChannel = shareChannels.first;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 16, right: 16, top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 標題
                  const Text(
                    '選擇分享方式',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // 下拉式選單
                  DropdownButtonFormField<String>(
                    value: selectedChannel,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: shareChannels.map((ch) {
                      return DropdownMenuItem(
                        value: ch,
                        child: Text(ch),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setModalState(() => selectedChannel = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  // 發送按鈕
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text('發送'),
                      onPressed: () {
                        // 在這裡處理真正分享邏輯
                        final items = selectedItems.map((i) => mails[i]).join('\n');
                        Navigator.of(context).pop(); // 先關閉 bottom sheet
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('已透過 $selectedChannel 分享 ${selectedItems.length} 封信件')),
                        );
                        // 例如：呼叫第三方分享套件、API 等
                        print('分享到 $selectedChannel：\n$items');
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          isSelecting
              ? '${selectedItems.length} 封已選取'
              : '選取發送對象',
          style: TextStyle(
            color: const Color(0xFF2B2F35),
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: isSelecting
            ? IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              isSelecting = false;
              selectedItems.clear();
            });
          },
        )
            : null,
        actions: isSelecting
            ? [
          IconButton(
            tooltip: '全選／取消全選',
            icon: Icon(
              selectedItems.length == mails.length
                  ? Icons.select_all_outlined
                  : Icons.select_all,
            ),
            onPressed: _selectAllToggle,
          ),
          IconButton(
            tooltip: '分享',
            icon: const Icon(Icons.share),
            onPressed: selectedItems.isEmpty ? null : _onSharePressed,
          ),
          IconButton(
            tooltip: '刪除',
            icon: const Icon(Icons.delete),
            onPressed: selectedItems.isEmpty ? null : _deleteSelected,
          ),
        ]
            : [
              Text(
          '2025 年 01 月帳單',
          style: TextStyle(
            color: const Color(0xFF986E49),
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
          SizedBox(width: 16,),
        ],
      ),
      body: ListView.builder(
        itemCount: mails.length,
        itemBuilder: (context, index) {
          final isSelected = selectedItems.contains(index);
          return GestureDetector(
            onLongPress: () => _enterSelection(index),
            onTap: () => _toggleItem(index),
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
                          '未繳款',
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
                        '\$12,000',
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
                      Stack(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFB6E4D0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          if (isSelecting && isSelected) // <= 加上 isSelected
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 14,
                                height: 12,
                                alignment: Alignment.center,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFF319877),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '林房客',
                              style: TextStyle(
                                color: const Color(0xFF2B2F35),
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  '租約固定金',
                                  style: TextStyle(
                                    color: const Color(0xFF525D68),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Text(
                                  '\$16,000',
                                  style: TextStyle(
                                    color: const Color(0xFFFF4444),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Text(
                                  '扣除金',
                                  style: TextStyle(
                                    color: const Color(0xFF525D68),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Text(
                                  '\$4,000',
                                  style: TextStyle(
                                    color: const Color(0xFFFF4444),
                                    fontSize: 14,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFCCCCCC),
                                          ),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Text(
                                        'M2-12A',
                                        style: TextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 12,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF319877),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFCCCCCC),
                                          ),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Text(
                                        'M2-12A電費',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: const Color(0xFFCCCCCC),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Text(
                                      '車位C88',
                                      style: TextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: const Color(0xFFCCCCCC),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Text(
                                      '車位C88',
                                      style: TextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
