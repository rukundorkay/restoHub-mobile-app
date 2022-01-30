import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restohub/components/theme.dart';

import 'components/theme.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

class RestoHub extends StatelessWidget {
  const RestoHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RestoHub",
      // home: ,
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: restohubTheme,
      builder: EasyLoading.init(),
    );
  }
}

Route<dynamic>? _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => LoginScreen(),
    fullscreenDialog: true,
  );
}
