import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void createUserHandler(FirebaseAuthException e) {
  String message;

  switch (e.code) {
    case 'weak-password':
      {
        message = 'Weak Password';
      }
      break;
    case 'email-already-in-use':
      {
        message = 'Email Already in use';
      }
      break;
    case 'operation-not-allowed':
      {
        message = 'Operation Not Allowed';
      }
      break;
    default:
      {
        message = e.toString();
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
        message,
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

void loginUserHandler(FirebaseAuthException e) {
  var message;
  switch (e.code) {
    case 'invalid-email':
      {
        message = 'Email not found';
      }
      break;
    case 'nulll':
      {
        message = 'Please check your password';
      }
      break;
    default:
      {
        message = message.toString();
      }
      break;
  }
  Get.defaultDialog(
      backgroundColor: Colors.white,
      title: 'failed to signin',
      titleStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      titlePadding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      textConfirm: 'Ok',
      content: Text(
        message,
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

void progressDialog( String message) async {
  Get.defaultDialog(
    backgroundColor: Colors.black54,
    title: '',
    titlePadding: EdgeInsets.all(0),
    content: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                strokeWidth: 7,
                color: Colors.white,
              )),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    ),
  );
}
