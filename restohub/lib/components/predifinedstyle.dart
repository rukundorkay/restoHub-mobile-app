import 'package:flutter/material.dart';

ButtonStyle elevatedbuttonStyle() {
  return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      )));
}

InputDecoration selectboxdecoration() {
  return const InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
    ),
  );
}
