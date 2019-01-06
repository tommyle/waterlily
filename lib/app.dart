import 'package:flutter/material.dart';
import './modules/plants/plants_provider.dart';
import './modules/plants/plants_list.dart';

final desertStorm = const Color(0xFFF9F9F8);
final springWood = const Color(0xFFF6F5F1);

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
          title: 'Water Lily',
          home: Scaffold(
            body: PlantsList(),
          )),
    );
  }
}