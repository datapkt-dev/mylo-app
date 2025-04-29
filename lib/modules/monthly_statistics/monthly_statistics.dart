import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mylo/modules/monthly_statistics/pages/tenant_details.dart';
import 'package:mylo/modules/monthly_statistics/widgets/monthly_statistics_widget_property.dart';
// import 'package:mylo/modules/monthly_statistics/widgets/monthly_statistics_widget_tenant.dart';
import '../../temp/longpresslab.dart';
import 'data/api.dart';

class MonthlyStatisticsPage extends StatefulWidget {
  const MonthlyStatisticsPage({super.key});

  @override
  State<MonthlyStatisticsPage> createState() => _MonthlyStatisticsPageState();
}

class _MonthlyStatisticsPageState extends State<MonthlyStatisticsPage> {
  final String baseUrl = 'https://rencoo.com.tw';

  int selectedTab = 0;
  List<String> tabs = ['房客', '物件',];

  bool isSelecting = false;
  Set<int> selectedItems = {};

  late final ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: baseUrl);
    // futureData = apiService.fetchData();
  }

  void enterSelection(int index) {
    setState(() {
      isSelecting = true;
      selectedItems.add(index);
    });
  }

  void toggleItem(int index) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              Text(
                '好好住社區',
                style: TextStyle(
                  color: const Color(0xFF2B2F35),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                '2025 年 01 月帳單',
                style: TextStyle(
                  color: const Color(0xFF986E49),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: !isSelecting
                  ? Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16,),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xFF4ADAAC).withOpacity(0.4),
                          Color(0xFFFFB98D).withOpacity(0.4),
                        ],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '本月已收',
                            style: TextStyle(
                              color: const Color(0xFF5F6E7B),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '\$397,400',
                            style: TextStyle(
                              color: const Color(0xFFFF4444),
                              fontSize: 24,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GradientProgressBar(progress: 0.5),
                              ),
                              SizedBox(width: 8,),
                              Text(
                                '100%',
                                style: TextStyle(
                                  color: const Color(0xFF2B2F35),
                                  fontSize: 15,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$397,400',
                                    style: TextStyle(
                                      color: const Color(0xFF2B2F35),
                                      fontSize: 16,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    '本月應收',
                                    style: TextStyle(
                                      color: const Color(0xFF5F6E7B),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '30',
                                    style: TextStyle(
                                      color: const Color(0xFF2B2F35),
                                      fontSize: 15,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    '已收款',
                                    style: TextStyle(
                                      color: const Color(0xFF5F6E7B),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '30',
                                    style: TextStyle(
                                      color: const Color(0xFF2B2F35),
                                      fontSize: 16,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    '待收款',
                                    style: TextStyle(
                                      color: const Color(0xFF5F6E7B),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '30',
                                    style: TextStyle(
                                      color: const Color(0xFF2B2F35),
                                      fontSize: 16,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    '待確認',
                                    style: TextStyle(
                                      color: const Color(0xFF5F6E7B),
                                      fontSize: 15,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(tabs.length, (index) {
                      return Expanded(
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: IntrinsicWidth(
                            child: GestureDetector(
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
                                  tabs[index],
                                  style: TextStyle(
                                    color: selectedTab == index ? const Color(0xFF986E49) : const Color(0xFF2B2F35),
                                    fontSize: 15,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              )
                  : SizedBox.shrink(),
            ),
            // TextButton(
            //   onPressed: () {
            //     setState(() {
            //       _isVisible = !_isVisible;
            //     });
            //   },
            //   child: Text(_isVisible ? '收合' : '展開'),
            // ),
            _buildContent(),
          ],
        ),
        bottomNavigationBar: isSelecting ? Padding(
          padding: EdgeInsets.only(top: 10,right: 16, left: 16, bottom: 45,),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                      activeColor: Color(0xFF319877),
                    ),
                    Text(
                      '全選',
                      style: TextStyle(
                        color: const Color(0xFF2B2F35),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelecting = false;
                      selectedItems.clear();
                    });
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFCBD2D6),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      '返回',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF2B2F35),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ),
              SizedBox(width: 16,),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16,),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        '發送訊息',
                                        style: TextStyle(
                                          color: const Color(0xFF2B2F35),
                                          fontSize: 16,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16,),
                                    Text(
                                      '發送方式',
                                      style: TextStyle(
                                        color: const Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      alignment: AlignmentDirectional.centerStart,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF4F6F7),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFF4F6F7),
                                          ),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      child: Text(
                                        '選擇發送方式',
                                        style: TextStyle(
                                          color: const Color(0xFF7B8A95),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      alignment: AlignmentDirectional.centerStart,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF4F6F7),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFF4F6F7),
                                          ),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      child: Text(
                                        '選擇範本',
                                        style: TextStyle(
                                          color: const Color(0xFF7B8A95),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      alignment: AlignmentDirectional.centerStart,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF4F6F7),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFF4F6F7),
                                          ),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      child: Text(
                                        '訊息內容',
                                        style: TextStyle(
                                          color: const Color(0xFF7B8A95),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: true,
                                          onChanged: (bool? value) {},
                                          activeColor: Color(0xFF319877),
                                        ),
                                        Text(
                                          '存為範本',
                                          style: TextStyle(
                                            color: const Color(0xFF323232),
                                            fontSize: 14,
                                            fontFamily: 'PingFang TC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(width: 12,),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                            alignment: AlignmentDirectional.centerStart,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFF4F6F7),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: const Color(0xFFF4F6F7),
                                                ),
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                            ),
                                            child: Text(
                                              '範本名稱',
                                              style: TextStyle(
                                                color: const Color(0xFF7B8A95),
                                                fontSize: 15,
                                                fontFamily: 'PingFang TC',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      '發送時間',
                                      style: TextStyle(
                                        color: const Color(0xFF2B2F35),
                                        fontSize: 15,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      alignment: AlignmentDirectional.centerStart,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF4F6F7),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFF4F6F7),
                                          ),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      child: Text(
                                        '立即發送',
                                        style: TextStyle(
                                          color: const Color(0xFF2B2F35),
                                          fontSize: 15,
                                          fontFamily: 'PingFang TC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: const Color(0xFFCBD2D6),
                                                  ),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                                '返回',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: const Color(0xFF2B2F35),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16,),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              print('post');
                                              apiService.postData();
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFF319877),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                              ),
                                              child: Text(
                                                '發送',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF319877),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text(
                      '選取 ${selectedItems.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) : null,
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedTab) {
      case 0:
        return testContent();
      case 1:
        return MonthlyStatisticsWidgetProperty();
      default:
        return const Center(child: Text("未知層級"));
    }
  }

  Widget testContent() {
    return Expanded(
      child: Column(
        children: [
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: !isSelecting
                ? Container(
              margin: EdgeInsets.symmetric(horizontal: 16,),
              padding: EdgeInsets.symmetric(vertical: 6,),
              child: Row(
                children: [
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpgradedMailListPage(),),);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/index/filter.svg',
                          color: Colors.black,
                        ),
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
                ],
              ),
            )
                : SizedBox.shrink(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(6, (index) {
                  final isSelected = selectedItems.contains(index);
                  return GestureDetector(
                    onLongPress: () {
                      if (!isSelecting) {
                        enterSelection(index);
                      }
                    },
                    onTap: () {
                      if (isSelecting) {
                        toggleItem(index);
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => TenantDetailsPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0); // 從下往上
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                    },
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
                                              if (!isSelecting) {
                                                showModalBottomSheet(
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    bool paid = false;
                                                    return StatefulBuilder(
                                                      builder: (BuildContext context, StateSetter setState) {
                                                        return Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.symmetric(horizontal: 16,),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(height: 30,),
                                                              Center(
                                                                child: Text(
                                                                  '應繳項目',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 16,
                                                                    fontFamily: 'PingFang SC',
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 16,),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '租約固定金',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 8,),
                                                                  Text(
                                                                    '\$14500',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFFFF4444),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    '已繳費',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  Transform.scale(
                                                                    scale: 0.8,
                                                                    child: Switch(
                                                                      value: paid,
                                                                      activeColor: const Color(0xFF8C5F42),
                                                                      onChanged: (bool value) async {
                                                                        setState(() {
                                                                          paid = !paid;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 5,),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '水費(月)',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    '\$5600',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '水費(月)',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    '\$5600',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '水費(月)',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    '\$5600',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 24,),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                      height: 40,
                                                                      alignment: Alignment.center,
                                                                      decoration: ShapeDecoration(
                                                                        color: Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                          side: BorderSide(
                                                                            width: 1,
                                                                            color: const Color(0xFFCBD2D6),
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(4),
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                        '返回',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          color: const Color(0xFF2B2F35),
                                                                          fontSize: 14,
                                                                          fontFamily: 'Poppins',
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 16,),
                                                                  Expanded(
                                                                    child: Container(
                                                                      height: 40,
                                                                      alignment: Alignment.center,
                                                                      decoration: ShapeDecoration(
                                                                        color: const Color(0xFF319877),
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                                      ),
                                                                      child: Text(
                                                                        '確定',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 14,
                                                                          fontFamily: 'PingFang SC',
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 50,),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 4),
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: ShapeDecoration(
                                                color: isSelecting ? const Color(0xFFF4F6F7) : null,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: isSelecting ? const Color(0xFFCBD2D6) : const Color(0xFFCCCCCC),
                                                  ),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                                'M2-12A',
                                                style: TextStyle(
                                                  color: isSelecting ? const Color(0xFFA6B1BA) : const Color(0xFF333333),
                                                  fontSize: 12,
                                                  fontFamily: 'PingFang TC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (!isSelecting) {
                                                showModalBottomSheet(
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    bool paid = false;
                                                    return StatefulBuilder(
                                                      builder: (BuildContext context, StateSetter setState) {
                                                        return Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.symmetric(horizontal: 16,),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(height: 30,),
                                                              Center(
                                                                child: Text(
                                                                  '應繳項目',
                                                                  style: TextStyle(
                                                                    color: const Color(0xFF2B2F35),
                                                                    fontSize: 16,
                                                                    fontFamily: 'PingFang SC',
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 16,),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'M3-12A電費',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Transform.scale(
                                                                    scale: 0.8,
                                                                    child: Switch(
                                                                      value: paid,
                                                                      activeColor: const Color(0xFF8C5F42),
                                                                      onChanged: (bool value) async {
                                                                        setState(() {
                                                                          paid = !paid;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 5,),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '電費(度)',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 12,),
                                                                  Text(
                                                                    '\$6/度',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 12,),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '上期電度',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF5F6E7B),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 12,),
                                                                  Text(
                                                                    '150度',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 12,),
                                                                  Text(
                                                                    '\$900',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFFFF4444),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  SizedBox(
                                                                    height: 70,
                                                                    width: 70,
                                                                    child: Image.asset('assets/images/electricity_meter.png'),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(height: 16,),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '本期電度',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF2B2F35),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 12,),
                                                                  Container(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                                                                    decoration: ShapeDecoration(
                                                                      color: const Color(0xFFF4F6F7),
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          width: 1,
                                                                          color: const Color(0xFFF4F6F7),
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(3),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          '200',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF2B2F35),
                                                                            fontSize: 15,
                                                                            fontFamily: 'PingFang TC',
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 10,),
                                                                        Text(
                                                                          '度',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF7B8A95),
                                                                            fontSize: 15,
                                                                            fontFamily: 'PingFang TC',
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 12,),
                                                                  Text(
                                                                    '\$1200',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFFFF4444),
                                                                      fontSize: 15,
                                                                      fontFamily: 'PingFang TC',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  SizedBox(
                                                                    height: 70,
                                                                    width: 70,
                                                                    child: Image.asset('assets/images/electricity_meter.png'),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 24,),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                      height: 40,
                                                                      alignment: Alignment.center,
                                                                      decoration: ShapeDecoration(
                                                                        color: Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                          side: BorderSide(
                                                                            width: 1,
                                                                            color: const Color(0xFFCBD2D6),
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(4),
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                        '返回',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          color: const Color(0xFF2B2F35),
                                                                          fontSize: 14,
                                                                          fontFamily: 'Poppins',
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 16,),
                                                                  Expanded(
                                                                    child: Container(
                                                                      height: 40,
                                                                      alignment: Alignment.center,
                                                                      decoration: ShapeDecoration(
                                                                        color: const Color(0xFF319877),
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                                      ),
                                                                      child: Text(
                                                                        '確定',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 14,
                                                                          fontFamily: 'PingFang SC',
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 50,),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 4),
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: ShapeDecoration(
                                                color: isSelecting ? const Color(0xFFF4F6F7) : const Color(0xFF319877),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: isSelecting ? const Color(0xFFCBD2D6) : const Color(0xFFCCCCCC),
                                                  ),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                                'M2-12A電費',
                                                style: TextStyle(
                                                  color: isSelecting ? const Color(0xFFA6B1BA) : Colors.white,
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
                                              color: isSelecting ? const Color(0xFFF4F6F7) : null,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: isSelecting ? const Color(0xFFCBD2D6) : const Color(0xFFCCCCCC),
                                                ),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: Text(
                                              '車位C88',
                                              style: TextStyle(
                                                color: isSelecting ? const Color(0xFFA6B1BA) : const Color(0xFF333333),
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
                                              color: isSelecting ? const Color(0xFFF4F6F7) : null,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: isSelecting ? const Color(0xFFCBD2D6) : const Color(0xFFCCCCCC),
                                                ),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: Text(
                                              '車位C88',
                                              style: TextStyle(
                                                color: isSelecting ? const Color(0xFFA6B1BA) : const Color(0xFF333333),
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
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientProgressBar extends StatelessWidget {
  final double progress;

  const GradientProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: const Color(0xFFE3E7EA),
        borderRadius: BorderRadius.circular(5),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF538), Color(0xFF029767)],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
