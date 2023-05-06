
import 'dart:async';
import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:home_widget/home_widget.dart';
import 'package:weather/src/screens/homescreen.dart';

int x =0;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

// Lấy thông tin của thiết bị đang chạy
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Device id: ${androidInfo.id}');
    print('Android version: ${androidInfo.version.release}');
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Device name: ${iosInfo.name}');
    print('iOS version: ${iosInfo.systemVersion}');
  }
  runApp(const MyApp());
}

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri? uri) async {

  String cityName = "HN";
  String icon = "CBCBCB";
  int temp = 0;
  Timer.periodic(Duration(seconds: 2), (timer) {
    temp++;
  });

  print(temp.toString());
  await HomeWidget.saveWidgetData<String>('_cityName', cityName);
  await HomeWidget.saveWidgetData<String>('_icon', icon);
  await HomeWidget.saveWidgetData<String>('_temp', temp.toString());

  await HomeWidget.updateWidget(
      name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
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
          defaultNextScreen: const MyHomePage(),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 4000),

        )
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
