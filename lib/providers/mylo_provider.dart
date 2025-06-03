import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedItemProvider = StateProvider<int>((ref) => -1);
final rentProvider = StateProvider<int>((ref) => 0);
final contractDataProvider = StateProvider<Map<String, dynamic>>((ref) => {
  "property_id": 0,
  "lease_start": null,
  "lease_end": null,
  "rent": {
    "method_id": null,//月繳
    "amount": 0,
  },
  "deposit":{
    "deposit_months": null,      // 0 = 固定金額, 1 = 期數
    "deposit_amount": null,
  },
  // "rent": 0,
  // "deposit_months": 0,      // 0 = 固定金額, 1 = 月數
  // "deposit_amount": 0,   // 當 deposit_type = 0 時才生效
  "utility_fees": [],
  // {
    // "electricity_fee": {
    //   "amount": 1500,       // 電費金額
    //   "method_id": 2        // 2 = “每月與租金一起繳納”
    // },
    // "water_fee": {
    //   "amount": 300,        // 水費金額
    //   "method_id": 0        // 0 = “租客自繳”
    // },
    // "gas_fee": {
    //   "amount": 450,        // 瓦斯費用
    //   "method_id": 1        // 1 = “包含在租金”
    // },
    // "management_fee": {
    //   "amount": 800,        // 管理費
    //   "method_id": 3        // 3 = “每季”
    // }
  // }
  "signatories": [],
  "checklist": {
    "appliances": [],
    "furnitures": [],
  },
});