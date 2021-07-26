import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my/constants.dart';

class TaskCard extends StatelessWidget {
  late bool _isActive;
  late Color _categoryColor;
  late String _title;
  late void Function() _onTap;
  late void Function() _onRemoveTask;

  TaskCard({
    required bool isActive,
    required Color categoryColor,
    required String title,
    required void Function() onTap,
    required void Function() onRemoveTask,
  }) {
    this._isActive = isActive;
    this._categoryColor = categoryColor;
    this._title = title;
    this._onTap = onTap;
    this._onRemoveTask = onRemoveTask;
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
                            color: this._categoryColor,
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
          caption: 'Delete',
          color: Colors.red[400],
          icon: Icons.delete,
          onTap: _onRemoveTask,
        ),
      ],
    );
  }
}
