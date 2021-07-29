import 'package:flutter/material.dart';
import 'package:my/constants.dart';
import 'package:my/model/category_model.dart';
import 'package:my/model/task_model.dart';
import 'package:my/screens/home.dart';
import 'package:my/sqlite/category_sql.dart';
import 'package:my/sqlite/task_sql.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<CategoryModel> categories = [];
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();

    _initStateHandlers();
  }

  Future<void> _initStateHandlers() async {
    List<CategoryModel> sqlCategroies = await _getAllCategroiesFromDatabase();
    List<TaskModel> sqlTasks = await _getAllTasksFromDatabase(sqlCategroies);

    setState(() {
      categories = sqlCategroies;
      tasks = sqlTasks;
    });

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen(
              categories: categories,
              tasks: tasks,
            );
          },
        ),
      );
    });
  }

  Future<List<CategoryModel>> _getAllCategroiesFromDatabase() async {
    CategorySql categoryDb = CategorySql();

    List<CategoryModel> categories = await categoryDb.getAllCategories();

    return categories;
  }

  Future<List<TaskModel>> _getAllTasksFromDatabase(
      List<CategoryModel> sqlCategroies) async {
    TaskSql taskDb = TaskSql();

    List<TaskModel> tasks = await taskDb.getAllTasks(sqlCategroies);

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/icon.jpg'),
                width: 150,
                height: 150,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    " TODO",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Color(THEME_COLORS['pink-1']),
                    ),
                  ),
                  Text(
                    "List",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Color(THEME_COLORS['pink-2']),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              CircularProgressIndicator(
                color: Color(THEME_COLORS['pink-1']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
