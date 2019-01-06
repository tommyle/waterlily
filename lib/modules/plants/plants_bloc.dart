import 'package:rxdart/rxdart.dart';
import '../../models/plant.dart';

export '../../models/plant.dart';

class PlantsBloc {
  var _plants = List<Plant>();

  //What is the difference between BehaviorSubject vs PublishSubject vs StreamController?
  final _plantsController = BehaviorSubject<List<Plant>>();

  // Getters to Streams
  Observable<List<Plant>> get plants => _plantsController.stream;

  // Sinks - puts stuff into the stream
  getPlants() {
    if (_plants.length == 0) {
      _plants = _fetchPlants();
      _plantsController.sink.add(_plants);
    }
  }

  // Pressing a button should add a new plant?
  addPlant(String name, String location, String imagePath) {
    final plant = Plant(name, location, imagePath);

    _plants.add(plant);
    _plantsController.sink.add(_plants);
  }

  dispose() {
    _plantsController.close();
  }

  List<Plant> _fetchPlants() {
    final plants = List<Plant>.generate(
        5, (i) => Plant("Tommy's Plant $i", "Kitchen", "assets/lemonlime.jpg"));

    return plants;
  }
}
