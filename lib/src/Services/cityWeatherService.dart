import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/cityWeatherModel.dart';
import '../Helper/createWeatherCity.dart';

class CityWeatherService {
  var createWeather = CreateWeatherCity();
  dynamic fetchData(var city) async {
    var uricall = Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=1c72166aeb6549f8bac112855231303&q=$city&days=7&aqi=yes&alerts=yes");
    var response = await http.get(uricall);
    var body = jsonDecode(response.body)?? 'No data';
    final data = Map<String, dynamic>.from(body);
    return data;
  }

  Future<CityWeather> getCityData(var city_name) async {
    var uricall = Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=1c72166aeb6549f8bac112855231303&q=$city_name&days=7&aqi=yes&alerts=yes");
    var response = await http.get(uricall);
    var body = jsonDecode(response.body)?? 'No data';
    final weatherData = Map<String, dynamic>.from(body);
    return CityWeather(cityName: weatherData["location"]["name"],
        countryName: weatherData["location"]["country"],
        weatherDay: createWeather.setListWeatherDay(weatherData),
        weatherHour: createWeather.setListWeatherHour(weatherData),
        weatherCurrent: createWeather.setWeatherCurrent(weatherData));;
  }

}