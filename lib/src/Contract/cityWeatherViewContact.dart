import 'dart:ffi';

import 'package:weather/src/Contract/viewContract.dart';
import 'package:weather/src/Model/cityWeatherModel.dart';

abstract class CityWeatherViewContract extends ViewContract{
  void onLoadCityWeatherComplete(CityWeather cityWeather, bool isLoading);
}