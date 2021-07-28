import 'package:flutter/material.dart';
import 'package:my/components/category_card.dart';
import 'package:my/components/grid_view_deligate_height.dart';
import 'package:my/model/category_model.dart';
import 'package:my/model/task_model.dart';
import 'package:uuid/uuid.dart';

class NewTaskScreen extends StatefulWidget {
  late TaskModel? task;
  late List<TaskModel> tasks;
  late List<CategoryModel> categories;
  Function(TaskModel cm) addNewTask;

  NewTaskScreen({
    required this.categories,
    required this.addNewTask,
    required this.tasks,
    this.task,
  });

  _NewTaskScreenState createState() => _NewTaskScreenState(
        categories: categories,
        task: task,
        addNewTask: addNewTask,
        tasks: tasks,
      );
}

class _NewTaskScreenState extends State {
  late TaskModel? task;
  late List<CategoryModel> categories;
  late List<TaskModel> tasks;
  Function(TaskModel cm) addNewTask;

  String activeCategoryId = '';
  String description = '';

  _NewTaskScreenState({
    this.task,
    required this.categories,
    required this.addNewTask,
    required this.tasks,
  }) {
    if (task == null) {
      return;
    }

    description = task!.title;
    activeCategoryId = task!.category.id;
  }

  void _handleActiveCategory(int index) {
    setState(() {
      activeCategoryId = categories[index].id;
    });
  }

  void _handleChagneDescriptionTask(String newValue) {
    setState(() {
      description = newValue;
    });
  }

  _runSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.bug_report_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddCategoroy() {
    if (description.trim() == '') {
      _runSnackBar('write description task');
      return;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (activeCategoryId == '') {
      _runSnackBar('select category task');
      return;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    var findCategory = categories.where((c) => c.id == activeCategoryId);

    if (findCategory.isEmpty) return;

    CategoryModel activeCategory = findCategory.first;

    var uuid = Uuid();
    String id = uuid.v4();

    bool isActiveTask = false;

    if (task != null) {
      id = task!.id;
      isActiveTask = task!.isActive;
    }

    TaskModel newCategory = TaskModel(
      id: id,
      title: description,
      isActive: isActiveTask,
      category: activeCategory,
    );

    addNewTask(newCategory);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                "New Task",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 15,
              ),
              child: GestureDetector(
                onTap: () {
                  _handleAddCategoroy();
                },
                child: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: 18,
          ),
          child: ListView(
            children: [
              TextField(
                controller: TextEditingController(
                  text: description,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 8,
                maxLines: 8,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  hintText: 'Write your description task ...',
                ),
                onChanged: _handleChagneDescriptionTask,
                cursorColor: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 25,
                ),
              ),
              GridView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  height: 100,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _handleActiveCategory(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: activeCategoryId == categories[index].id
                            ? Border.all(
                                width: 5,
                                color: Colors.blue,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CategoryCard(
                        color: categories[index].color,
                        title: categories[index].title,
                        lengths: tasks
                            .where((task) =>
                                task.category.id == categories[index].id)
                            .length,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
