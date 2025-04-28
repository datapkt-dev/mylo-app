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
      appBar: AppBar(
        title: Text(
          isSelecting
              ? '${selectedItems.length} 封已選取'
              : 'Gmail 風格信件列表',
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
            : null,
      ),
      body: ListView.builder(
        itemCount: mails.length,
        itemBuilder: (context, index) {
          final isSelected = selectedItems.contains(index);
          return ListTile(
            leading: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: child,
              ),
              child: isSelecting
                  ? Checkbox(
                key: ValueKey('cb_$index'),
                value: isSelected,
                onChanged: (_) => _toggleItem(index),
              )
                  : Icon(
                Icons.mark_email_unread,
                key: ValueKey('icon_$index'),
                size: 32,
              ),
            ),
            title: Text(mails[index]),
            onLongPress: () => _enterSelection(index),
            onTap: () => _toggleItem(index),
          );
        },
      ),
    );
  }
}
