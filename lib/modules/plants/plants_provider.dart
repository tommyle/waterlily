import 'package:flutter/material.dart';

import '../plant_details/plant_details_bloc.dart';
import 'plants_bloc.dart';

export 'plants_bloc.dart';
export '../plant_details/plant_details_bloc.dart';

class PlantsProvider extends InheritedWidget {
  final PlantsBloc plantsBloc;
  final PlantDetailsBloc plantDetailsBloc;

  PlantsProvider(this.plantsBloc, this.plantDetailsBloc, {Key key, Widget child}): super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  addNewPlant() {
    final name = plantDetailsBloc.nameValue ?? "No Name";
    final location = plantDetailsBloc.locationValue ?? "No Location";
    // final wateringFrequency = plantDetailsBloc.wateringFrequencyValue;

    plantsBloc.addPlant(name, location, "assets/aloe.jpg");
    // plantsBloc.addPlant("Justine's Plant", "Living Room", "assets/aloe.jpg");
  }

  static PlantsProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PlantsProvider) as PlantsProvider);
  }
}