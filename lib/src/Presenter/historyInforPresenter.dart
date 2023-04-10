import 'package:tiengviet/tiengviet.dart';
import 'package:weather/src/Contract/historyInforViewContract.dart';
import 'package:weather/src/Presenter/Presenter.dart';
import 'package:weather/src/Services/historyInforService.dart';

class HistoryInforPresenter extends Presenter<HistoryInforViewContract> {
  HistoryInforService historyInforService = HistoryInforService();

  void loadAllHistory() {
    historyInforService.getAllHistory().then((allHistory) {
      print(allHistory.toString());
      getView().onLoadAllHistoryComplete(allHistory);
    });
  }

  void loadHistoryBy() {
    historyInforService.getAllHistory().then((allHistory) {
      getView().onLoadAllHistoryComplete(allHistory);
    });
  }

  void loadAllHistoryByCity(String cityName) {
    historyInforService.getHistoryByCity(TiengViet.parse(cityName)).then((allHistory) {
      getView().onLoadHistoryByCityNameComplete(allHistory);
    });
  }

  void loadHistoryByCountry(String countryName) {
    historyInforService.getHistoryByCountry(TiengViet.parse(countryName)).then((allHistory) {
      getView().onLoadHistoryByCountryComplete(allHistory);
    });
  }

  void loadHistoryByDdate(String startDate, {String endDate = "2024-01-01"}) {
    historyInforService.getHistoryByDate(startDate, endDate).then((allHistory) {
      getView().onLoadHistoryByDateomplete(allHistory);
    });
  }

  void loadAddHistory(String cityName, String countryName) {
    historyInforService.addHistory(TiengViet.parse(cityName), TiengViet.parse(countryName)).then((value) {
      getView().onLoadAddHistory();
    });
  }

  void loadDeleteHistoryByID(String id) {
    historyInforService.deleteHistoryByID(id).then((value) {
      getView().onLoadDeleteHistory();
    });
  }
}