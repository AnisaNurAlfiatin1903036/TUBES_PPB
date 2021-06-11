import 'dart:convert';

import 'package:http/http.dart' as http;

class ResultSemua {
  String total;

  ResultSemua({required this.total});

  factory ResultSemua.fromJson(Map<String, dynamic> json) {
    return ResultSemua(total: json['COUNT(*)']);
  }

  static Future<List<ResultSemua>> getAllVoter() async {
    String apiUrl =
        'https://backend-evoting2021.000webhostapp.com/getallvoter.php';
    var result = await http.get(Uri.parse(apiUrl));
    var json = jsonDecode(result.body);

    List<dynamic> list = (json as Map<String, dynamic>)['data'];

    List<ResultSemua> listAll = [];
    for (int i = 0; i < list.length; i++)
      listAll.add(ResultSemua.fromJson(list[i]));

    return listAll;
  }

  static Future<List<ResultSemua>> getAllVotes() async {
    String apiUrl =
        'https://backend-evoting2021.000webhostapp.com/getallvotes.php';
    var result = await http.get(Uri.parse(apiUrl));
    var json = jsonDecode(result.body);

    List<dynamic> list = (json as Map<String, dynamic>)['data'];

    List<ResultSemua> listAll = [];
    for (int i = 0; i < list.length; i++)
      listAll.add(ResultSemua.fromJson(list[i]));

    return listAll;
  }
}
