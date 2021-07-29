import 'package:flutter/material.dart';
import 'package:my/components/task_card.dart';
import 'package:my/model/category_model.dart';
import 'package:my/model/task_model.dart';
import 'package:my/screens/new_category.dart';
import 'package:my/screens/new_task.dart';

class DetailsCategoryScreen extends StatefulWidget {
  late CategoryModel category;
  late List<CategoryModel> categories;
  late List<TaskModel> tasks;
  late Function(CategoryModel cm) addNewCategory;
  late Function(int index) handleSwitchActiveTask;
  late Function(int index, bool notShowSnackBar) handleDeleteTask;
  late Function(TaskModel task) handleAddNewTask;
  late Function(int index, TaskModel insertedTask) handleInsertTask;

  DetailsCategoryScreen({
    required this.category,
    required this.addNewCategory,
    required this.tasks,
    required this.categories,
    required this.handleSwitchActiveTask,
    required this.handleDeleteTask,
    required this.handleAddNewTask,
    required this.handleInsertTask,
  });

  _DetailsCategoryScreenState createState() => _DetailsCategoryScreenState(
        addNewCategory: addNewCategory,
        categories: categories,
        category: category,
        handleAddNewTask: handleAddNewTask,
        handleDeleteTask: handleDeleteTask,
        handleSwitchActiveTask: handleSwitchActiveTask,
        tasks: tasks,
        handleInsertTask: handleInsertTask,
      );
}

class _DetailsCategoryScreenState extends State<DetailsCategoryScreen> {
  late CategoryModel category;
  late List<CategoryModel> categories;
  late List<TaskModel> tasks;
  late Function(CategoryModel cm) addNewCategory;
  late Function(int index) handleSwitchActiveTask;
  late Function(int index, bool notShowSnackBar) handleDeleteTask;
  late Function(TaskModel task) handleAddNewTask;
  late Function(int index, TaskModel insertedTask) handleInsertTask;

  _DetailsCategoryScreenState({
    required this.category,
    required this.addNewCategory,
    required this.tasks,
    required this.categories,
    required this.handleSwitchActiveTask,
    required this.handleDeleteTask,
    required this.handleAddNewTask,
    required this.handleInsertTask,
  });

  void _handleAddNewTask(TaskModel newTask) {
    setState(() {
      handleAddNewTask(newTask);
    });
  }

  void _addNewCategory(CategoryModel newCategory) {
    setState(() {
      category = newCategory;
      addNewCategory(newCategory);
    });
  }

  void _handleSwitchActiveTask(String id) {
    setState(() {
      var findTaskIndex = tasks.indexWhere((task) => task.id == id);

      handleSwitchActiveTask(findTaskIndex);
    });
  }

  void _handleDeleteTask(int index) async {
    setState(() {
      handleDeleteTask(index, false);
    });
  }

  Widget _AllTodos() {
    List<TaskModel> customTask =
        tasks.where((task) => task.category.id == category.id).toList();

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: customTask.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return TaskCard(
          tasks: customTask,
          categories: categories,
          id: customTask[index].id,
          category: customTask[index].category,
          isActive: customTask[index].isActive,
          title: customTask[index].title,
          onTap: () => {_handleSwitchActiveTask(customTask[index].id)},
          onRemoveTask: () {
            _handleDeleteTask(index);
          },
          addNewTask: (TaskModel newTask) {
            _handleAddNewTask(newTask);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return NewTaskScreen(
                  categories: categories,
                  addNewTask: _handleAddNewTask,
                  tasks: tasks,
                  activeCategoryId: category.id,
                );
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
      appBar: AppBar(
        backgroundColor: category.color,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
            ),
            Text(
              category.title,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return NewCategoryScreen(
                        addNewCategory: _addNewCategory,
                        category: category,
                      );
                    },
                  ),
                );
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          tasks.where((task) => task.category.id == category.id).length >= 1
              ? _AllTodos()
              : Padding(
                  padding: EdgeInsets.only(
                    top: 35,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "No task for show",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
