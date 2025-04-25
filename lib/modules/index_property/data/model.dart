class PropertyModel {
  final int propertyId;
  final String title;
  final int communityId;
  final String communityName;
  final int usageId;
  final int layoutId;
  final int defaultRent;
  final String address;
  final int status;
  final List<String> imageUrl;

  PropertyModel({
    required this.propertyId,
    required this.title,
    required this.communityId,
    required this.communityName,
    required this.usageId,
    required this.layoutId,
    required this.defaultRent,
    required this.address,
    required this.status,
    required this.imageUrl,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    // // 根據 type_id 設定背景色與文字色
    // late Color bgColor;
    // late Color txtColor;
    // switch (json['type_id'] as int) {
    //   case 1: // 一般
    //     bgColor = const Color(0xFFE8F6FF);
    //     txtColor = const Color(0xFF077FFF);
    //     break;
    //   case 2: // 重要
    //     bgColor = const Color(0xFFFFF2EF);
    //     txtColor = const Color(0xFFF16134);
    //     break;
    //   case 3: // 繳費
    //     bgColor = const Color(0xFFF3EEFF);
    //     txtColor = const Color(0xFF8F6BEB);
    //     break;
    //   case 4: // 家長留言板
    //     bgColor = const Color(0xFFECFFED);
    //     txtColor = const Color(0xFF64BF67);
    //     break;
    //   default:
    //     bgColor = Colors.white;
    //     txtColor = Colors.black;
    // }

    return PropertyModel(
      propertyId: json['property_id'] as int,
      title: json['title'] as String,
      communityId: json['community_id'] as int,
      communityName: json['community_name'] as String,
      usageId: json['usage_id'] as int,
      layoutId: json['layout_id'] as int,
      defaultRent: json['default_rent'] as int,
      address: json['address'] as String,
      status: json['status'] as int,
      imageUrl: json['image_url'],
    );
  }
}