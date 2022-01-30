import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Dishes"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildcategory(index),
      ),
    );
  }

  Widget buildcategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 150, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: selectedIndex == index
                      ? Colors.deepOrange
                      : Colors.orange),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 2,
              width: 28,
              color: selectedIndex == index
                  ? Colors.deepOrange
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
