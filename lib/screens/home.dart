import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my/components/category_card.dart';
import 'package:my/components/grid_view_deligate_height.dart';
import 'package:my/components/task_card.dart';
import 'package:my/constants.dart';
import 'package:my/model/category_model.dart';
import 'package:my/model/task_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CategoryModel> categories = [];
  late List<TaskModel> tasks = [];
  late bool isActiveFib = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      categories = [
        CategoryModel(
          title: "Inbox",
          lengths: 1,
          color: HexColor("#61DEA4"),
        ),
        CategoryModel(
          title: "Shopping",
          lengths: 4,
          color: HexColor("#B678FF"),
        ),
        CategoryModel(
          title: "Family",
          lengths: 3,
          color: HexColor("#F45E6D"),
        ),
        CategoryModel(
          title: "Personal",
          lengths: 19,
          color: HexColor("#FFE761"),
        ),
      ];

      tasks = [
        TaskModel(
          title: "Start making a presentation",
          isActive: false,
          categoryColor: categories[0].color,
        ),
        TaskModel(
          title: "Start making",
          isActive: false,
          categoryColor: categories[0].color,
        ),
        TaskModel(
          title: "Start Reading",
          isActive: false,
          categoryColor: categories[0].color,
        ),
        TaskModel(
          title: "Start making a presentation",
          isActive: false,
          categoryColor: categories[0].color,
        ),
      ];
    });
  }

  Future<bool> _handleWillPop() async {
    exit(0);
  }

  void _handleSwitchActiveTask(int index) {
    setState(() {
      tasks[index].isActive = !tasks[index].isActive;
    });
  }

  void _handleDeleteTask(int index) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    TaskModel removedTask = tasks[index];

    setState(() {
      tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          setState(() {
            tasks.insert(index, removedTask);
            ScaffoldMessenger.of(context);
          });
        },
        child: Text(
          "undo",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    ));
  }

  void _handleSwitchActiveFib() {
    setState(() {
      isActiveFib = !isActiveFib;
    });
  }

  Widget _NewestTodo() {
    return ListView.builder(
      itemCount: tasks.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return TaskCard(
          categoryColor: tasks[index].categoryColor,
          isActive: tasks[index].isActive,
          title: tasks[index].title,
          onTap: () => {_handleSwitchActiveTask(index)},
          onRemoveTask: () => {_handleDeleteTask(index)},
        );
      },
    );
  }

  Widget _CategoryList(BuildContext context) {
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
            itemCount: categories.length,
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
                color: categories[index].color,
                title: categories[index].title,
                lengths: categories[index].lengths,
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 10, top: 20),
                  child: Text(
                    "Newest Todo",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                _NewestTodo(),
                _CategoryList(context),
              ],
            ),
            isActiveFib
                ? Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white.withOpacity(0.7),
                  )
                : Container(),
            isActiveFib
                ? Positioned(
                    child: Container(
                      width: 220,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    bottom: 80,
                    right: 15,
                  )
                : Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleSwitchActiveFib,
          child: Icon(
            isActiveFib ? Icons.remove : Icons.add,
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
