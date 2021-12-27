import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void createUserHandler(FirebaseAuthException message) {
  String textmessage;

  switch (message.code) {
    case 'weak-password':
      {
        textmessage = 'Weak Password';
      }
      break;
    case 'email-already-in-use':
      {
        textmessage = 'Email Already in use';
      }
      break;
    case 'operation-not-allowed':
      {
        textmessage = 'Operation Not Allowed';
      }
      break;
    default:
      {
        textmessage = message.toString();
      }
      break;
  }

  Get.defaultDialog(
      backgroundColor: Colors.white,  
      title: 'Failed',
      titleStyle: TextStyle(),
      titlePadding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 20,
      ),
      textConfirm: 'Ok',
      content: Text(
        textmessage,
        style: TextStyle(fontSize: 14),
      ),
      radius: 2,
      onConfirm: () {
        Get.back();
      },
      contentPadding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ));
}
