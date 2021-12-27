import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uberclone/controller/authcontroller.dart';
import 'package:uberclone/login_screen.dart';

import 'dialog/notificationdialog.dart';

class SignUpScreen extends StatefulWidget {
  static const screenName = '/sigup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authcontroller = Get.put(Authcontroller());
  final namefield = TextEditingController();
  final mobilefield = TextEditingController();
  final emailfield = TextEditingController();
  final passwordfield = TextEditingController();
  final confirmfield = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void singupUser() {
    final isvalidated = _formkey.currentState!.validate();

    if (isvalidated) {
      _formkey.currentState!.save();
      authcontroller.creatUser(namefield.text, mobilefield.text,
          emailfield.text, passwordfield.text);
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
                controller: namefield,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: mobilefield,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mobile number is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Mobile',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: emailfield,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }

                  if (!value.contains("@")) {
                    return 'Please Enter a valid email';
                  }
                  return null;
                },
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
                controller: passwordfield,
                obscureText: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length <= 5) {
                    return 'Password should at least 6 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text, 
                controller: confirmfield,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  singupUser();
                },

                validator: (value) {
                  if (value != passwordfield.text) {
                    return 'Password did not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Obx(() {
                if (authcontroller.isSignup.value) {
                  return Container(
                      height: 24,
                      width: 24,
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            singupUser();
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
                          const Text('Already have an acount?'),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: const Text('Signup',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
