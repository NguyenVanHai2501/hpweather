class HistoryInfor {
  var id;
  var city;
  var country;
  var last_update;
  HistoryInfor({
    this.id,
    required this.city,
    required this.country,
    required this.last_update
  });

  factory HistoryInfor.fromJson(Map<String, dynamic> json) {
    return HistoryInfor(
        id: json["id"],
        city: json["city"],
        country: json["country"],
        last_update: json['last_update']
    );

  }

  @override
  String toString() {
    return 'HistoryInfor{id: $id, city: $city, country: $country, last_update: $last_update}';
  }
}