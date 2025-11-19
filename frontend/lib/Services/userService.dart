import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventory_demo/Services/secureStorageService.dart';
import '../Models/User.dart';

class UserService {
  var url = 'http://10.0.2.2:7058/api';

  Future<dynamic> userLogin(String username, String password) async {
    final response = await http.post(Uri.parse('$url/Users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"username": username, "password": password}));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["token"] != null) {
        await SecureStorage().writeSecureStorageData("key_uName", username);
        await SecureStorage().writeSecureStorageData("key_pw", password);

        var userInfo = getUserInformation(data["token"].toString());
        if (userInfo is String) {
          return userInfo;
        } else {
          var user = createUser(userInfo);

          return user;
        }
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

  User createUser(userData) {
    int id = int.parse(userData[0]);
    int roleID = int.parse(userData[1]);
    User user = User(id: id, roleID: roleID);
    return user;
  }

  Future<User?> getUser() async {
    String? username = await SecureStorage().readSecureStorageData("key_uName");
    String? password = await SecureStorage().readSecureStorageData("key_pw");

    if (username != null && password != null) {
      User user = await UserService().userLogin(username, password);

      return user;
    }

    return null;
  }
}
