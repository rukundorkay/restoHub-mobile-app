import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restohub/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restohub/components/appbar.dart';
import 'package:restohub/models/product.dart';
import 'package:restohub/screens/dishes.dart';
import 'package:restohub/screens/location.dart';
import 'package:restohub/screens/login.dart';
import 'package:http/http.dart' as http;

final _auth = FirebaseAuth.instance;
List restaurantsFound = [];
List Logo = [
  '',
  '',
  'images/brioche.png',
  'images/java.jpg',
  'images/kfc.png',
  'images/coffe corner.png',
  'images/plus 250.jpg',
  'images/burbon cofee.png',
  'images/simba.jpg'
];

class RestuarantsScreen extends StatefulWidget {
  const RestuarantsScreen(
      {Key? key, required this.selectby, required this.selectbyvalue})
      : super(key: key);
  // Declare a field that holds the Todo.
  final selectby;
  final selectbyvalue;

  @override
  _RestuarantsScreenState createState() => _RestuarantsScreenState();
}

class _RestuarantsScreenState extends State<RestuarantsScreen> {
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.cubeGrid;
    EasyLoading.instance.indicatorColor = darkprimarycolor;
    EasyLoading.show(
      status: 'loading...',
    );
    fetchRestaurant(widget.selectby, widget.selectbyvalue);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchRestaurant(selectby, selectbyvalue) async {
    dynamic response;
    if (selectby == 'location') {
      response = await http.get(Uri.parse(
          'http://rwandarestaurantapi.herokuapp.com/restaurants/?district=$selectbyvalue'));
      EasyLoading.dismiss();
    } else if (selectby == 'rating') {
      response = await http.get(Uri.parse(
          'http://rwandarestaurantapi.herokuapp.com/restaurants/?rating=$selectbyvalue'));
      EasyLoading.dismiss();
    } else if (selectby == 'owner') {
      response = await http.get(Uri.parse(
          'http://rwandarestaurantapi.herokuapp.com/restaurants/?owner=$selectbyvalue'));
      EasyLoading.dismiss();
    }
    if (response.statusCode == 200) {
      var encodedBody = jsonDecode(response.body);

      setState(() {
        restaurantsFound = encodedBody;
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
      key: _scaffoldKey,
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          Container(
            height: 120.0,
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            color: darkprimarycolor,
            child: ListTile(
              title: const Text(
                "RestoHub",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              onTap: () {},
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.arrow_circle_down),
            title: const Text('Select By'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LocationScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text('About'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              try {
                await _auth.signOut();

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
              } on FirebaseAuthException catch (e) {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text(' Ops!  Failed'),
                          content: Text('${e.message}'),
                        ));
              }
            },
          ),
        ],
      )),
      appBar: buildAppBar(_scaffoldKey),
      body: SafeArea(
        child: ListView(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150.0,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: darkprimarycolor,
            ),
            child: Column(
              children: [
                Text(
                  "${restaurantsFound.length} ",
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(height: 10.0),
                const Text("Restaurants found",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ],
            ),
          ),
          for (var restaurant in restaurantsFound)
            Container(
              height: 150.0,
              padding: const EdgeInsets.fromLTRB(30, 30, 10, 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DishScreen(restaurantId: restaurant['id'])));
                },
                child: Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          Logo[restaurant['id']],
                          width: 90,
                          height: 90,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Text(
                            restaurant['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // color: Colors.white
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 0.0),
                            child: RatingBarIndicator(
                              direction: Axis.horizontal,
                              rating: restaurant['rating'].toDouble(),
                              itemCount: 5,
                              itemSize: 18.0,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: darkprimarycolor,
                                size: 12.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            restaurant['district'],
                            // style: const TextStyle(
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.w500,
                            //   // color: Colors.white
                            // ),
                          ),
                          const Divider(
                            thickness: 1.0,
                            color: darkprimarycolor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
