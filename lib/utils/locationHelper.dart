// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LocationHelper {
//   static Future<Position> getPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       openAppSettings();
//       // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
//
//   static Future<Position?> lastKnownPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       openAppSettings();
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getLastKnownPosition();
//   }
// }
