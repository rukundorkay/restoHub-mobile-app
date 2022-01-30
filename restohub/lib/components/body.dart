import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restohub/color.dart';
import 'package:restohub/components/categories.dart';
import 'package:restohub/models/product.dart';
import 'package:restohub/screens/details.dart';

import 'itemcard.dart';

List logo = [
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

class body extends StatelessWidget {
  final restaurantFound;
  const body({Key? key, required this.restaurantFound}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // height: 200,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(25),
                height: 150,
                decoration: const BoxDecoration(color: darkprimarycolor),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset(
                        logo[restaurantFound['id']],
                        width: 90,
                        height: 90,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantFound['name'],
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${restaurantFound['district']}, ${restaurantFound['sector']}',
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          RatingBarIndicator(
                            direction: Axis.horizontal,
                            rating: restaurantFound['rating'].toDouble(),
                            itemCount: 5,
                            itemSize: 18.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Categories(),
        // const Text(
        //   "DISHES",
        //   style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.w500,
        //       color: darkprimarycolor),
        // ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
              itemCount: restaurantFound['dishes'].length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: kDefaultPaddin,
                crossAxisSpacing: kDefaultPaddin,
              ),
              itemBuilder: (context, index) => ItemCard(
                dish: restaurantFound['dishes'][index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
