import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:uberclone/dialog/notificationdialog.dart';
import 'package:uberclone/helper/firebase_helper.dart';

class Authcontroller extends GetxController {
  var isSignup = false.obs;

  void loginUser() {}

  Future<void> creatUser(
      String name, String mobile, String email, String password) async {
    try {
      isSignup(true);
      final authuser = await authinstance.createUserWithEmailAndPassword( email: email, password: password);
      final response = await firestore.collection('users').doc(authuser.user!.uid).set({

        'name': name,
        'mobile': mobile.trim(),
        'email': email.trim(),

      });
      isSignup(false);
      print(authuser.user!.uid);
      print(authuser.user!.email);
    } on FirebaseAuthException catch (e) {
      createUserHandler(e);
      isSignup(false);
    } catch (e) {
      rethrow;
    }
  }
}
