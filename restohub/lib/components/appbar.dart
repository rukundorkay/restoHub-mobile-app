import 'package:flutter/material.dart';

AppBar buildAppBar(_scaffoldKey) {
  return AppBar(
    shadowColor: Color(0),
    leading: IconButton(
        icon: const Icon(
          Icons.menu,
          semanticLabel: 'menu',
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer()),
    title: const Text(
      'Restaurants',
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
