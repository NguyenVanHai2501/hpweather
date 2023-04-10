import 'package:weather/src/Contract/viewContract.dart';

import '../Model/historyInforModel.dart';

abstract class HistoryInforViewContract implements ViewContract {
  void onLoadAllHistoryComplete(List<HistoryInfor> allHistory) {}

  void onLoadHistoryByCountryComplete(List<HistoryInfor> allHistory) {}

  void onLoadHistoryByCityNameComplete(List<HistoryInfor> allHistory) {}

  void onLoadHistoryByDateomplete(List<HistoryInfor> allHistory) {}

  void onLoadAddHistory() {}

  void onLoadDeleteHistory() {}
}