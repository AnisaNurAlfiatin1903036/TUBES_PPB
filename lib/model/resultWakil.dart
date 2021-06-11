import 'dart:convert';

import 'package:http/http.dart' as http;

class ResultWakil {
  String total;
  String nama;

  ResultWakil({required this.total, required this.nama});

  factory ResultWakil.fromJson(Map<String, dynamic> json) {
    return ResultWakil(
        total: json['COUNT(*)'],
        nama: json['firstname'] + ' ' + json['lastname']);
  }

  static Future<List<ResultWakil>> getAllVoter() async {
    String apiUrl =
        'https://backend-evoting2021.000webhostapp.com/getvotewakil.php';
    var result = await http.get(Uri.parse(apiUrl));
    var json = jsonDecode(result.body);

    List<dynamic> list = (json as Map<String, dynamic>)['data'];

    List<ResultWakil> listAll = [];
    for (int i = 0; i < list.length; i++)
      listAll.add(ResultWakil.fromJson(list[i]));

    return listAll;
  }
}
