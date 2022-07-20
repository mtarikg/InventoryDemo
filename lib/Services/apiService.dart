import 'dart:convert';
import 'package:inventory_demo/Models/Category/CategoryListResponse.dart';
import 'package:inventory_demo/Models/Personnel/PersonnelListResponse.dart';
import 'package:inventory_demo/Models/PersonnelProperty/PersonnelPropertyListResponse.dart';
import '../Models/Property/PropertyListResponse.dart';
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
      throw Exception('Failed to load the data of properties');
    }
  }

  Future<PropertyListResponse> getPropertyByID(int propertyID) async {
    final response =
        await http.get(Uri.parse('$url/api/Properties/$propertyID'));

    if (response.statusCode == 200) {
      return PropertyListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the data of property');
    }
  }

  Future<List<CategoryListResponse>> getCategories() async {
    final response = await http.get(Uri.parse('$url/api/Categories'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => CategoryListResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load the data of categories');
    }
  }

  Future<List<PersonnelListResponse>> getPersonnels() async {
    final response = await http.get(Uri.parse('$url/api/Personnels'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => PersonnelListResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load the data of personnel');
    }
  }

  Future<List<PersonnelPropertyListResponse>> getPropertiesOfPersonnel(
      int personnelID) async {
    final response =
        await http.get(Uri.parse('$url/api/Personnels/$personnelID'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => PersonnelPropertyListResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load the data of personnel properties');
    }
  }
}
