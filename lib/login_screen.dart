import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uberclone/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  static const screenName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailfield = TextEditingController();
  final passwordfield = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 30,
        ),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(LoginScreen.screenName);
                  },
                  child: Text('Sigin')),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an acount?'),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    child: const Text('Singin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Get.toNamed(SignUpScreen.screenName);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
