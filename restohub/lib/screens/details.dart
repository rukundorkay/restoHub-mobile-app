import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restohub/color.dart';
import 'package:restohub/models/product.dart';
import 'package:http/http.dart' as http;

Map dishFound = {
  "id": 0,
  "name": "",
  "cookingTime": "",
  "ingridient": "",
  "price": "",
  "images": []
};

class DetailScreen extends StatefulWidget {
  final dish;
  DetailScreen({Key? key, required this.dish}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.cubeGrid;
    EasyLoading.instance.indicatorColor = darkprimarycolor;
    EasyLoading.show(
      status: 'loading...',
    );
    fetchSingleDish(widget.dish);
  }

  Future<void> fetchSingleDish(dish) async {
    final http.Response response;
    response = await http.get(
        Uri.parse('https://rwandarestaurantapi.herokuapp.com/dishes/$dish/'),
        headers: {
          "authorization": "token fecf877533bd1187022eb1207f15bb888602c852"
        });

    if (response.statusCode == 200) {
      var encodedBody = jsonDecode(response.body);
      EasyLoading.dismiss();

      setState(() {
        dishFound = encodedBody;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dishFound['name'],
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: darkprimarycolor,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg2.jpg"), fit: BoxFit.cover)),
        child: ListView(
          padding: const EdgeInsets.all(kDefaultPaddin),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  dishFound['name'],
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkprimarycolor),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: SizedBox(
                    height: 230,
                    width: 210,
                    child: Image.asset(dishImage[dishFound['id']]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    dishFound['ingridient'],
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Price: ${dishFound['price']} RWF",
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkprimarycolor),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
