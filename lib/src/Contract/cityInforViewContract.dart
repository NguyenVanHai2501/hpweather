import 'package:weather/src/Contract/viewContract.dart';
import 'package:weather/src/Model/cityInforModel.dart';

abstract class CityInforViewContract implements ViewContract {
  void onLoadAllCityComplete(List<CityInfor> cityInfors) {}
  void onLoadCityByNameComplete(List<CityInfor> cityInfors) {}
}