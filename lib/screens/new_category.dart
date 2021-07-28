import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my/model/category_model.dart';
import 'package:uuid/uuid.dart';

class NewCategoryScreen extends StatefulWidget {
  Function(CategoryModel cm) addNewCategory;
  CategoryModel? category;

  NewCategoryScreen({
    required this.addNewCategory,
    this.category,
  });

  _NewCategoryScreenState createState() => _NewCategoryScreenState(
      addNewCategory: addNewCategory, category: category);
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  String categoryName = '';
  Color color = HexColor("#20bf6b");
  CategoryModel? category;
  Function(CategoryModel cm) addNewCategory;

  _NewCategoryScreenState({
    required this.addNewCategory,
    this.category,
  });

  void _handleSetColor(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  void _handleSetValue(String newValue) {
    setState(() {
      categoryName = newValue;
    });
  }

  void _handleAddCategoroy() {
    if (categoryName.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "write category name",
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
      return;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    var uuid = Uuid();
    String id = uuid.v4();

    CategoryModel newCategory = CategoryModel(
      id: id,
      color: color,
      title: categoryName,
    );

    addNewCategory(newCategory);

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
          backgroundColor: color,
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
                "New Category",
                style: TextStyle(
                  color: Colors.white,
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
                onTap: _handleAddCategoroy,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 15,
                ),
              ),
              Text(
                "You'r category name:",
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
              ),
              TextField(
                onChanged: _handleSetValue,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  hintText: "category name",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _handleSetColor(HexColor("#20bf6b"));
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: HexColor("#20bf6b"),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleSetColor(HexColor("#F45E6D"));
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: HexColor("#F45E6D"),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleSetColor(HexColor("#f7b731"));
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: HexColor("#f7b731"),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleSetColor(HexColor("#4b7bec"));
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: HexColor("#4b7bec"),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleSetColor(HexColor("#4b6584"));
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: HexColor("#4b6584"),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
