import 'dart:io';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  Future<bool> _handleWillPop() async {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "TODO List",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            color: Colors.black38,
          ),
        ),
      ),
      onWillPop: _handleWillPop,
    );
  }
}
