import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uberclone/dialog/notificationdialog.dart';
import 'package:uberclone/helper/firebase_helper.dart';
import 'package:get/get.dart';
import 'package:uberclone/screens/rider_home_screen.dart';
class Authcontroller extends GetxController {
  var isSignup = false.obs;
  var isLogin = false.obs;


  Future<void> creatUser(
      String name, String mobile, String email, String password ) async {
    try {

      progressDialog('Logging in..');
      final authuser = await authinstance.createUserWithEmailAndPassword(
          email: email, password: password);
      final response = await firestore.collection('users').doc(authuser.user!.uid).set({
        'name': name,
        'mobile': mobile.trim(),
        'email': email.trim(),
      }).then((_){
      Get.back();
      Get.offAllNamed(RiderHomeScreen.screenName);
      });
      

    } on FirebaseAuthException catch (e) {
      
      if(e.code != null)
      {
      Get.back();
      createUserHandler(e);

      }


    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginUser(String email, String password ) async {
  
    try {
      isLogin(true);
        progressDialog('Authenticating...');
      final authuser = await authinstance.signInWithEmailAndPassword(  email: email, password: password);
      
      final userdata = await firestore.collection('users').doc(authuser.user!.uid).get();
      if (userdata != null) {
        isLogin(false);
        Get.back();
        Get.offAllNamed(RiderHomeScreen.screenName);
      } else {
        Get.back();
        authinstance.signOut();
        isLogin(false);
      }
    } on FirebaseAuthException catch (error) {
       Get.back();
      loginUserHandler(error);

      isLogin(false);
    } catch (e) {
      rethrow;
    }
  }
}
