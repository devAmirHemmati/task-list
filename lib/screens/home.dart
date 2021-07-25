import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my/components/category_card.dart';
import 'package:my/components/grid_view_deligate_height.dart';
import 'package:my/components/task_card.dart';
import 'package:my/constants.dart';

class HomeScreen extends StatelessWidget {
  Future<bool> _handleWillPop() async {
    exit(0);
  }

  Widget _NewestTodo() {
    return Column(
      children: [
        TaskCard(
          categoryColor: Colors.deepOrange,
          isActive: true,
          title:
              "please done my tasks please done my tasks please done my tasks please done my tasks tasks please done my tasks please done my tasks",
        ),
        TaskCard(
          categoryColor: Colors.deepOrange,
          isActive: false,
          title: "please done my tasks",
        ),
        TaskCard(
          categoryColor: Colors.deepOrange,
          isActive: false,
          title: "please done my tasks",
        ),
      ],
    );
  }

  Widget _CategoryList(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width + size.width;

    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
        top: 32,
        left: 18,
        right: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category List',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor(
                THEME_COLORS['secondary-2'],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 15,
            ),
          ),
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              height: 100,
            ),
            itemBuilder: (BuildContext context, int index) {
              return CategoryCard(
                color: HexColor("#61DEA4"),
                title: "Inbox",
                lengths: 2,
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Newest Todo",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(
          children: [
            _NewestTodo(),
            _CategoryList(context),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: HexColor(
              THEME_COLORS['primary-1'],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 3,
        ),
      ),
      onWillPop: _handleWillPop,
    );
  }
}
