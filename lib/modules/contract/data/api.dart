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
}