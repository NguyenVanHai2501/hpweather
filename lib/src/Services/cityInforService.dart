import 'dart:convert';

import 'package:weather/src/Model/cityInforModel.dart';
import 'package:http/http.dart' as http;

class CityInforService{
  final ROOT = "https://crazyhost123.000webhostapp.com/city.php";
  final _GET_ALL_ACTION = 'GET_ALL';
  final _GET_BY_NAME_ACTION = 'GET_BY_NAME';

  Future<List<CityInfor>> getAllCity() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_ACTION;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      // print("get all city: ${response.body}");

      if (200 == response.statusCode) {
        List<CityInfor> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }


  }

  List<CityInfor> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CityInfor>((json) => CityInfor.fromJson(json)).toList();
  }

  Future<List<CityInfor>> getCityByName(String cityName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_BY_NAME_ACTION;
      map['cityName'] = cityName;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      // print("get city by cityName: ${response.body}");

      if (200 == response.statusCode) {
        List<CityInfor> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }


  }
}