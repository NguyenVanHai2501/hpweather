
import 'package:flutter/material.dart';
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
                          top: 70,
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
                            // suffix: Icon(
                            //   Icons.search,
                            // color: Colors.white,
                            // ),
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
                                          padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(left: 50),
                                              child: Column(
                                                children: <Widget>[
                                                  Text('${city?.weatherCurrent.tinhtrang}', //bỏ data như kiểu trời u ám, trời nắng các th
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 14,
                                                        fontFamily: 'flutterfonts'
                                                    ),
                                                  ),
                                                  const SizedBox(height: 3,),
                                                  Text('${city?.weatherCurrent.nhietdo}' + "℃", // bỏ data nhiệt độ vào đây
                                                    style: const TextStyle(color: Colors.black54,
                                                        fontFamily: 'flutterfonts',
                                                        fontSize: 30),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(right: 20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.network(
                                                    'https:${city?.weatherCurrent.icon}',
                                                    width: 120,
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                  ),
                                                  // Container(
                                                  //   width: 120,
                                                  //   height: 120,
                                                  //   decoration: BoxDecoration(
                                                  //     image: DecorationImage(fit: BoxFit.cover,
                                                  //       image: Image.network('http:${data?.weather[0].icon}'),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Container(
                                                    child: Text('${city?.weatherCurrent.gio}' + "Kph", // bỏ data gio vào đây
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'flutterfonts',
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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
                flex: 2
                ,child: Container(

              ),
              )
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
    print(historys);
  }

  @override
  void onLoadDeleteHistory() {
    // TODO: implement onLoadDeleteHistory
  }
}