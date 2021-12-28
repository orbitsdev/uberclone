import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uberclone/controller/authcontroller.dart';
import 'package:uberclone/dialog/notificationdialog.dart';
import 'package:uberclone/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  static const screenName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authxcontroller = Get.put(Authcontroller());
  final emailfield = TextEditingController();
  final passwordfield = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> signUser(BuildContext context) async {
    final isvalidated = _formkey.currentState!.validate();
    _formkey.currentState!.save();
    if (isvalidated) {
      await authxcontroller.loginUser(emailfield.text, passwordfield.text).then((value){
      });
    }
  }

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
                controller: emailfield,
                autocorrect: false,
                enableSuggestions: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(fontSize: 10),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: passwordfield,
                obscureText: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  signUser(context);
                },
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 10),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    signUser(context);
                  },
                  child: Text('login')),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an acount?'),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    child: const Text('Signup',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Get.toNamed(SignUpScreen.screenName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
