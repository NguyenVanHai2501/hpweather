
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:weather/src/Contract/cityWeatherViewContact.dart';
import 'package:weather/src/Contract/historyInforViewContract.dart';
import 'package:weather/src/Model/cityWeatherModel.dart';
import 'package:weather/src/Model/historyInforModel.dart';
import 'package:weather/src/Presenter/cityWeatherPresenter.dart';
import 'package:weather/src/Presenter/historyInforPresenter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> implements CityWeatherViewContract, HistoryInforViewContract{
  late bool _isLoading;
  dynamic city;
  dynamic historys;
  late CityWeatherPresenter _cityWeatherPresenter;
  late HistoryInforPresenter _historyInforPresenter;
  dynamic temp = "";
  dynamic cityName = "";
  dynamic icon = "";

  late Timer _timer;
  int _counter = 0;

  void loadData() async {
    await HomeWidget.getWidgetData<String>('_cityName', defaultValue: "")
        .then((value) {
      cityName = value!;
    });
    await HomeWidget.getWidgetData<String>('_icon', defaultValue: "")
        .then((value) {
      icon = value!;
    });
    await HomeWidget.getWidgetData<String>('_temp', defaultValue: "")
        .then((value) {
      temp = value!;
    });

    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<String>('_cityName', cityName);
    await HomeWidget.saveWidgetData<String>('_icon', icon);
    await HomeWidget.saveWidgetData<String>('_temp', temp);

    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      if (cityName == "HaNoi") {
        cityName = "Ho Chi Minh City";
        icon = "HCM_icon";
        temp = "18";
      } else {
        cityName = "HaNoi";
        icon = "HaNoi_icon";
        temp = "20";
      }
    });
    updateAppWidget();
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
    // In ra dòng chữ "Hello" mỗi 5 giây
    // _timer = Timer.periodic(Duration(seconds: 2), (timer) {
    //   setState(() {
    //     _counter++;
    //   });
    //   print("Hello $_counter");
    // });

    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData(); // This will load data from widget every time app is opened
  }

  @override
  void dispose() {
    // Huỷ timer khi Widget bị huỷ
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
        _isLoading
            ? const Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon (
                    Icons.place,
                    size: 128,
                    color: Colors.redAccent
                ),
                CircularProgressIndicator()
              ],
            )
        )
          :Column(
            children: <Widget>[
              Expanded(flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('lib/Input/${city?.weatherCurrent.image}',)
                      ),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(onPressed: () {},
                              icon: const Icon(Icons.menu,
                                color: Colors.white,)
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 80,
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            // fetchWeatherData(value);
                          },
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            _cityWeatherPresenter.loadCityWeather(value);
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search, color: Colors.white,),
                            hintStyle: const TextStyle(
                                color: Colors.white
                            ),
                            hintText: 'Search'.toUpperCase(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.0, 1.27),
                        child: SizedBox(
                          height: 10,
                          width: 10,
                          child: OverflowBox(
                            minWidth: 0.0,
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: 0.0,
                            maxHeight: (MediaQuery.of(context).size.height / 2.85),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.8),
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Text('${city?.weatherCurrent.nhietdo}' + "℃", // bỏ data nhiệt độ vào đây
                                                  style: const TextStyle(color: Colors.black54,
                                                      fontFamily: 'flutterfonts',
                                                      fontSize: 30),
                                                ),
                                              ),
                                              // Center(
                                              //   child: Text('${city?.weatherCurrent.tinhtrang}', //bỏ data như kiểu trời u ám, trời nắng các th
                                              //     style: const TextStyle(
                                              //         color: Colors.black54,
                                              //         fontSize: 14,
                                              //         fontFamily: 'flutterfonts'
                                              //     ),
                                              //   ),
                                              // ),
                                              Center(
                                                child: Text('${city?.cityName}',// bỏ data thành phố vào đây
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'flutterfonts'
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(formattedDate,
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontFamily: 'flutterfonts'
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 50),
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(Icons.wind_power),
                                                  Text('${city?.weatherCurrent.gio}', //data gió
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .caption
                                                      ?.copyWith(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontFamily: 'flutterfont'
                                                  ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 80),
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(Icons.water_drop),
                                                  Text('${city?.weatherCurrent.doam}', // data ẩm
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontFamily: 'flutterfont'
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 87),
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(Icons.cloud),
                                                  Text('data',
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontFamily: 'flutterfont'
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(right: 40, top: 20),
                                              child: Column(
                                                children: <Widget>[
                                                  Text('${city?.weatherCurrent.khongkhi}', //data kk
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontFamily: 'flutterfont'
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 40, top: 20),
                                              child: Column(
                                                children: <Widget>[
                                                  Text('${city?.weatherCurrent.tinhtrang}', //data gió
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontFamily: 'flutterfont'
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: <Widget>[
                                        //     Container(
                                        //       padding: const EdgeInsets.only(left: 50, top: 0),
                                        //       child: Column(
                                        //         children: <Widget>[
                                        //           // Text('${city?.weatherCurrent.tinhtrang}', //bỏ data như kiểu trời u ám, trời nắng các th
                                        //           //   style: const TextStyle(
                                        //           //       color: Colors.black54,
                                        //           //       fontSize: 14,
                                        //           //       fontFamily: 'flutterfonts'
                                        //           //   ),
                                        //           // ),
                                        //           //const SizedBox(height: 3,),
                                        //           // Text('${city?.weatherCurrent.nhietdo}' + "℃", // bỏ data nhiệt độ vào đây
                                        //           //   style: const TextStyle(color: Colors.black54,
                                        //           //       fontFamily: 'flutterfonts',
                                        //           //       fontSize: 30),
                                        //           // ),
                                        //           Text('Air Quality: ', // bỏ data chất lg ko khí vào đây
                                        //             style: const TextStyle(color: Colors.black54,
                                        //                 fontFamily: 'flutterfonts',
                                        //                 fontSize: 14),
                                        //           )
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       padding: const EdgeInsets.only(right: 20),
                                        //       child: Column(
                                        //         mainAxisAlignment: MainAxisAlignment.center,
                                        //         children: <Widget>[
                                        //           Image.network(
                                        //             'https:${city?.weatherCurrent.icon}',
                                        //             width: 100,
                                        //           height: 100,
                                        //           fit: BoxFit.fill,
                                        //           ),
                                        //           // Container(
                                        //           //   width: 120,
                                        //           //   height: 120,
                                        //           //   decoration: BoxDecoration(
                                        //           //     image: DecorationImage(fit: BoxFit.cover,
                                        //           //       image: Image.network('http:${data?.weather[0].icon}'),
                                        //           //     ),
                                        //           //   ),
                                        //           // ),
                                        //           Container(
                                        //             child: Text('Wind Power: '+'${city?.weatherCurrent.gio}' + "Kph", // bỏ data gio vào đây
                                        //               style: const TextStyle(
                                        //                   color: Colors.black54,
                                        //                   fontFamily: 'flutterfonts',
                                        //                   fontSize: 12,
                                        //                   fontWeight: FontWeight.bold
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 200),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text('today'.toUpperCase(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                    fontSize: 16,
                                    fontFamily: 'flutterfonts',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              height: 140,
                              padding: EdgeInsets.only(top: 15),
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, index) {
                                    index =
                                    10; // cái để bỏ vào mảng data như kiểu data[index]
                                    return Container(
                                      width: 140,
                                      height: 150,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15),
                                        ),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Text("data", // bỏ dữ liệu giờ
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                    fontFamily: 'flutterfont'
                                                ),
                                              ),
                                              Text(
                                                'nhiệt độ', // bỏ data nhiệt độ
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                    fontFamily: 'flutterfont'
                                                ),
                                              ),
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'lib/Input/night.jpg'),
                                                    // chỗ này chỉnh ảnh sao cho giống với dữ liệu mô tả
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Text('data',
                                                // bỏ dữ liệu mô tả vào đây, giống kiểu trời mưa, hay nắng hay mây
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                    fontFamily: 'flutterfont'
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context,
                                      index) =>
                                      VerticalDivider(
                                        color: Colors.transparent,
                                        width: 5,
                                      ),
                                  itemCount: 10 // bỏ data số lượng kiểu length của mảng dữ liệu thời tiết nhiệt độ
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Text('Forcast next 7 days'.toUpperCase(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontFamily: 'flutterfont'
                                    ),
                                  ),
                                  Icon(Icons.next_plan_outlined,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              //scrollDirection: Axis.horizontal,
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 120,
                                // margin: EdgeInsets.all(10),
                                // padding: EdgeInsets.all(15),
                                // decoration: BoxDecoration(
                                //   color: Colors.black12,
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, index) {
                                      index =
                                      10; // cái để bỏ vào mảng data như kiểu data[index]
                                      return Container(
                                        width: 140,
                                        height: 150,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15),
                                          ),
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                                Text("data", // bỏ dữ liệu giờ
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .caption
                                                      ?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontFamily: 'flutterfont'
                                                  ),
                                                ),
                                                Text(
                                                  'nhiệt độ', // bỏ data nhiệt độ
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .caption
                                                      ?.copyWith(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontFamily: 'flutterfont'
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'lib/Input/morning.png'),
                                                      // chỗ này chỉnh ảnh sao cho giống với dữ liệu mô tả
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Text('data',
                                                  // bỏ dữ liệu mô tả vào đây, giống kiểu trời mưa, hay nắng hay mây
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .caption
                                                      ?.copyWith(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontFamily: 'flutterfont'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context,
                                        index) =>
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: 5,
                                        ),
                                    itemCount: 10 // bỏ data số lượng kiểu length của mảng dữ liệu thời tiết nhiệt độ
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ],
      )
    );
  }

  @override
  void onLoadCityWeatherComplete(CityWeather cityWeather, bool isLoading) {
    setState(() {
      city = cityWeather;
      _isLoading = isLoading;
      _historyInforPresenter.loadAddHistory('${city?.cityName}', '${city?.countryName}');
    });
  }

  @override
  void onLoadAllHistoryComplete(List<HistoryInfor> allHistory) {
    setState(() {
      historys = allHistory;
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
    // print(historys);
  }

  @override
  void onLoadDeleteHistory() {
    // TODO: implement onLoadDeleteHistory
  }
}