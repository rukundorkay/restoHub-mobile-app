import 'package:flutter/material.dart';

import '../color.dart';

// import 'package:google_fonts/google_fonts.dart';

final ThemeData restohubTheme = restohubLightTheme();
ThemeData restohubLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: darkprimarycolor,
        onPrimary: lightprimarycolor,
        secondary: secondarytextcolor,
      ),
      brightness: Brightness.light,
      errorColor: Colors.red,
      dividerColor: dividercolor,
      textTheme: restohubTextTheme(base.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: darkprimarycolor,
      ));
}

TextTheme restohubTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'latto',
        displayColor: primarytextcolor,
        bodyColor: darkprimarycolor,
      );
}
