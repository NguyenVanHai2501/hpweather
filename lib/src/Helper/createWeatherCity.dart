
import '../Model/weatherModel.dart';

class CreateWeatherCity {

  dynamic setListWeatherDay(Map<String, dynamic> data) {
    final list = data['forecast']['forecastday'] as List;
    List<Weather> weatherDay = List.empty(growable: true);
    for (var o in list) {
      var icon = o['day']['condition']['icon'];
      var tinhtrang = o['day']['condition']['text'];
      var nhietdo = o['day']['avgtemp_c'];
      var gio = o['day']['maxwind_kph'];
      var doam = o['day']['avghumidity'];
      var luongmua = o['day']['totalprecip_mm'];
      var khongkhi = "null";//getAirQuality(o['day']['air_quality']['pm2_5']);
      var thoigian = o['date'];
      var image = setImage(null, tinhtrang, nhietdo);
      weatherDay.add(Weather(icon: icon, tinhtrang: tinhtrang, nhietdo: nhietdo, gio: gio, doam: doam, luongmua: luongmua, khongkhi: khongkhi, thoigian: thoigian, image: image));
    }

    return weatherDay;
  }

  dynamic setListWeatherHour(Map<String, dynamic> data) {
    final list = data['forecast']['forecastday'] as List;
    final listHour = list[0]["hour"] as List;
    List<Weather> weatherHour = List.empty(growable: true);
    for (var o in listHour) {
      var icon = o['condition']['icon'];
      var tinhtrang = o['condition']['text'];
      var nhietdo = o['temp_c'];
      var gio = o['wind_kph'];
      var doam = o['humidity'];
      var luongmua = o['precip_mm'];
      var khongkhi = "null";//getAirQuality(o['day']['air_quality']['pm2_5']);
      var thoigian = o['time'].toString().substring(11);

      var image = setImage(null, tinhtrang, nhietdo);
      weatherHour.add(Weather(icon: icon, tinhtrang: tinhtrang, nhietdo: nhietdo, gio: gio, doam: doam, luongmua: luongmua, khongkhi: khongkhi, thoigian: thoigian, image: image));
    }

    return weatherHour;
  }

  dynamic setWeatherCurrent(Map<String, dynamic> data) {
    var icon = data['current']['condition']['icon'];
    var tinhtrang = data['current']['condition']['text'].toString();
    var nhietdo = data['current']['temp_c'];
    var gio = data['current']['wind_kph'];
    var doam = data['current']['humidity'];
    var luongmua = data['current']['precip_mm'];
    var khongkhi = getAirQuality(data['current']['air_quality']['pm2_5']);
    var thoigian = data['current']['last_updated'].toString();

    var image = setImage(thoigian, tinhtrang, nhietdo);

    dynamic weather = Weather(icon: icon, tinhtrang: tinhtrang, nhietdo: nhietdo, gio: gio, doam: doam, luongmua: luongmua, khongkhi: khongkhi, thoigian: thoigian, image: image);
    return weather;
  }

  String getAirQuality(var PM25) {
    if (PM25 == null) {
      return "No Forecast";
    }
    String result = "Hazardous";
    double air = PM25;
    if (air <= 12) {
      result = "Good";
    } else if (air < 35.5){
      result = "Moderate";
    } else if (air <= 55.5){
      result = "Unhealthy for Sensitive Groups";
    } else if (air < 35.5){
      result = "Unhealthy";
    }
    return result;
  }

  String setImage(var time, var tinhtrang, var nhietdo) {
    double hour = 0;
    if (time != null) {
      String hourStr = time.toString().substring(11,13);
      if (hourStr[0] == "0") {
        hourStr = hourStr[1];
      }
      hour = double.parse(hourStr);

      if (hour < 6 || hour >= 18) {
        if (tinhtrang.toString().toLowerCase().contains("sunny")) {
          return "sunset.png";
        }
        if (tinhtrang.toString().toLowerCase().contains("thunder")) {
          return "nightThunder.png";
        }
        if (tinhtrang.toString().toLowerCase().contains("storm")) {
          return "storm.jpg";
        }
        if (tinhtrang.toString().toLowerCase().contains("tornado")) {
          return "tornado.jpg";
        }
        if (tinhtrang.toString().toLowerCase().contains("snow")) {
          return "winterNight.png";
        }
        if (tinhtrang.toString().toLowerCase().contains("rain")) {
          return "rainNight.jpg";
        }
        if (tinhtrang.toString().toLowerCase().contains("windy")) {
          return "windyNight.png";
        }
        if (tinhtrang.toString().toLowerCase().contains("mist")) {
          return "mistNight.png";
        }
        if (tinhtrang.toString().toLowerCase().contains("overcast")) {
          return "clouds.jpg";
        }
        double doC = nhietdo;
        if (doC < 10) {
          return "winterNight.png";
        } else {
          return "night.jpg";
        }
      }
    }

    if (tinhtrang.toString().toLowerCase().contains("thunder")) {
      return "lightThunder.jpg";
    }
    if (tinhtrang.toString().toLowerCase().contains("storm")) {
      return "storm.jpg";
    }
    if (tinhtrang.toString().toLowerCase().contains("tornado")) {
      return "tornado.jpg";
    }
    if (tinhtrang.toString().toLowerCase().contains("snow")) {
      return "winter.png";
    }
    if (tinhtrang.toString().toLowerCase().contains("rain")) {
      return "rainLight.jpg";
    }
    if (tinhtrang.toString().toLowerCase().contains("windy")) {
      return "windyLight.jpg";
    }
    if (tinhtrang.toString().toLowerCase().contains("mist")) {
      return "mistLight.png";
    }
    if (tinhtrang.toString().toLowerCase().contains("overcast")) {
      return "cloudLight.jpg";
    }
    if (time != null) {
      double doC = nhietdo;
      if (doC < 10) {
        return "winter.png";
      } else if (hour > 15) {
        return "sunset.png";
      } else if (doC < 29) {
        return "morning.png";
      } else {
        return "sun.jpg";
      }
    }
    double doC = nhietdo;
    if (doC < 10) {
      return "winter.png";
    } else if (doC < 29) {
      return "morning.png";
    } else {
      return "sun.jpg";
    }

  }

}

