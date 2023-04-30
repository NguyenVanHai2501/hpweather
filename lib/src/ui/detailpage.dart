import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/src/ui/weatherItem.dart';

class DetailPage extends StatefulWidget {
  final cityData;

  const DetailPage({Key? key, this.cityData}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dynamic city = widget.cityData;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Forecasts'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
        ),
        body: Column(
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
                      alignment: const Alignment(0.0, 0.6),
                      child: SizedBox(
                        height: 10,
                        // width: 10,
                        child: OverflowBox(
                          minWidth: 0.0,
                          maxWidth: MediaQuery.of(context).size.width,
                          minHeight: 0.0,
                          maxHeight: (MediaQuery.of(context).size.height / 1.5),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 16.8, vertical: 50),
                                padding: const EdgeInsets.only(
                                    top: 180, right: 20, left: 20, bottom: 20),
                                width: double.infinity,
                                height: double.infinity,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                               left: 20),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 150,
                                                width: 150,
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
                                              Text(
                                                city?.weatherCurrent
                                                    .tinhtrang, //data gió
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontFamily:
                                                            'flutterfont'),
                                              ),
                                            ],
                                          )),
                                      Positioned(
                                        bottom: 20,
                                        left: 20,
                                        child: Container(
                                          width: size.width * .8,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              WeatherItem(
                                                  value:
                                                      '${city?.weatherCurrent.gio}',
                                                  unit: "Kmh",
                                                  imageUrl:
                                                      "lib/Input/windspeed.png"),
                                              WeatherItem(
                                                  value:
                                                      '${city?.weatherCurrent.doam}',
                                                  unit: "%",
                                                  imageUrl:
                                                      "lib/Input/humidity.png"),
                                              WeatherItem(
                                                  value:
                                                      '${city.weatherCurrent.luongmua}',
                                                  unit: "mm",
                                                  imageUrl:
                                                      "lib/Input/rain.png"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        right: 20,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${city?.weatherCurrent.nhietdo.toInt()}',
                                              style: TextStyle(
                                                fontSize: 90,
                                                fontWeight: FontWeight.bold,
                                                foreground: Paint(),
                                              ),
                                            ),
                                            Text(
                                              'o',
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()),
                                            ),
                                          ],
                                        ),
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
              flex: 2,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 250),
                      child: Container(
                        // height: ,
                        padding: EdgeInsets.only(top: 15),
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, index) {
                              return Card(
                                elevation: 3.0,
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${city.weatherDay[index].thoigian}',
                                            style: const TextStyle(
                                              color: Color(0xff6696f5),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${city.weatherDay[index].nhietdo}' + "℃",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                'https:${city?.weatherDay[index].icon}',
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.fill,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${city.weatherDay[index].tinhtrang}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${city.weatherDay[index].doam}' + "%",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Image.asset(
                                                'lib/Input/humidity.png',
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, index) =>
                                const VerticalDivider(
                                  color: Colors.transparent,
                                  width: 5,
                                ),
                            itemCount:
                            city.weatherDay.length // bỏ data số lượng kiểu length của mảng dữ liệu thời tiết nhiệt độ
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
