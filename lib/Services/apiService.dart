import 'dart:convert';
import 'package:inventory_demo/Models/Category/CategoryListResponse.dart';
import 'package:inventory_demo/Models/Personnel/PersonnelListResponse.dart';
import 'package:inventory_demo/Models/PersonnelProperty/PersonnelPropertyListResponse.dart';
import '../Models/Property/PropertyListResponse.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var url = 'http://10.0.2.2:7058/api';

  Future<List<PropertyListResponse>> getProperties() async {
    final response = await http.get(Uri.parse('$url/Properties'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => PropertyListResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load the data of properties');
    }
  }

  Future<PropertyListResponse> getPropertyByID(int propertyID) async {
    final response = await http.get(Uri.parse('$url/Properties/$propertyID'));

    if (response.statusCode == 200) {
      return PropertyListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the data of property');
    }
  }

  Future<List<CategoryListResponse>> getCategories() async {
    final response = await http.get(Uri.parse('$url/Categories'));

    if (response.statusCode == 200) {
      var categories = (json.decode(response.body) as List)
          .map((item) => CategoryListResponse.fromJson(item))
          .toList();
      categories.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      return categories;
    } else {
      throw Exception('Failed to load the data of categories');
    }
  }

  Future<List<PersonnelListResponse>> getPersonnel() async {
    final response = await http.get(Uri.parse('$url/Personnels'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => PersonnelListResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load the data of personnel');
    }
  }

  Future<List<PersonnelPropertyListResponse>> getPropertiesOfPersonnel(
      int personnelID, bool isWaiting) async {
    final response =
        await http.get(Uri.parse('$url/Personnels/$personnelID/Properties'));

    if (response.statusCode == 200) {
      var personnelProperties = (json.decode(response.body) as List)
          .map((item) => PersonnelPropertyListResponse.fromJson(item))
          .where((item) => item.isWaiting == isWaiting)
          .toList();
      personnelProperties.sort((a, b) {
        return a.dueOn.toString().compareTo(b.dueOn.toString());
      });

      return personnelProperties;
    } else {
      throw Exception('Failed to load the data of personnel properties');
    }
  }

  Future<dynamic> userLogin(String username, String password) async {
    final response = await http.post(Uri.parse('$url/Users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"username": username, "password": password}));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["token"] != null) {
        var userInfo = getUserInformation(data["token"].toString());
        return userInfo;
      } else {
        return data["message"];
      }
    } else {
      throw Exception('Failed to execute login operation. Try again!');
    }
  }

  List<String> getUserInformation(String jwtToken) {
    final parts = jwtToken.split(".");
    final payload = base64Url.normalize(parts[1]);
    final payloadMap = json.decode(utf8.decode(base64Url.decode(payload)));

    List<String> userInfo = [];
    userInfo.add(payloadMap["unique_name"]);
    userInfo.add(payloadMap["role"]);

    return userInfo;
  }
}
