import 'package:flutter/material.dart';
import 'package:mylo/modules/index_accounts/widgets/index_accounts_widget_community.dart';
import 'package:mylo/modules/index_accounts/widgets/index_accounts_widget_landlord.dart';

class IndexAccounts extends StatefulWidget {
  const IndexAccounts({super.key});

  @override
  State<IndexAccounts> createState() => _MainAccountsState();
}

class _MainAccountsState extends State<IndexAccounts> {
  int _selectedTab = 0;
  List<String> tab = ['房東', '社區',];

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
                            _selectedTab = index;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: _selectedTab == index ? const BoxDecoration(
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
                              color: _selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
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
    switch (_selectedTab) {
      case 0:
        return IndexAccountsWidgetLandlord();
      case 1:
        return IndexAccountsWidgetCommunity();
      default:
        return const Center(child: Text("未知層級"));
    }
  }
}
