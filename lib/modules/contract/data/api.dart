import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> fetchData({String? keyword}) async {
    try {
      String urlString = '$baseUrl/api/v1/properties?page_size=10&page=1&status=3';
      if (keyword != null) {
        urlString += '&search_title=$keyword';
      }
      final url = Uri.parse(urlString);
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> dataJson = json.decode(response.body);
        List<dynamic> dataList = dataJson['data'];

        return dataList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchPayment() async {
    try {
      String urlString = '$baseUrl/api/v1/rant_methods';
      final url = Uri.parse(urlString);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> dataJson = json.decode(response.body);
        List<dynamic> dataList = dataJson['data'];

        return dataList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchCity() async {
    try {
      String urlString = '$baseUrl/api/v1/divisionsTW';
      final url = Uri.parse(urlString);
      final response = await http.get(
        url,
        //headers: {
        //  'Authorization': 'Bearer $token',
        //},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> dataJson = json.decode(response.body);
        List<dynamic> dataList = dataJson['data'];

        return dataList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchCost() async {
    try {
      String urlString = '$baseUrl/api/v1/fees';
      final url = Uri.parse(urlString);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> dataJson = json.decode(response.body);
        List<dynamic> dataList = dataJson['data'];

        return dataList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchEquipment() async {
    try {
      String urlString = '$baseUrl/api/v1/checking_equips';
      final url = Uri.parse(urlString);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> dataJson = json.decode(response.body);
        Map<String, dynamic> dataList = dataJson['data'];

        return dataList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }

  Future<void> postNewContract(Map<String, dynamic> contract) async {
    try {
      // String? token = await authStorage.getToken();
      final url = Uri.parse('$baseUrl/api/v1/leases');

      // if (pathImg.isNotEmpty) {
      //   for (var image in pathImg) {
      //     final url = Uri.parse('$_baseUrl/upload/file');
      //
      //     final request = http.MultipartRequest('POST', url)
      //       ..headers["Authorization"] = "Bearer $token"
      //       ..files.add(
      //         await http.MultipartFile.fromPath(
      //           'file',
      //           image[0],
      //           filename: path.basename(image[0]),
      //         ),
      //       );
      //
      //     try {
      //       final response = await request.send();
      //       final responseBody = await response.stream.bytesToString();
      //       imgTemp.add(jsonDecode(responseBody)['gcs_url']);
      //
      //       if (response.statusCode == 200) {
      //         print("Upload successful");
      //         // print("Upload successful: ${jsonDecode(responseBody)}");
      //       } else {
      //         print("Upload failed: ${response.statusCode} - ${jsonDecode(responseBody)}");
      //         setState(() {
      //           loading = false;
      //         });
      //         Fluttertoast.showToast(msg: "上傳圖片失敗，請檢查檔案大小");
      //         return; // 中止function
      //       }
      //     } catch (e) {
      //       print("Error uploading file: $e");
      //       setState(() {
      //         loading = false;
      //       });
      //       Fluttertoast.showToast(msg: "上傳圖片失敗，請檢查檔案大小");
      //       return; // 中止function
      //     }
      //   }
      // }

      final http.Response response = await http.post(
        url,
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Authorization': 'Bearer $token',
        // },
        body: jsonEncode(contract),
      );

      if (response.statusCode == 201) {
        print(jsonDecode(response.body));
        print('Post new contract successfully');
      }
      else {
        print('Failed to post new contract. Status code: ${response.statusCode}');
        print('Response: ${jsonDecode(response.body)}');
      }
    } catch (e) {
      print('Error while post new contract: $e');
    }
  }
}