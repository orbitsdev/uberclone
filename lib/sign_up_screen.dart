import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uberclone/controller/authcontroller.dart';
import 'package:uberclone/dialog/notificationdialog.dart';
import 'package:uberclone/helper/firebase_helper.dart';

class SignUpScreen extends StatefulWidget {
  static const screenName = '/sigup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authxcontroller = Get.find<Authcontroller>();
  
  final namefield = TextEditingController();
  final mobilefield = TextEditingController();
  final emailfield = TextEditingController();
  final passwordfield = TextEditingController();
  final confirmfield = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void singupUser() async {
    final isvalidated = _formkey.currentState!.validate();

    if (isvalidated) {
      _formkey.currentState!.save();

       await authxcontroller.creatUser(namefield.text, mobilefield.text,
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
                  hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 14),
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 14),
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
                  hintStyle: TextStyle(
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Mobile',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 14),
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
                  hintStyle: TextStyle(fontSize: 10),
                  labelStyle: TextStyle(fontSize: 14),
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
                  hintStyle: TextStyle(fontSize: 10),
                  labelStyle: TextStyle(fontSize: 14),
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 14),
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
                  hintStyle: TextStyle(fontSize: 10),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
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
                            child: const Text('Signin',
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
          ),
        ),
      ),
    );
  }
}
