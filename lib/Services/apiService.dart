import 'dart:convert';
import 'package:inventory_demo/Models/CategoryListResponse.dart';

import '../Models/PropertyListResponse.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var url = 'http://10.0.2.2:7058';

  Future<List<PropertyListResponse>> getProperties() async {
    final response = await http.get(Uri.parse('$url/api/Properties'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => PropertyListResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load properties data');
    }
  }

  Future<List<CategoryListResponse>> getCategories() async {
    final response = await http.get(Uri.parse('$url/api/Categories'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => CategoryListResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load properties data');
    }
  }
}
