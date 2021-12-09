import 'package:flutter/material.dart';
import 'components/theme.dart';
import 'screens/home.dart';
import 'screens/login.dart';

class DmenuApp extends StatelessWidget {
  const DmenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dmenu",
      home: const HomeScreen(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: dmenuTheme,
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
