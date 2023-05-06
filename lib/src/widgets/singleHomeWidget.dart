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
import 'package:weather/src/screens/homescreen.dart';
import 'package:weather/src/widgets/detailpage.dart';
import 'package:weather/src/widgets/weatherItem.dart';

class SingleHomeWidget extends StatefulWidget {
  final int index;
  const SingleHomeWidget({Key? key, required this.index}) : super(key: key);
  @override
  State<SingleHomeWidget> createState() => _SingleHomeWidgetState();
}

class _SingleHomeWidgetState extends State<SingleHomeWidget> {
  dynamic city;

  @override
  void initState() {

    city = listCityWeatherData[widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.cyan,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'lib/Input/${city?.weatherCurrent.image}',
                    )),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: OverflowBox(
                    maxWidth: screenWidth,
                    maxHeight:
                        screenHeight * 1.105 > 970 ? 970 : screenHeight * 1.105,
                    child: Container(
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 16.8, vertical: 50),
                      padding: EdgeInsets.only(
                          top: screenHeight * 3 / 5,
                          right: 20,
                          left: 20,
                          bottom: 0),
                      width: double.infinity,
                      height: double.infinity,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: screenHeight * 2.7 / 16 < 140
                                  ? 140
                                  : screenHeight * 2.7 / 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      '${city?.weatherCurrent.nhietdo}' + "℃",
                                      // bỏ data nhiệt độ vào đây
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'flutterfonts',
                                          fontSize: 40),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${city?.cityName}',
                                      // bỏ data thành phố vào đây
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'flutterfonts'),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      formattedDate,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontFamily: 'flutterfonts'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  WeatherItem(
                                      value: '${city?.weatherCurrent.gio}',
                                      unit: "Kmh",
                                      imageUrl: "lib/Input/windspeed.png"),
                                  WeatherItem(
                                      value: '${city?.weatherCurrent.doam}',
                                      unit: "%",
                                      imageUrl: "lib/Input/humidity.png"),
                                  WeatherItem(
                                      value: '${city?.weatherCurrent.luongmua}',
                                      unit: "mm",
                                      imageUrl: "lib/Input/rain.png"),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 40, left: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  WeatherItem(
                                      value: city?.weatherCurrent.khongkhi,
                                      unit: "",
                                      imageUrl: "lib/Input/air.png"),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Image.network(
                                          'https:${city?.weatherCurrent.icon}',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 180,
                                        ),
                                        child: Text(
                                          city?.weatherCurrent
                                              .tinhtrang, //data gió
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                  fontFamily: 'flutterfont',
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'today'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          fontSize: 16,
                                          fontFamily: 'flutterfonts',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailPage(
                                                cityData: city,
                                              ))); //this will open forecast screen;
                                },
                                child: Container(
                                  child: Text(
                                    'Forecasts'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                            fontSize: 16,
                                            fontFamily: 'flutterfonts',
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 3.0,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 140,
                          padding: EdgeInsets.only(top: 15),
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  width: 100,
                                  height: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            city?.weatherHour[index]
                                                .thoigian, // bỏ dữ liệu giờ
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontFamily: 'flutterfont'),
                                          ),
                                          Image.network(
                                            'https:${city?.weatherHour[index].icon}',
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.fill,
                                          ),
                                          Text(
                                            '${city?.weatherHour[index].nhietdo}℃',
                                            // bỏ dữ liệu mô tả vào đây, giống kiểu trời mưa, hay nắng hay mây
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontFamily: 'flutterfont'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, index) =>
                                  VerticalDivider(
                                    color: Colors.transparent,
                                    width: 5,
                                  ),
                              itemCount: city?.weatherHour
                                  .length // bỏ data số lượng kiểu length của mảng dữ liệu thời tiết nhiệt độ
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
    );
  }

}
