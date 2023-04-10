import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationInfor {
  getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }
    } catch(e) {
      print(e);
    }
    String currentAddress = "Quảng Ninh";
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      //Pass the lat and long to the function
      await getAddressFromLatLng(position.latitude, position.longitude).then((value) {
        currentAddress = value;
      });
    }).catchError((e) {
      print(e);
    });

    return currentAddress;
  }

  getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      var currentAddress = "${place.administrativeArea}";

      return currentAddress;

    } catch (e) {
      print(e);
    }
  }
}