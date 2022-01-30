import 'dart:convert';
import 'package:http/http.dart' as http;

class Restaurant {
  // final int id;
  // final String name;
  // final int rating;
  final String owner;
  // final String district;

  Restaurant({
    // required this.id,
    // required this.name,
    // required this.rating,
    required this.owner,
    // required this.district
  });

  factory Restaurant.fromJson(List<String> json) {
    return Restaurant(owner: json[0]);
    // id: json['id'],
    // name: json['name'],
    // rating: json['rating'],
    // owner: json['owner'];
    // district: json['district']);
  }
}

Future<Restaurant> fetchRestaurantOwner() async {
  final response = await http
      .get(Uri.parse('http://rwandarestaurantapi.herokuapp.com/restaurants/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<String> owner = [];

    var encodedBody = jsonDecode(response.body);

    for (var item in encodedBody) {
      owner.add(item['Owner']);
    }
    owner = owner.toSet().toList();

    // print(jsonDecode(response.body));
    return Restaurant.fromJson(owner);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load flutter pub add firebase_auth');
  }
}
