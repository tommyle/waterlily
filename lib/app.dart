import 'package:flutter/material.dart';
import './modules/plants/plants_provider.dart';
import './modules/plants/plants_list_screen.dart';

var images = [
  AssetImage("assets/lemonlime.jpg"),
  AssetImage("assets/aloe.jpg")
];

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlantsProvider(PlantsBloc(), PlantDetailsBloc(),
        child: MaterialApp(home: PlantsListScreen()));
  }
}
