// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:smartfiber/error/app_error.dart';
import 'package:smartfiber/error/firebase_auth_error_constants.dart';
import 'package:smartfiber/fields/user_fields.dart';
// import 'package:smartfiber/error/app_error.dart';
// import 'package:smartfiber/error/firebase_auth_error_constants.dart';
// import 'package:smartfiber/fields/user_fields.dart';

class User extends ChangeNotifier {
  String? firstname;
  String? lastname;
  String? type;
  String? address;
  String? phoneNumber;
  String? dateOfBirth;
  String? email;
  String? token;
  String? uid;
  int? laravelId;

  Map<String, String?>? prevData;

  Map<String, String>? get getUser {
    if (firstname == null &&
        lastname == null &&
        address == null &&
        phoneNumber == null &&
        dateOfBirth == null &&
        email == null) {
      return null;
    }

    return {
      UserFields.firstname: firstname!,
      UserFields.lastname: lastname!,
      UserFields.address: address!,
      UserFields.phoneNumber: phoneNumber!,
      UserFields.dateOfBirth: dateOfBirth!,
      UserFields.email: email!,
      UserFields.token: token!,
    };
  }

  void setUser(json) {
    firstname = json[UserFields.firstname];
    lastname = json[UserFields.lastname];
    address = json[UserFields.address];
    phoneNumber = json[UserFields.phoneNumber];
    dateOfBirth = json[UserFields.dateOfBirth];
    email = json[UserFields.email];
    token = json[UserFields.token];
    uid = json[UserFields.uid];
    laravelId = json[UserFields.laravelId];
    type = json[UserFields.userType];

    notifyListeners();
  }

  Future<String> setPersonalInformation(String? _firstname, String? _lastname, String? _address,
      String? _phoneNumber, DateTime? _dof) async {
    prevData = {
      UserFields.firstname: firstname,
      UserFields.lastname: lastname,
      UserFields.address: address,
      UserFields.phoneNumber: phoneNumber,
      UserFields.dateOfBirth: dateOfBirth
    };

    firstname = _firstname ?? firstname;
    lastname = _lastname ?? lastname;
    address = _address ?? address;
    phoneNumber = _phoneNumber ?? phoneNumber;
    dateOfBirth = _dof?.toString() ?? dateOfBirth;

    try {
      final String result = await syncPersonalInformation();

      return result;
    } on Exception catch (e) {
      log(e.toString());
      throw Exception("Failed to update profile");
    }
  }

  Future<String> syncPersonalInformation() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return errorMessage(FirebaseAuthError.userNotAuthenticated);
    }

    final userRef = FirebaseFirestore.instance.collection("users").doc(uid);
    await userRef.update(getUser!);

    return "Profile updated successfully";
  }

  Future<String> setAccountInformation(String _email, String _password) async {
    try {
      email = _email;

      String result = await syncAccountInformation(_email, _password);

      return result;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to update account information");
    }
  }

  Future<String> syncAccountInformation(String email, String password) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      await currentUser!.updatePassword(password);
      await currentUser.verifyBeforeUpdateEmail(email);
      final userRef = FirebaseFirestore.instance.collection("users").doc(currentUser.uid);
      userRef.update({UserFields.email: email});

      return "Account information updated successfully";
    } on FirebaseAuthException catch (e) {
      log(e.code);
      throw Exception(e.code);
    }
  }
}
