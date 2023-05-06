import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/src/Contract/cityWeatherViewContact.dart';
import 'package:weather/src/Contract/historyInforViewContract.dart';
import 'package:weather/src/Model/cityWeatherModel.dart';
import 'package:weather/src/Model/historyInforModel.dart';
import 'package:weather/src/Presenter/cityWeatherPresenter.dart';
import 'package:weather/src/Presenter/historyInforPresenter.dart';
import 'package:weather/src/widgets/singleHomeWidget.dart';

import '../widgets/slider_dot.dart';

List<CityWeather> listCityWeatherData = List.empty(growable: true);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements CityWeatherViewContract, HistoryInforViewContract {
  late bool _isLoading;
  dynamic historys;
  late CityWeatherPresenter _cityWeatherPresenter;
  late HistoryInforPresenter _historyInforPresenter;
  dynamic temp = "";
  dynamic cityName = "";
  dynamic icon = "";
  String message = "";

  final _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  _onPageChanged(int index) {
    _pageController.animateToPage(index, duration: Duration(milliseconds: 700), curve: Curves.ease );
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    _cityWeatherPresenter = CityWeatherPresenter();
    _cityWeatherPresenter.attachView(this);

    _historyInforPresenter = HistoryInforPresenter();
    _historyInforPresenter.attachView(this);
    _isLoading = true;
    _historyInforPresenter.loadAllHistory();
    _cityWeatherPresenter.loadCityWeatherFromLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.place, size: 128, color: Colors.redAccent),
                  CircularProgressIndicator()
                ],
              ))
            : Container(
                child: Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      itemCount: listCityWeatherData.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) =>
                          SingleHomeWidget(index: index)),
                    Container(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.1,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              // fetchWeatherData(value);
                            },
                            style: const TextStyle(color: Colors.white),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              _cityWeatherPresenter.loadCityWeather(value);
                            },
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintStyle: const TextStyle(color: Colors.white),
                              hintText: 'Search'.toUpperCase(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              // color: Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x0D000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < listCityWeatherData.length;
                                    i++)
                                  if (i == _currentPage)
                                    SliderDot(true)
                                  else
                                    SliderDot(false)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }

  void addWeatherToList(CityWeather cityWeather) {
    if (listCityWeatherData.isEmpty) {
      listCityWeatherData.add(cityWeather);
      return;
    }
    for (int i = 0; i < listCityWeatherData.length; i++) {
      if (cityWeather.cityName == listCityWeatherData[i].cityName) {
        listCityWeatherData.removeAt(i);
        listCityWeatherData.insert(0, cityWeather);
        return;
      }
    }

    listCityWeatherData.insert(0, cityWeather);
    if (listCityWeatherData.length == 6) {
      listCityWeatherData.removeAt(5);
    }
  }
  void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(); // đóng dialog sau 2 giây
        });
        return alert;
      },
    );
  }

  @override
  void onLoadCityWeatherComplete(CityWeather? cityWeather, bool isLoading) {
    if (cityWeather != null) {
      setState(() {
        message = "";
        if (listCityWeatherData.isNotEmpty) {
          _pageController.animateToPage(
              0, duration: const Duration(milliseconds: 700),
              curve: Curves.ease);

        }
          addWeatherToList(cityWeather);

          _historyInforPresenter.loadAddHistory(
              '${cityWeather?.cityName}', '${cityWeather?.countryName}');
          _isLoading = isLoading;
      });
    } else {
      if (listCityWeatherData.isNotEmpty) {
        setState(() {
          message = "not found";
          showAlertDialog(context);
        });
      } else {
        message = "Can't load location";
        _cityWeatherPresenter.loadCityWeather("Quang Ninh");
        showAlertDialog(context);
      }

    }
  }

  @override
  void onLoadAllHistoryComplete(List<HistoryInfor> allHistory) {
    setState(() {
      historys = allHistory;
      print(historys);
    });
  }

  @override
  void onLoadHistoryByCityNameComplete(List<HistoryInfor> allHistory) {
    // TODO: implement onLoadHistoryByCityNameComplete
  }

  @override
  void onLoadHistoryByCountryComplete(List<HistoryInfor> allHistory) {
    // TODO: implement onLoadHistoryByCountryComplete
  }

  @override
  void onLoadHistoryByDateomplete(List<HistoryInfor> allHistory) {
    // TODO: implement onLoadHistoryByDateomplete
  }

  @override
  void onLoadAddHistory() {
    _historyInforPresenter.loadAllHistory();
  }

  @override
  void onLoadDeleteHistory() {
    // TODO: implement onLoadDeleteHistory
  }
}
