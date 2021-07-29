import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my/components/category_card.dart';
import 'package:my/components/grid_view_deligate_height.dart';
import 'package:my/components/task_card.dart';
import 'package:my/constants.dart';
import 'package:my/model/category_model.dart';
import 'package:my/model/task_model.dart';
import 'package:my/screens/details_category.dart';
import 'package:my/screens/new_category.dart';
import 'package:my/screens/new_task.dart';
import 'package:my/sqlite/category_sql.dart';
import 'package:my/sqlite/task_sql.dart';

class HomeScreen extends StatefulWidget {
  late List<CategoryModel> categories = [];
  late List<TaskModel> tasks = [];

  HomeScreen({
    required this.categories,
    required this.tasks,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState(
        categories: categories,
        tasks: tasks,
      );
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CategoryModel> categories = [];
  late List<TaskModel> tasks = [];
  late bool isActiveFib = false;

  _HomeScreenState({
    required this.categories,
    required this.tasks,
  });

  @override
  void initState() {
    super.initState();

    setState(() {
      categories = [
        CategoryModel(
          id: 'inbox-category-id',
          title: 'Inbox',
          color: '#20bf6b',
        ),
        ...categories,
      ];
    });
  }

  void _addNewCategoryHandler(CategoryModel newCategory) async {
    var findCategoryIndex =
        categories.indexWhere((category) => category.id == newCategory.id);

    setState(() {
      if (findCategoryIndex == -1) {
        categories.add(newCategory);
        return;
      }

      categories[findCategoryIndex] = newCategory;
    });

    CategorySql db = CategorySql();

    if (findCategoryIndex == -1) {
      db.addNewCategory(
        newCategory,
      );
      return;
    }

    db.updateCategory(
      newCategory,
    );
  }

  Future<bool> _handleWillPop() async {
    return false;
    exit(0);
  }

  void _handleSwitchActiveTask(int index) async {
    setState(() {
      tasks[index].isActive = !tasks[index].isActive;
    });

    TaskSql db = TaskSql();

    await db.updateTask(tasks[index]);
  }

  void _handleInsertTask(int index, TaskModel insertedTask) {
    setState(() {
      tasks.insert(index, insertedTask);
    });
  }

  void _handleDeleteTask(int index, bool notShowSnackBar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    TaskModel removedTask = tasks[index];

    setState(() {
      tasks.removeAt(index);
    });

    TaskSql db = TaskSql();

    db.deleteTask(removedTask.id);

    // if (notShowSnackBar) return;

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   duration: Duration(seconds: 3),
    //   content: ElevatedButton(
    //     onPressed: () {
    //       ScaffoldMessenger.of(context).hideCurrentSnackBar();

    //       _handleInsertTask(index, removedTask);
    //     },
    //     child: Text(
    //       "undo",
    //       style: TextStyle(
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    // ));
  }

  void _handleAddNewTask(TaskModel newTask) async {
    var findTaskIndex = tasks.indexWhere((task) => task.id == newTask.id);

    setState(() {
      if (findTaskIndex == -1) {
        tasks.add(newTask);
        return;
      }

      tasks[findTaskIndex] = newTask;
    });

    TaskSql db = TaskSql();

    if (findTaskIndex == -1) {
      db.addNewTask(newTask);
      return;
    }

    db.updateTask(newTask);
  }

  void _handleSwitchActiveFib() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    setState(() {
      isActiveFib = !isActiveFib;
    });
  }

  void _navigateToDetailsCategory(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return DetailsCategoryScreen(
            handleInsertTask: _handleInsertTask,
            category: categories[index],
            tasks: tasks,
            addNewCategory: _addNewCategoryHandler,
            categories: categories,
            handleAddNewTask: _handleAddNewTask,
            handleDeleteTask: _handleDeleteTask,
            handleSwitchActiveTask: _handleSwitchActiveTask,
          );
        },
      ),
    );
  }

  void _navigateToNewCategory() {
    _handleSwitchActiveFib();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return NewCategoryScreen(
            addNewCategory: _addNewCategoryHandler,
          );
        },
      ),
    );
  }

  void _navigateToNewTask() {
    _handleSwitchActiveFib();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return NewTaskScreen(
            categories: categories,
            addNewTask: _handleAddNewTask,
            tasks: tasks,
          );
        },
      ),
    );
  }

  Widget _NewestTodo() {
    if (tasks.length < 1) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 19,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.amberAccent[100],
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(
            "No task for show",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return TaskCard(
          tasks: tasks,
          categories: categories,
          id: tasks[index].id,
          category: tasks[index].category,
          isActive: tasks[index].isActive,
          title: tasks[index].title,
          onTap: () => {_handleSwitchActiveTask(index)},
          onRemoveTask: () => {_handleDeleteTask(index, false)},
          addNewTask: _handleAddNewTask,
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
            physics: NeverScrollableScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              height: 100,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _navigateToDetailsCategory(index);
                },
                child: CategoryCard(
                  color: categories[index].color,
                  title: categories[index].title,
                  lengths: tasks
                      .where((task) => task.category.id == categories[index].id)
                      .length,
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 15,
            ),
          ),
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
                ? GestureDetector(
                    onTap: _handleSwitchActiveFib,
                    child: Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  )
                : Container(),
            isActiveFib
                ? Positioned(
                    child: Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _navigateToNewTask,
                            child: Container(
                              width: 220,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.1),
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 19,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_box,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 13),
                                  ),
                                  Text(
                                    "New Task",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _navigateToNewCategory,
                            child: Container(
                              width: 220,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 19,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 13),
                                  ),
                                  Text(
                                    "New Category",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
