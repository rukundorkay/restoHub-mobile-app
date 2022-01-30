import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restohub/components/predifinedstyle.dart';
import '../color.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
String email = '';
String password = '';

// import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
              image: AssetImage("images/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100.0),
                  Row(
                    children: const [
                      SizedBox(
                        width: 300,
                        height: 70,
                        child: Text(
                            ' Create Account and start  exploring different Restaurant countrywide',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: secondarytextcolor)),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              const TextField(
                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide: BorderSide(color: Colors.teal))),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                  onChanged: (value) {
                    email = value.toString().trim();
                  },
                  style: const TextStyle(height: 1.0),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          borderSide: BorderSide(color: Colors.teal)))

                  // controller: _usernameController,
                  ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Password";
                  }
                },
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

                // controller: _passwordController,

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
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Sucessfully Register.You Can Login Now'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                        Navigator.of(context).pop();
                      } on FirebaseAuthException catch (e) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title:
                                      const Text(' Ops! Registration Failed'),
                                  content: Text('${e.message}'),
                                ));
                      }
                    },
                    child: const Text("SIGN UP"),
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
                        "Have an account ?",
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
                                      LoginScreen()));
                        },
                        child: const Text("SIGN IN"),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
