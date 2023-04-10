import 'package:tiengviet/tiengviet.dart';
import 'package:weather/src/Contract/cityInforViewContract.dart';
import 'package:weather/src/Presenter/Presenter.dart';
import 'package:weather/src/Services/cityInforService.dart';

class CityInforPresenter extends Presenter<CityInforViewContract> {
  CityInforService cityInforService = CityInforService();

  void loadAllCity() {
    cityInforService.getAllCity().then((cityInfors) {
      getView().onLoadAllCityComplete(cityInfors);
    });
  }

  void loadCityByName(String cityName) {
    cityInforService.getCityByName(TiengViet.parse(cityName)).then((cityInfors) {
      getView().onLoadCityByNameComplete(cityInfors);
    });
  }

}