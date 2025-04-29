import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> fetchData() async {
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

  Future<void> postData() async {
    try {
      final url = Uri.parse('$baseUrl/linebot/definitePayment');

      Map<String, dynamic> postData = {
        "to": ["Ub3ee89ca4da16225ff59b269c1adef0c"],
      };

      final http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        print(response.body);
        print('Data posted successfully');
      }
      else {
        print('Failed to post data. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error while post data: $e');
    }
  }
}