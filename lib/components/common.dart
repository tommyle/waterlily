import 'package:flutter/material.dart';
import '../helpers/colors.dart';

Widget defaultAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      brightness: Brightness.light, //Status bar text color
      elevation: 1,
      backgroundColor: desertStorm,
      iconTheme: IconThemeData(
            color: Colors.black87, //change your color here
          ),
    );
  }