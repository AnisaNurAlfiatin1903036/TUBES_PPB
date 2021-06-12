import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginUser {
  String? id;
  String? nama;
  String? error;

  LoginUser({this.id, this.nama, this.error});

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
        id: json['id'].toString(),
        nama: json['firstname'],
        error: json['error']);
  }

  static Future<LoginUser> login(String voter, String password) async {
    String apiUrl = "https://api-evoting.000webhostapp.com/login.php";

    var result = await http.post(Uri.parse(apiUrl), body: {
      'voter': voter,
      'password': password,
    });
    var json = jsonDecode(result.body);

    return LoginUser.fromJson(json);
  }

  static Future<LoginUser> isVoting(String id) async {
    String apiUrl = "https://api-evoting.000webhostapp.com/isvoting.php";

    var result = await http.post(Uri.parse(apiUrl), body: {
      'voter': id,
    });
    var json = jsonDecode(result.body);

    return LoginUser.fromJson(json);
  }
}
