import 'package:flutter/material.dart';
import 'plant_details_bloc.dart';

export 'plant_details_bloc.dart';

class PlantDetailsProvider extends InheritedWidget {
  final PlantDetailsBloc bloc;

  PlantDetailsProvider({Key key, Widget child}): bloc = PlantDetailsBloc(), super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static PlantDetailsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PlantDetailsProvider) as PlantDetailsProvider).bloc;
  }
}