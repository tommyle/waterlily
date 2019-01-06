import 'package:flutter/material.dart';
import './modules/plants/plants_provider.dart';
import './modules/plants/plants_list.dart';
import './helpers/colors.dart';

var images = [
  AssetImage("assets/lemonlime.jpg"),
  AssetImage("assets/aloe.jpg")
];

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlantsProvider(
      child: MaterialApp(
          home: Scaffold(
        appBar: _buildAppBar(),
        body: PlantsList(),
        backgroundColor: springWood,
      )),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        "Water Lily",
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      brightness: Brightness.light, //Status bar text color
      elevation: 1,
      backgroundColor: desertStorm,
    );
  }
}
