import 'dart:convert';

import 'package:http/http.dart' as http;

class CalonKetua {
  String? id;
  String? nama;
  String? platform;

  CalonKetua({this.id, this.nama, this.platform});

  factory CalonKetua.fromJson(Map<String, dynamic> json) {
    return CalonKetua(
      id: json['id'],
      nama: json['firstname'] + ' ' + json['lastname'],
      platform: json['platform'],
    );
  }

  static Future<List<CalonKetua>> getKetua() async {
    String apiUrl =
        'https://backend-evoting2021.000webhostapp.com/getketua.php';

    var result = await http.get(Uri.parse(apiUrl));
    var json = jsonDecode(result.body);
    List<dynamic> list = (json as Map<String, dynamic>)['data'];

    List<CalonKetua> listKetua = [];
    for (int i = 0; i < list.length; i++)
      listKetua.add(CalonKetua.fromJson(list[i]));

    return listKetua;
  }

  static postKetua({required String id, required String idCalon}) async {
    String apiUrl =
        'https://backend-evoting2021.000webhostapp.com/postketua.php';

    await http.post(Uri.parse(apiUrl), body: {
      'id_voter': id,
      'id_calon': idCalon,
    });
  }

  static Future<CalonKetua> isVoting(String id) async {
    String apiUrl =
        "https://backend-evoting2021.000webhostapp.com/isvotingketua.php";

    var result = await http.post(Uri.parse(apiUrl), body: {
      'voter': id,
    });
    var json = jsonDecode(result.body);

    return CalonKetua.fromJson(json);
  }
}
