import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uberclone/helper/firebase_helper.dart';
import 'package:uberclone/login_screen.dart';

class RiderHomeScreen extends StatelessWidget {
  static const screenName = '/riderhome';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ElevatedButton(onPressed: (){
        authinstance.signOut();
        Get.offNamed(LoginScreen.screenName);
      }, child: Text('Logout')),
    );
  }
}