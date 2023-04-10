
import 'package:tiengviet/tiengviet.dart';
import 'package:weather/src/Presenter/Presenter.dart';
import 'package:weather/src/Services/cityWeatherService.dart';
import 'package:weather/src/Services/locationInforService.dart';

import '../Contract/cityWeatherViewContact.dart';

class CityWeatherPresenter extends Presenter<CityWeatherViewContract>{

  CityWeatherService cityWeatherService = CityWeatherService();
  LocationInfor locationInfor = LocationInfor();

  void loadCityWeather(String cityName) {
    cityName = TiengViet.parse(cityName);
    cityWeatherService.getCityData(cityName).then((cityWeather) {
      getView().onLoadCityWeatherComplete(cityWeather, false);
    }).catchError((e) {
      print(e);
    });
  }

  void loadCityWeatherFromLocation () {
    locationInfor.getCurrentLocation().then((cityAddress) {
      loadCityWeather(cityAddress);
    }).catchError((e) {
      print(e);
    });
  }

}