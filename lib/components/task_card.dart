import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my/constants.dart';
import 'package:my/model/category_model.dart';
import 'package:my/model/task_model.dart';
import 'package:my/screens/new_task.dart';

class TaskCard extends StatelessWidget {
  late String _id;
  late bool _isActive;
  late CategoryModel _category;
  late String _title;
  late void Function() _onTap;
  late void Function() _onRemoveTask;
  late void Function(TaskModel cm) _addNewTask;
  late List<TaskModel> _tasks = [];
  late List<CategoryModel> _categories = [];

  TaskCard({
    required String id,
    required bool isActive,
    required CategoryModel category,
    required String title,
    required List<TaskModel> tasks,
    required List<CategoryModel> categories,
    required void Function() onTap,
    required void Function() onRemoveTask,
    required void Function(TaskModel cm) addNewTask,
  }) {
    this._id = id;
    this._isActive = isActive;
    this._category = category;
    this._title = title;
    this._onTap = onTap;
    this._onRemoveTask = onRemoveTask;
    this._addNewTask = addNewTask;
    this._tasks = tasks;
    this._categories = categories;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Column(
              children: [
                Container(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor(
                                    THEME_COLORS['secondary-1'],
                                  ),
                                  width: 1,
                                ),
                                shape: BoxShape.circle,
                                color: this._isActive
                                    ? HexColor(THEME_COLORS['primary-1'])
                                    : Colors.white,
                              ),
                              child: this._isActive
                                  ? Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    )
                                  : null,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 18,
                              ),
                            ),
                            Container(
                              width: screenSize.width / 1.4,
                              child: RichText(
                                maxLines: 1,
                                text: TextSpan(
                                  text: this._title,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: this._category.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: HexColor(
                            THEME_COLORS['secondary-1'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onTap: _onTap,
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return NewTaskScreen(
                    categories: _categories,
                    tasks: _tasks,
                    task: TaskModel(
                      id: this._id,
                      title: this._title,
                      isActive: this._isActive,
                      category: this._category,
                    ),
                    addNewTask: _addNewTask,
                  );
                },
              ),
            );
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red[400],
          icon: Icons.delete,
          onTap: _onRemoveTask,
        ),
      ],
    );
  }
}
