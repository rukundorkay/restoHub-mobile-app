import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restohub/components/predifinedstyle.dart';
import 'package:restohub/screens/location.dart';
import 'package:restohub/screens/restaurants.dart';
import 'package:restohub/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../color.dart';
import 'dishes.dart';

// import 'package:google_fonts/google_fonts.dart';
final _auth = FirebaseAuth.instance;
String email = '';
String password = '';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            children: <Widget>[
              // const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(height: 50.0),
                ],
              ),
              const SizedBox(height: 170.0),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  style: const TextStyle(height: 1.0),
                  decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          borderSide: BorderSide(color: Colors.teal)))),
              const SizedBox(height: 20.0),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                style: const TextStyle(height: 1.0),
                decoration: const InputDecoration(
                    labelText: "password",
                    prefixIcon: Icon(Icons.lock_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      borderSide: BorderSide(color: Colors.teal),
                    )),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: elevatedbuttonStyle(),
                    onPressed: () async {
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (contex) => LocationScreen(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Text(' Ops! Login Failed'),
                                  content: Text('${e.message}'),
                                ));
                      }
                    },
                    child: const Text("SIGN IN"),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: const [
                      Text(
                        "Don`t have an account ?",
                        style: TextStyle(color: secondarytextcolor),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignupScreen(),
                              ));
                        },
                        child: const Text("SIGN UP"),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          //]
        ),
      ),
    );
  }
}
