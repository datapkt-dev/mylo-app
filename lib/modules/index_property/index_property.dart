import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'data/api.dart';
// import 'data/model.dart';
import 'package:mylo/modules/index_property/pages/property_community_statistics.dart';

class IndexPropertyPage extends StatefulWidget {
  const IndexPropertyPage({super.key});

  @override
  State<IndexPropertyPage> createState() => _MainPropertyState();
}

class _MainPropertyState extends State<IndexPropertyPage> {
  final String baseUrl = 'https://rencoo.com.tw';

  int selectedType = 0;
  List<String> types = ['全部', '未出租', '已出租'];

  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  @override
  void initState() {
    super.initState();

    apiService = ApiService(baseUrl: baseUrl);

    futureData = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              scrolledUnderElevation: 0,
              centerTitle: false,
              title: const Text(
                '好好住社區',
                style: TextStyle(
                  color: Color(0xFF603E33),
                  fontSize: 20,
                  fontFamily: 'PingFang TC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            Row(
              children: [
                SizedBox(width: 16,),
                Row(
                  children: List.generate(types.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          setState(() {
                            selectedType = index;
                          });
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 32,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 8,),
                        decoration: ShapeDecoration(
                          color: selectedType == index ? const Color(0xFFD9F2E5) :const Color(0xFFF4F6F7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: selectedType == index ? const Color(0xFF319877) : const Color(0xFFCBD2D6),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          types[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedType == index ? const Color(0xFF319877) : const Color(0xFFA6B1BA),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 16,),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 16,),
                Text(
                  '6個物件',
                  style: TextStyle(
                    color: const Color(0xFF5F6E7B),
                    fontSize: 14,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/index/filter.svg',
                      color: Colors.black,
                    ),
                    SizedBox(width: 4,),
                    Text(
                      '篩選',
                      style: TextStyle(
                        color: const Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16,),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/index/sort.svg',
                      color: Colors.black,
                    ),
                    SizedBox(width: 4,),
                    Text(
                      '排序',
                      style: TextStyle(
                        color: const Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16,),
                Row(
                  children: [
                    Icon(Icons.search_rounded,size: 18,),
                    SizedBox(width: 4,),
                    Text(
                      '搜尋',
                      style: TextStyle(
                        color: const Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16,),
              ],
            ),
            SizedBox(height: 8,),
            FutureBuilder(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '發生錯誤: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  dataList = snapshot.data!;
                }
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(dataList.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16,),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PropertyCommunityStatisticsPage(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
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
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFFFE4E4),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: Text(
                                      '未出租',
                                      style: TextStyle(
                                        color: const Color(0xFFFF4444),
                                        fontSize: 12,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${dataList[index]['community_name']}',
                                            style: TextStyle(
                                              color: const Color(0xFF2B2F35),
                                              fontSize: 16,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 4,),
                                          Text(
                                            '${dataList[index]['address']}',
                                            style: TextStyle(
                                              color: const Color(0xFF5F6E7B),
                                              fontSize: 15,
                                              fontFamily: 'PingFang TC',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 4,),
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
                                              SizedBox(width: 10,),
                                              Text(
                                                '\$${dataList[index]['default_rent']}',
                                                style: TextStyle(
                                                  color: const Color(0xFFFF4444),
                                                  fontSize: 14,
                                                  fontFamily: 'PingFang TC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 72,
                                        height: 72,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              color: const Color(0xFFDEE2E6),
                                            ),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4), // 圓角要跟外層一樣
                                          child: Image.asset(
                                            'assets/images/property.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
