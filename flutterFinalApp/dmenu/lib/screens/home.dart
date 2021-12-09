import 'package:dmenu/components/appbar.dart';
import 'package:dmenu/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context) {
    return List.generate(100, (index) {
      return Card(
        // clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 6 / 4,
              child: Image.asset(
                'images/bellystar.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "PIZAA",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    const SizedBox(height: 4.0),

                    Text(
                      " RWF 12000",
                      style: Theme.of(context).textTheme.caption,
                    ),

                    // End new code
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context),
      ),
      bottomNavigationBar: MyBottomNavigatioBar(),
    );
  }
}
