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


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for accessing firebase storage
  FirebaseStorage storage = FirebaseStorage.instance;
  // to return current user
  User get user => auth.currentUser!;

  // // for storing self information
  CurrentUser me = CurrentUser();

  FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }


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
