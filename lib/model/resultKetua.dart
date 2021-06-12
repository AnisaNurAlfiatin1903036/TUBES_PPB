import 'dart:convert';

import 'package:http/http.dart' as http;

class ResultKetua {
  String total;
  String nama;

  ResultKetua({required this.total, required this.nama});

  factory ResultKetua.fromJson(Map<String, dynamic> json) {
    return ResultKetua(
        total: json['COUNT(*)'],
        nama: json['firstname'] + ' ' + json['lastname']);
  }

  static Future<List<ResultKetua>> getAllVoter() async {
    String apiUrl = 'https://api-evoting.000webhostapp.com/getvoteketua.php';
    var result = await http.get(Uri.parse(apiUrl));
    var json = jsonDecode(result.body);

    List<dynamic> list = (json as Map<String, dynamic>)['data'];

    List<ResultKetua> listAll = [];
    for (int i = 0; i < list.length; i++)
      listAll.add(ResultKetua.fromJson(list[i]));

    return listAll;
  }
}
