import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restohub/models/product.dart';
import 'package:restohub/screens/details.dart';

import '../color.dart';

class ItemCard extends StatelessWidget {
  final dish;

  const ItemCard({
    Key? key,
    required this.dish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DetailScreen(
                      dish: dish['id'],
                    )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                // height: 160,
                // width: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(dishImage[dish['id']]),
                      fit: BoxFit.fitWidth,
                      scale: 1.0),
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              dish['name'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: primarytextcolor),
            ),
          )
        ],
      ),
    );
  }
}
