import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/src/Model/historyInforModel.dart';

class HistoryInforService{
  final ROOT = "https://crazyhost123.000webhostapp.com/history.php";
  final _GET_ALL_ACTION = 'GET_ALL';
  final _GET_BY_CITY_ACTION = 'GET_BY_CITY';
  final _GET_BY_COUNTRY_ACTION = 'GET_BY_COUNTRY';
  final _GET_BY_DATE_ACTION = 'GET_BY_DATE';
  final _ADD_ACTION = 'ADD';
  final _DELETE_ACTION = 'DELETE';


  Future<List<HistoryInfor>> getAllHistory() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_ACTION;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      // print("get all history: ${response.body}");

      if (200 == response.statusCode) {
        List<HistoryInfor> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }

  }

  List<HistoryInfor> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HistoryInfor>((json) => HistoryInfor.fromJson(json)).toList();
  }

  Future<List<HistoryInfor>> getHistoryByCity(String cityName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_BY_CITY_ACTION;
      map['cityName'] = cityName;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      print("get history by city: ${response.body}");

      if (200 == response.statusCode) {
        List<HistoryInfor> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }

  }

  Future<List<HistoryInfor>> getHistoryByCountry(String countryName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_BY_COUNTRY_ACTION;
      map['countryName'] = countryName;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      // print("get history by country: ${response.body}");

      if (200 == response.statusCode) {
        List<HistoryInfor> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }

  }

  Future<List<HistoryInfor>> getHistoryByDate(String startDate, String endDate) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_BY_DATE_ACTION;
      map['startDate'] = startDate;
      map['endDate'] = endDate;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      print("get history by date: ${response.body}");
      if (200 == response.statusCode) {
        List<HistoryInfor> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }

  }

  Future<String> addHistory(String cityName, String countryName) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_ACTION;
      map['cityName'] = cityName;
      map['countryName'] = countryName;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      print("add a history: ${response.body}");
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error: $e";
    }

  }

  Future<String> deleteHistoryByID(String id) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_ACTION;
      map['id'] = id;
      var uri = Uri.parse(ROOT);
      final response = await http.post(uri, body: map);
      print("delete a history: ${response.body}");
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error: $e";
    }

  }
}