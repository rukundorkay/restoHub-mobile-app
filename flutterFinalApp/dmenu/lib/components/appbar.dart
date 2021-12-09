import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    leading: IconButton(
        icon: const Icon(
          Icons.menu,
          semanticLabel: 'menu',
        ),
        onPressed: () {
          print("ok iam me");
        }),
    title: Text('Dmenu app'),
    actions: <Widget>[
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            semanticLabel: "search",
          )),
      // IconButton(
      //   onPressed: () {},
      //   icon: const Icon(
      //     Icons.tune,
      //     semanticLabel: "filter",
      //   ),
      // ),
    ],
  );
}
