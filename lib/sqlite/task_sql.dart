import 'package:my/model/category_model.dart';
import 'package:my/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class TaskSql {
  static String tableName = 'tasks';
  static Map<String, String> tableColumn = {
    'id': '_id',
    'title': 'title',
    'is_active': 'is_active',
    'category_id': 'category_id',
  };

  late Database db;

  Future open() async {
    db = await openDatabase(
      'task_list_ba0cbe7a_f081_11eb_9a03_0242ac130004.db',
      version: 1,
      onCreate: (
        Database db,
        int version,
      ) async {
        await db.execute(
          '''
          create table ${TaskSql.tableName} ( 
            _id text not null, 
            title text not null,
            is_active integer not null,
            category_id text not null
          )
        ''',
        );
      },
    );
  }

  Future close() async => db.close();

  Future<List<TaskModel>> getAllTasks(List<CategoryModel> categories) async {
    await this.open();

    List<TaskModel> customTasks = [];

    try {
      List<Map<String, dynamic>> tasks = await this.db.query(TaskSql.tableName);

      tasks.forEach((task) {
        int selectTaskCategory = categories
            .indexWhere((category) => category.id == task['category_id']);

        if (selectTaskCategory == -1) return;

        customTasks.add(TaskModel(
          id: task['_id'],
          title: task['title'],
          isActive: task[tableColumn['is_active']] == 1 ? true : false,
          category: categories[selectTaskCategory],
        ));
      });
    } catch (error) {}

    print(customTasks);

    await this.close();

    return customTasks.toList();
  }

  Future<void> addNewTask(TaskModel task) async {
    await this.open();

    await this.db.insert(
          TaskSql.tableName,
          task.toMap(),
        );

    await this.close();
  }

  Future<void> updateTask(
    TaskModel updateTask,
  ) async {
    await this.open();

    this.db.update(
      TaskSql.tableName,
      updateTask.toMap(),
      where: '_id = ?',
      whereArgs: [updateTask.id],
    );

    await this.close();
  }

  Future<void> deleteTask(
    String taskId,
  ) async {
    await this.open();

    this.db.delete(
      TaskSql.tableName,
      where: '_id = ?',
      whereArgs: [taskId],
    );

    await this.close();
  }
}
