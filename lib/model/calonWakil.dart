import 'dart:convert';

import 'package:http/http.dart' as http;

class CalonWakil {
  String? id;
  String? nama;
  String? platform;

  CalonWakil({this.id, this.nama, this.platform});

  factory CalonWakil.fromJson(Map<String, dynamic> json) {
    return CalonWakil(
      id: json['id'],
      nama: json['firstname'] + ' ' + json['lastname'],
      platform: json['platform'],
    );
  }

  static Future<List<CalonWakil>> getWakil() async {
    String apiUrl =
        'https://backend-evoting2021.000webhostapp.com/getwakil.php';

    var result = await http.get(Uri.parse(apiUrl));
    var json = jsonDecode(result.body);
    List<dynamic> list = (json as Map<String, dynamic>)['data'];

    List<CalonWakil> listWakil = [];
    for (int i = 0; i < list.length; i++)
      listWakil.add(CalonWakil.fromJson(list[i]));

    return listWakil;
  }

  static postWakil({required String id, required String idCalon}) async {
    String apiUrl =
        'https://backend-evoting2021.000webhostapp.com/postwakil.php';

    await http.post(Uri.parse(apiUrl), body: {
      'id_voter': id,
      'id_calon': idCalon,
    });
  }
}
