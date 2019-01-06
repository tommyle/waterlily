import 'package:flutter/material.dart';
import 'plants_bloc.dart';

export 'plants_bloc.dart';

class PlantsProvider extends InheritedWidget {
  final PlantsBloc bloc;

  PlantsProvider({Key key, Widget child}): bloc = PlantsBloc(), super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static PlantsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PlantsProvider) as PlantsProvider).bloc;
  }
}