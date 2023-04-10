
import 'package:weather/src/Model/weatherModel.dart';

class CityWeather {
  var cityName;
  var countryName;
  List<Weather> weatherDay;
  List<Weather> weatherHour;
  Weather weatherCurrent;

  CityWeather(
  { required this.cityName,
    required this.countryName,
    required this.weatherDay,
    required this.weatherHour,
    required this.weatherCurrent
  });

}
