import 'dart:convert';

import 'package:inventory_demo/Services/apiService.dart';
import '../Models/PersonnelProperty/PersonnelPropertyEditRequest.dart';
import '../Models/Property/PropertyListResponse.dart';
import 'package:http/http.dart' as http;

class PersonnelService {
  var url = 'http://10.0.2.2:7058/api';
  ApiService apiService = ApiService();

  Future<PropertyListResponse?> getPropertyByCategory(
      int propertyID, int categoryID) async {
    var property = await apiService.getPropertyByID(propertyID);

    if (property.categoryID == categoryID) {
      return property;
    } else {
      return null;
    }
  }

  Future<bool> acceptProperty(PersonnelPropertyEditRequest request) async {
    final response = await http.put(
        Uri.parse(
            '$url/Personnels/${request.userID}/Properties/${request.propertyID}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "propertyID": request.propertyID,
          "userID": request.userID,
          "isWaiting": request.isWaiting
        }));

    return response.statusCode == 200 ? true : false;
  }

  Future<bool> rejectProperty(int userID, int propertyID) async {
    final response = await http.delete(
      Uri.parse('$url/Personnels/$userID/Properties/$propertyID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response.statusCode == 200 ? true : false;
  }
}
