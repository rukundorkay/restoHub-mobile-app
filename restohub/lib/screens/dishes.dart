import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restohub/components/body.dart';
import 'package:http/http.dart' as http;
import 'package:restohub/models/restaurant.dart';
import '../color.dart';

Map restaurantFound = {
  "id": 2,
  "name": "",
  "district": "",
  "sector": "",
  "rating": 0,
  "dishes": []
};

class DishScreen extends StatefulWidget {
  const DishScreen({Key? key, required this.restaurantId}) : super(key: key);

  final restaurantId;

  @override
  _DishScreenState createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  @override
  void initState() {
    super.initState();
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.cubeGrid;
    EasyLoading.instance.indicatorColor = darkprimarycolor;
    EasyLoading.show(
      status: 'loading...',
    );
    fetchSingleRestaurant(widget.restaurantId);
  }

  Future<void> fetchSingleRestaurant(restaurant) async {
    final http.Response response;
    response = await http.get(
        Uri.parse(
            'https://rwandarestaurantapi.herokuapp.com/restaurant/$restaurant/'),
        headers: {
          "authorization": "token fecf877533bd1187022eb1207f15bb888602c852"
        });

    if (response.statusCode == 200) {
      var encodedBody = jsonDecode(response.body);
      EasyLoading.dismiss();

      // print(encodedBody);

      setState(() {
        restaurantFound = encodedBody;
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
      appBar: buildasset(),
      body: body(restaurantFound: restaurantFound),
    );
  }

  AppBar buildasset() {
    return AppBar(
      backgroundColor: darkprimarycolor,
      elevation: 0,
      title: Text(
        restaurantFound['name'],
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
