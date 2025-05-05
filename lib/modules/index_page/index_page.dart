import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List aname = ['數位神壇', '清明祭祖', '中元普渡', '地基主', '安太歲'];
  final fName = ['智慧香爐', '電子佛經', '菩提商城', '淨心佛樂'];
  final icons = [
    SvgPicture.asset('assets/icons/frame/index.svg'),
    SvgPicture.asset('assets/icons/frame/property.svg'),
    SvgPicture.asset('assets/icons/frame/contract.svg'),
    SvgPicture.asset('assets/icons/frame/accounts.svg'),
  ];
  final List nContent = [
    '2024宜興國際素博會，精彩素食文化盛宴將隆重登場',
    '清明時節佛光山朝聖，信眾與國際旅人禮拜大師',
    '佛光山極樂寺 水南洞陰陽海淨灘 用行動回饋社會 清明時節佛光山朝聖，信眾與國際旅人禮拜大師',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Container(
          child: Text(
            '麥落',
            style: TextStyle(
              color: Color(0xFF202531),
              fontSize: 22,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 99,
                color: Colors.red,
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(fName.length, (index) {
                    return InkWell(
                      onTap: () async {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index]));
                      },
                      child: Column(
                        children: [
                          icons[index],
                          SizedBox(height: 8,),
                          Text(
                            fName[index],
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 13,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'blockText',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '查看更多',
                      style: TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 158,
                                height: 106,
                                color: Colors.black,
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Text(
                                  '10:22',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          SizedBox(
                            width: 158,
                            child: Text(
                              '${index +1} 菩提子的故事 掉落人間的種子',
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 15,
                                fontFamily: 'PingFang TC',
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'blockText',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '查看更多',
                      style: TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: Text(
                            '打坐時無法集中注意力，念經也是無法念的很順暢，請求幫忙感恩。阿彌陀佛打坐時無法集中注意力，念經也是無法念的很順暢，請求幫忙感恩。阿彌陀佛',
                            style: TextStyle(
                              color: Color(0xFF6D6D6D),
                              fontSize: 15,
                              fontFamily: 'PingFang TC',
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        // SvgPicture.asset(
                        //   width: 20,
                        //   'assets/icons/logo_mini.svg',
                        // ),
                        SizedBox(width: 4,),
                        Text(
                          '雲願香',
                          style: TextStyle(
                            color: Color(0xFFFF6160),
                            fontSize: 15,
                            fontFamily: 'PingFang TC',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: ShapeDecoration(
                        color: Color(0x19EB5F5D),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Text(
                        '這是由於念誦者心力不足所導致的，也就是說因為在念誦時，觀照力沒有生起對自己所面對境這是由於念誦者心力不足所導致的，也就是說因為在念誦時，觀照力沒有生起對自己所面對境',
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 15,
                          fontFamily: 'PingFang TC',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'blockText',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '查看更多',
                      style: TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(aname.length, (index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () {
                            // print(aname[index]);
                            // if(index==1) {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                            // }
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                color: Colors.yellow,
                                // child: Image.asset('assets/images/activities.png',),
                              ),
                              SizedBox(height: 8,),
                              Text(
                                aname[index],
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 13,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'blockText',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '查看更多',
                      style: TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 15,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: List<Widget>.generate(3, (index) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 22,
                                    padding: const EdgeInsets.all(4),
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(1.00, -0.00),
                                        end: Alignment(-1, 0),
                                        colors: [Color(0xFFFF7372), Color(0xFFFF6160)],
                                      ),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '新聞',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'PingFang TC',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '2024/05/01',
                                    style: TextStyle(
                                      color: Color(0xFF6D6D6D),
                                      fontSize: 12,
                                      fontFamily: 'PingFang TC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text(
                                nContent[index],
                                style: TextStyle(
                                  color: Color(0xFF202531),
                                  fontSize: 15,
                                  fontFamily: 'PingFang TC',
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 12,),
                        Container(
                          width: 148,
                          height: 88,
                          color: Colors.orange,
                          // decoration: ShapeDecoration(
                          //   image: DecorationImage(
                          //     image: AssetImage('assets/images/news.png'),
                          //     fit: BoxFit.cover,
                          //   ),
                          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          // ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}
