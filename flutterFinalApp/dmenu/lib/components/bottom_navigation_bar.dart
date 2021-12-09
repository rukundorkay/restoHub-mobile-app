import 'package:dmenu/colors.dart';
import 'package:dmenu/screens/login.dart';
import 'package:dmenu/screens/profile.dart';
import 'package:flutter/material.dart';

class MyBottomNavigatioBar extends StatefulWidget {
  MyBottomNavigatioBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigatioBarState createState() => _MyBottomNavigatioBarState();
}

class _MyBottomNavigatioBarState extends State<MyBottomNavigatioBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTap,
      items: [
        // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        // BottomNavigationBarItem(
        //   icon: IconButton(
        //       onPressed: () {
        //         print("ok");
        //       },
        //       icon: Icon(Icons.home)),
        // ),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded), label: 'scan'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'Profile'),
      ],
    );
  }

  void onItemTap(index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 0) {
      Navigator.pop(context, MaterialPageRoute(builder: (context) {
        return profileScreen();
      }));
    }
    // print('tes');
  }
}

// Route<dynamic>? _test(RouteSettings settings) {
//   if (settings.name != '/profile') {
//     return null;
//   }

//   return MaterialPageRoute<void>(
//     settings: settings,
//     builder: (BuildContext context) => LoginScreen(),
//     fullscreenDialog: true,
//   );
// }
