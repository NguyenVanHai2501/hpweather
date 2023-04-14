import 'dart:io';

import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:home_widget/home_widget.dart';
import 'package:weather/src/ui/detailpage.dart';
import 'package:weather/src/ui/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri? uri) async {
  // if (uri?.host == 'updatecounter') {
  //   int counter = 0;
  //   await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
  //       .then((value) {
  //     counter = value!;
  //     counter++;
  //   });
  //   await HomeWidget.saveWidgetData<int>('_counter', counter);
  //   await HomeWidget.updateWidget(
  //     //this must the class name used in .Kt
  //       name: 'HomeScreenWidgetProvider',
  //       iOSName: 'HomeScreenWidgetProvider');
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FlutterSplashScreen.gif(
          gifPath: 'lib/Input/weather-icon-gif-23.gif',
          gifWidth: 300,
          gifHeight: 300,
          defaultNextScreen: const DetailPage(),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 4000),

        )
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
