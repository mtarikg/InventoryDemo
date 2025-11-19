import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventory_demo/Models/Property/PropertyAddRequest.dart';
import 'package:inventory_demo/Models/Property/PropertyEditRequest.dart';
import '../Models/PersonnelProperty/PersonnelPropertyAddRequest.dart';

class AdminService {
  var url = 'http://10.0.2.2:7058/api';

  Future<bool> addProperty(PropertyAddRequest request) async {
    final response = await http.post(Uri.parse('$url/Properties'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name": request.name,
          "imageURL": request.imageURL,
          "quantity": request.quantity,
          "shortDescription": request.shortDescription,
          "fullDetail": request.fullDetail,
          "createdDate": DateTime.now().toIso8601String(),
          "categoryID": request.categoryID
        }));

    return response.statusCode == 201 ? true : false;
  }

  Future<bool> deleteProperty(int id) async {
    final response = await http.delete(
      Uri.parse('$url/Properties/?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response.statusCode == 200 ? true : false;
  }

  Future<bool> editProperty(int id, PropertyEditRequest request) async {
    final response = await http.put(Uri.parse('$url/Properties/?id=$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "id": id,
          "imageURL": request.imageURL,
          "quantity": request.quantity,
          "shortDescription": request.shortDescription,
          "fullDetail": request.fullDetail
        }));

    return response.statusCode == 200 ? true : false;
  }

  Future<bool> addPropertyToPersonnel(
      int userID, PersonnelPropertyAddRequest request) async {
    final response =
        await http.post(Uri.parse('$url/Personnels/$userID/Properties'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              "propertyID": request.propertyID,
              "userID": request.personnelID,
              "dueOn": request.dueOn.toIso8601String(),
              "isWaiting": true
            }));

    return response.statusCode == 200 ? true : false;
  }
}
