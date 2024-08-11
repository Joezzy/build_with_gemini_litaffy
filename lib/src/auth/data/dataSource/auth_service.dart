import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:littafy/src/auth/domain/entities/login_model.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/utils/generateRandomNumber.dart';

abstract class AuthService {
  Future<CurrentUser?> login(LoginModel loginModel);
  Future<void> register(CurrentUser currentUser);
  Future<Response> updateInfo(dynamic currentUser);
  Future<dynamic> forgotPassword(String email);
  Future<Response> resetPassword(String username, String password);
  Future<dynamic> requestOtp(dynamic email);
  Future<Response> changePassword(dynamic email);
}

class ApiServiceImpl implements AuthService {
  // for authentication
  FirebaseAuth auth = FirebaseAuth.instance;

  //  FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for accessing firebase storage
  FirebaseStorage storage = FirebaseStorage.instance;
  // to return current user
  User get user => auth.currentUser!;

  // // for storing self information
  CurrentUser me = CurrentUser();

  // for accessing firebase messaging (Push Notification)
  FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  //  Future<void> createProduct(Product product,File file) async {
  //   final time = DateTime.now().millisecondsSinceEpoch.toString();
  //   return await firestore.collection('products')
  //       .doc("user.uid")
  //       .set(product.toJson());
  // }

  // Future <List<Product>> getProduct() async{
  //   final prod= await firestore
  //       .collection("products")
  //       .orderBy('sent', descending: true)
  //       .get();
  //   List<Product> list= prod.docs.map((doc) => Product.fromSnapShot(doc)).toList();
  //   return list;
  //
  // }

  // for getting firebase messaging token
  //  Future<void> getFirebaseMessagingToken() async {
  //   await fMessaging.requestPermission();
  //
  //   await fMessaging.getToken().then((t) {
  //     if (t != null) {
  //       me.pushToken = t;
  //       log('Push Token: $t');
  //     }
  //   });
  //
  //   // for handling foreground messages
  //   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   //   log('Got a message whilst in the foreground!');
  //   //   log('Message data: ${message.data}');
  //
  //   //   if (message.notification != null) {
  //   //     log('Message also contained a notification: ${message.notification}');
  //   //   }
  //   // });
  // }

  // for sending push notification
  //  Future<void> sendPushNotification(
  //     CurrentUser CurrentUser, String msg) async {
  //   try {
  //     final body = {
  //       "to": CurrentUser.pushToken,
  //       "notification": {
  //         "title": me.name, //our name should be send
  //         "body": msg,
  //         "android_channel_id": "chats"
  //       },
  //       // "data": {
  //       //   "some_data": "User ID: ${me.id}",
  //       // },
  //     };
  //
  //     var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json',
  //           HttpHeaders.authorizationHeader:
  //           'key=AAAAQ0Bf7ZA:APA91bGd5IN5v43yedFDo86WiSuyTERjmlr4tyekbw_YW6JrdLFblZcbHdgjDmogWLJ7VD65KGgVbETS0Px7LnKk8NdAz4Z-AsHRp9WoVfArA5cNpfMKcjh_MQI-z96XQk5oIDUwx8D1'
  //         },
  //         body: jsonEncode(body));
  //     log('Response status: ${res.statusCode}');
  //     log('Response body: ${res.body}');
  //   } catch (e) {
  //     log('\nsendPushNotificationE: $e');
  //   }
  // }

  // for checking if user exists or not?
  Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  // for adding an chat user for our conversation

  // for getting current user info
  Future<dynamic> getSelfInfo() async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await firestore.collection('users').doc(user.uid).get();
    if (userData.exists) {
      return CurrentUser.fromMap(userData.data()!);
    } else {
      return null;
    }
  }

  // for getting id's of known users from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  // for getting all users from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return firestore
        .collection('users')
        .where('id',
            whereIn: userIds.isEmpty
                ? ['']
                : userIds) //because empty list throws an error
        // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  Future<void> updateUserInfo(CurrentUser currentUser) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update(currentUser.toMap());
  }

  // update profile picture of user
  //  Future<void> updateProfilePicture(File file) async {
  //   //getting image file extension
  //   final ext = file.path.split('.').last;
  //   log('Extension: $ext');
  //   //storage file ref with path
  //   final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
  //   //uploading image
  //   await ref
  //       .putFile(file, SettableMetadata(contentType: 'image/$ext'))
  //       .then((p0) {
  //     log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
  //   });
  //
  //   var image = await ref.getDownloadURL();
  //   await firestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .update({'image': image});
  // }

  // for getting specific user info

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      CurrentUser CurrentUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: CurrentUser.id)
        .snapshots();
  }

  // update online or last active status of user
  Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  //
  // ///************** Chat Screen Related APIs **************
  //
  // // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)
  //
  // // useful for getting conversation id
  // String getConversationID(String id) => user.uid.hashCode <= id.hashCode
  //     ? '${user.uid}_$id'
  //     : '${id}_${user.uid}';
  //
  // // for getting all messages of a specific conversation from firestore database
  // Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(CurrentUser user) {
  //   return firestore
  //       .collection('chats/${getConversationID(user.id!)}/messages/')
  //       .orderBy('sent', descending: true)
  //       .snapshots();
  // }

  Future updateProfilePicture(Uint8List file) async {
    Reference ref = storage.ref().child(user.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': downloadUrl});
  }

  @override
  Future<dynamic> forgotPassword(email) async {
    // TODO: implement forgotPassword

    try {
      // DocumentSnapshot<Map<String, dynamic>> userData =
      //     await firestore.collection('users').doc(user.uid).get();
      Stream<QuerySnapshot<Map<String, dynamic>>> userData = firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .snapshots();

      String eml = "";
      userData.listen((event) {
        print("event: ${event.docs.first["email"]}");
        print("event: ${event.docs.first["first_name"]}");
        eml = event.docs.first["email"].toString();
      });

      firestore.collection('users').doc(user.uid).update({
        'reset_otp': generateRandNumber(6),
      });

      return email;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CurrentUser?> login(LoginModel loginModel) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password!);

      DocumentSnapshot<Map<String, dynamic>> userData =
          await firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        return CurrentUser.fromMap(userData.data()!);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(CurrentUser currentUser) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: currentUser!.email!, password: currentUser.password!);
      if (user != null) {
        currentUser.id = auth.currentUser!.uid;
        return await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .set(currentUser.toMap());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> requestOtp(email) async {
    throw UnimplementedError();
  }

  @override
  Future<Response> resetPassword(String username, String password) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Response> updateInfo(currentUser) {
    // TODO: implement updateInfo
    throw UnimplementedError();
  }

  @override
  Future<Response> changePassword(email) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
}
