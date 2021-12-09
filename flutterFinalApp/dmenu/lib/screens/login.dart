import 'dart:math';
import 'package:flutter/material.dart';
import '../colors.dart';

// import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: -MediaQuery.of(context).size.height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: Container(
              child: Transform.rotate(
                angle: -pi / 3.5,
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        darkprimarycolor,
                        lightprimarycolor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150.0),
                  Row(
                    children: [
                      Column(
                        children: [
                          Image.asset('images/bellystar.jpg',
                              width: 100, height: 100)
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Dmenu',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: "username",
                ),
                // controller: _usernameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "password"),
                // controller: _passwordController,
                obscureText: true,
              ),
              ButtonBar(
                children: [
                  TextButton(
                      onPressed: () {
                        // _usernameController.clear();
                        // _passwordController.clear();
                      },
                      child: const Text("create New account")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("login"))
                ],
                buttonPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
