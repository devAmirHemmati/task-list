import 'package:my/model/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategorySql {
  static String tableName = 'category';
  static Map<String, String> tableColumn = {
    'id': '_id',
    'title': 'title',
    'color': 'color',
  };
  late Database db;

  Future open() async {
    db = await openDatabase(
      'todo_list_hemmati_category_table_app.db',
      version: 1,
      onCreate: (
        Database db,
        int version,
      ) async {
        await db.execute('''
          create table ${CategorySql.tableName} ( 
            ${CategorySql.tableColumn["id"]} text not null, 
            ${CategorySql.tableColumn["title"]} text not null,
            ${CategorySql.tableColumn["color"]} text not null
          )
        ''');
      },
    );
  }

  Future close() async => db.close();

  Future<List<CategoryModel>> getAllCategories() async {
    await this.open();

    List<CategoryModel> customCategories = [];

    try {
      List<Map<String, dynamic>> categories =
          await this.db.query(CategorySql.tableName);

      categories.forEach((category) {
        customCategories.add(CategoryModel(
          id: category[tableColumn['id']],
          title: category[tableColumn['title']],
          color: category[tableColumn['color']],
        ));
      });
    } catch (error) {}

    await this.close();

    return customCategories.toList();
  }

  Future<void> addNewCategory(
    CategoryModel newCategory,
  ) async {
    await this.open();

    await this.db.insert(
          CategorySql.tableName,
          newCategory.toMap(),
        );

    await this.close();
  }

  Future<void> updateCategory(
    CategoryModel updatedCategory,
  ) async {
    await this.open();

    this.db.update(
      CategorySql.tableName,
      updatedCategory.toMap(),
      where: '_id = ?',
      whereArgs: [updatedCategory.id],
    );

    await this.close();
  }
}
