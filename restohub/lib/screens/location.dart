import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restohub/components/predifinedstyle.dart';
import 'package:restohub/models/restaurant.dart';
import 'package:restohub/screens/details.dart';
import 'package:restohub/screens/dishes.dart';
import 'package:restohub/screens/restaurants.dart';

import '../color.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<String> ownerList = [];
  List<String> optionList = ['location', 'owner', 'rating'];
  List<String> ratingList = ['1', '2', '3', '4', '5'];
  List<String> locationList = [];

  List<String> values = [];
  String? selectedOption;
  String? selectedValue; // will ues this variable later

  @override
  void initState() {
    super.initState();
    fetchRestaurantOwner();
    fetchRestaurantLocation();
  }

  Future<void> fetchRestaurantOwner() async {
    final response = await http.get(
        Uri.parse('http://rwandarestaurantapi.herokuapp.com/restaurants/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<String> owner = [];

      var encodedBody = jsonDecode(response.body);

      for (var item in encodedBody) {
        owner.add(item['Owner']);
      }
      owner = owner.toSet().toList();
      setState(() {
        ownerList = owner;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load flutter pub add firebase_auth');
    }
  }

  Future<void> fetchRestaurantLocation() async {
    final response = await http.get(
        Uri.parse('http://rwandarestaurantapi.herokuapp.com/restaurants/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<String> location = [];

      var encodedBody = jsonDecode(response.body);

      for (var item in encodedBody) {
        location.add(item['district']);
      }
      location = location.toSet().toList();
      setState(() {
        locationList = location;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load flutter pub add firebase_auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            children: <Widget>[
              // FutureBuilder<Restaurant>(
              //   future: futureRestaurant,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Text(snapshot.data!.owner);
              //     } else if (snapshot.hasError) {
              //       return Text('${snapshot.error}');
              //     }

              //     // By default, show a loading spinner.
              //     return const CircularProgressIndicator();
              //   },
              // ),
              const SizedBox(height: 140),
              const SizedBox(
                height: 30,
                child: Text(
                  "Select by location , Owner, ratings  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: darkprimarycolor, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                width: 10.0,
                height: 70.0,
                child: Text(
                  ' Find the best restaurants from where you want to order',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondarytextcolor),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: selectboxdecoration(),
                hint: const Text('select by'),
                value: selectedOption,
                isExpanded: true,
                items: optionList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (option) {
                  if (option == 'location') {
                    values = locationList;
                  } else if (option == 'owner') {
                    values = ownerList;
                  } else if (option == 'rating') {
                    values = ratingList;
                  } else {
                    values = [];
                  }
                  setState(() {
                    selectedValue = null;
                    selectedOption = option;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: selectboxdecoration(),
                hint: const Text('select value'),
                value: selectedValue,
                isExpanded: true,
                items: values.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (optionvalue) {
                  setState(() {
                    selectedValue = optionvalue;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: elevatedbuttonStyle(),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RestuarantsScreen(
                                      selectby: selectedOption,
                                      selectbyvalue: selectedValue)));
                    },
                    child: const Text("FIND RESTAURANTS"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
