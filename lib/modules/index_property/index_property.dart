import 'package:flutter/material.dart';
import 'package:mylo/modules/index_property/widgets/widget_community.dart';
import 'package:mylo/modules/index_property/widgets/widget_property.dart';

class MainProperty extends StatefulWidget {
  const MainProperty({super.key});

  @override
  State<MainProperty> createState() => _MainPropertyState();
}

class _MainPropertyState extends State<MainProperty> {
  int selectedTab = 0;
  List<String> tab = ['社區', '物件',];

  Future<Map<String, dynamic>> fetchData() async {
    try {
      String urlString = 'https://rencoo.com.tw/api/v1/properties?community_id=1';
      final url = Uri.parse(urlString);
      final response = await http.get(
        url,
        //headers: {
        //  'Authorization': 'Bearer $token',
        //},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> dataJson = json.decode(response.body);
        print(dataJson);

        // if (dataJson['image_url'] != null) {
        //   try {
        //     String urlString = '$_baseUrl/upload/view';
        //     final url = Uri.parse('$urlString?gcs_url=${dataJson['image_url']}');
        //     final response = await http.get(
        //       url,
        //       headers: {
        //         'Authorization': 'Bearer $token',
        //       },
        //     );
        //     if (response.statusCode == 200) {
        //       img = json.decode(response.body)['preview_url'];
        //     }
        //
        //   } catch (e) {
        //     print('Error fetching image: $e');
        //   }
        // }

        return dataJson;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }

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
        return WidgetProperty();
      default:
        return const Center(child: Text("未知層級"));
    }
  }
}
