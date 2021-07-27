import 'package:flutter/material.dart';
import 'package:my/model/category_model.dart';

class DetailsCategoryScreen extends StatelessWidget {
  late CategoryModel cateogry;

  DetailsCategoryScreen({
    required this.cateogry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
            ),
            Text(
              "Details Category",
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: Text('details category ${this.cateogry.id}'),
    );
  }
}
