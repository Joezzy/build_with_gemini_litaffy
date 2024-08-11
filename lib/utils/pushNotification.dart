// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// // import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class PushNotificationService {
//   FirebaseMessaging fcm = FirebaseMessaging.instance;
//
//   Future initialize(context) async {
//     print("NOTIFICATION_INIT");
//     NotificationWidget.init();
//
//     NotificationSettings settings = await fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         print("getInitialMessage");
//         print("Message:${message.notification}");
//         print("Data:${message.data}");
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
//       RemoteNotification? notification = message.notification;
//       await NotificationWidget.showNotification(
//           title: notification!.title, body: notification.body);
//       if (notification != null) {
//         print("onMessage.listen");
//         print("Message:${message.notification}");
//         print("Data:${message.data}");
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null) {
//         print("onMessageOpenedApp.listen");
//         print("Message:${message.notification}");
//         print("Data:${message.data}");
//       }
//     });
//   }
//
//   String getRideId(Map<String, dynamic> message) {
//     String rideID = '';
//     if (Platform.isAndroid) {
//       rideID = message['data']['req_id'];
//     } else {
//       rideID = message['req_id'];
//     }
//     return rideID;
//   }
//
//   String getSenderToken(Map<String, dynamic> message) {
//     String senderToken = '';
//     if (Platform.isAndroid) {
//       senderToken = message['data']['user_gcm_token'];
//     } else {
//       senderToken = message['user_gcm_token'];
//     }
//     return senderToken;
//   }
//
//    Future<String> getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     SharedPreferences localPref = await SharedPreferences.getInstance();
//     localPref.setString("fcmToken", token.toString());
//     // print(token.toString());
//     fcm.subscribeToTopic('allusers');
//     return token.toString();
//   }
//
//   // Dio dio = Dio();
//
//   static Future sendAndRetrieveMessage(
//       String id,
//       String userToken,
//       String title,
//       String body,
//       ) async {
//     print("NOTIFICATION START");
//     final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//
//     SharedPreferences localPref = await SharedPreferences.getInstance();
//     String firstname = localPref.getString("user_firstname").toString();
//     // userToken = userToken;
//     // userToken = "cv7XWNOlSai_YfWTyI6P--:APA91bFeICwt7-pOn4g9aZQ4rRcrpypinZRVV38Ezn4MST_lKv1s6FNojpuFxXk3afobQqv5euReot1fjXG7I8PJPwuURgilkCs3Iawfh2cbAs4yoD9ueC45ZJXLRSHVKdAo3uxJI6Yv";
//     // print(userToken);
//
//    final res= await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=${dotenv.env["FCM_SERVER_KEY"].toString()}',
//       },
//
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': '$body',
//             'title': '$title',
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'id': '$id',
//             'status': 'new',
//             'req_id': '$id'
//           },
//           'to': '$userToken',
//         },
//       ),
//     );
//
//    print("RES");
//    print(res.body);
//
//     final Completer<Map<String, dynamic>> completer =
//     Completer<Map<String, dynamic>>();
//   }
//
// }
