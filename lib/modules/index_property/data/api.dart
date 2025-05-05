import 'dart:convert';
// import 'model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> fetchData({int? status}) async {
    try {
      String urlString = '$baseUrl/api/v1/properties?community_id=1&page_size=10&page=1';
      if (status != 0 && status != null) {
        if (status == 1) {
          urlString += '&status=3';
        }
        if (status == 2) {
          urlString += '&status=4';
        }
      }
      print(urlString);
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
}