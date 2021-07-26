import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  late Color _color;
  late String _title;
  late int _length;

  CategoryCard({
    required Color color,
    required String title,
    required int lengths,
  }) {
    this._color = color;
    this._title = title;
    this._length = lengths;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(
              '${this._length} task${this._length < 2 ? "" : "s"}',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(255, 255, 255, 0.5),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: this._color,
      ),
    );
  }
}
