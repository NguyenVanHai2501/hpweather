import 'package:flutter/foundation.dart';

class CityInfor {
  var id;
  var name;
  var country;

  CityInfor({this.id,
    required this.name,
    required this.country
  });

  factory CityInfor.fromJson(Map<String, dynamic> json) {
    return CityInfor(
        id: json["id"],
        name: json["name"],
        country: json["country"]);
  }
}