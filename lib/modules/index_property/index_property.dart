import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
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
  List<String> types = ['全部', '未出租', '已出租',];

  late final ApiService apiService;
  late Future<List<dynamic>> futureData;
  late List<dynamic> dataList;

  @override
  void initState() {
    super.initState();

    apiService = ApiService(baseUrl: baseUrl);

    futureData = apiService.fetchData();
  }

  Future<void> handleRefresh() async {
    setState(() {
      futureData = apiService.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFE3C2),
            Color(0xFFC4A580),
          ],
        ),
      ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF4F6F7),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF4F6F7)),
                    borderRadius: BorderRadius.circular(33),
                  ),
                ),
                child: TextField(
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: '搜尋關鍵字',
                    hintStyle: TextStyle(
                      color: Color(0xFF5F6E7B),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20,),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 16,),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Color(0xFFCBD2D6)),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(types.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = index;
                                  futureData = apiService.fetchData(status: index);
                                });
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 25,),
                                decoration: selectedType == index ? const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 2, color: Color(0xFF986E49)),
                                  ),
                                ) : null,
                                child: Text(
                                  types[index],
                                  style: TextStyle(
                                    color: selectedType == index ? const Color(0xFF986E49) : const Color(0xFF333333),
                                    fontSize: 15,
                                    fontFamily: selectedType == index ? 'PingFang SC' : 'PingFang TC',
                                    fontWeight: selectedType == index ? FontWeight.w500 : FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    FutureBuilder(
                      future: futureData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // return const Center(child: CircularProgressIndicator());
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: shimmerList(),
                          );
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 16,),
                                  Text(
                                    '${dataList.length}個物件',
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
                                ],
                              ),
                              SizedBox(height: 8,),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: handleRefresh,
                                  child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
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
                                                            '${dataList[index]['title']}',
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
                                                          child: Image.network(
                                                            'http://rencoo.com.tw/${dataList[index]['image_url'][0]}',
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
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 18,
                color: Colors.white,
              ),
              Spacer(),
              Container(
                width: 50,
                height: 18,
                color: Colors.white,
              ),
              SizedBox(width: 20,),
              Container(
                width: 50,
                height: 18,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 8,),
          Container(
            // height: 133,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              // color: const Color(0xFFFFFFFF),
              border: Border.all(
                color: const Color(0xFFDEE2E6),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A222222),
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 21,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 16,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8,),
                        Container(
                          width: 200,
                          height: 16,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 15,),
                            Container(
                              width: 55,
                              height: 16,
                              color: Colors.white,
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
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
