import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:uberclone/login_screen.dart';
import 'package:uberclone/screens/home_screen.dart';
import 'package:uberclone/screens/rider_home_screen.dart';
import 'package:uberclone/screens/search_screen.dart';
import 'package:uberclone/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        name: 'SecondaryApp',
        options: FirebaseOptions(
            apiKey: "AIzaSyC3dp1B8Fe6SRtLkZ1Z6mQZtes1Q7868VA",
            appId: '1:986922107564:android:16ecd2cd75eb00c2c49509',
            messagingSenderId: '986922107564',
            projectId: 'ubercloneapp-7e24a'));
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
    } else {
      throw e;
    }
  } catch (e) {
    rethrow;
  }
  runApp(UbberApp());
}

class UbberApp extends StatefulWidget {
  const UbberApp({Key? key}) : super(key: key);

  @override
  _UbberAppState createState() => _UbberAppState();
}

class _UbberAppState extends State<UbberApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(),
      getPages: [
        GetPage(name: LoginScreen.screenName, page: () => LoginScreen()),
        GetPage(name: SignUpScreen.screenName, page: () => SignUpScreen()),
        GetPage(
            name: RiderHomeScreen.screenName, page: () => RiderHomeScreen()),
        GetPage(name: HomeScreen.screenName, page: () => HomeScreen()),
        GetPage(name: SearchScreen.screenName, page: () => SearchScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }

  
}
