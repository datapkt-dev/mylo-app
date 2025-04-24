import 'package:flutter/material.dart';
import 'package:mylo/modules/index_property/widgets/widget_community.dart';

class MainProperty extends StatefulWidget {
  const MainProperty({super.key});

  @override
  State<MainProperty> createState() => _MainPropertyState();
}

class _MainPropertyState extends State<MainProperty> {
  int selectedTab = 0;
  List<String> tab = ['社區', '物件',];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: List.generate(tab.length, (index) {
                return Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: IntrinsicWidth(
                      child: InkWell(
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
                            tab[index],
                            style: TextStyle(
                              color: selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
                              fontSize: 15,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 8,),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedTab) {
      case 0:
        return WidgetCommunity();
      case 1:
        return Center(
          child: Text('尚未開放'),
        );
      default:
        return const Center(child: Text("未知層級"));
    }
  }
}
