import 'package:rxdart/rxdart.dart';

class PlantDetailsBloc {
  final _nameController = BehaviorSubject<String>();
  final _locationController = BehaviorSubject<String>();
  final _wateringFrequency = BehaviorSubject<String>();

  // Getters to Streams. What is the difference between Stream and Observable? Observable returns a future?
  Stream<String> get name => _nameController.stream;
  Stream<String> get location => _locationController.stream;
  Stream<String> get wateringFrequency => _wateringFrequency.stream;

  // Value gettings
  String get nameValue => _nameController.value;
  String get locationValue => _locationController.value;
  String get wateringFrequencyValue => _wateringFrequency.value;

  // Sinks - puts stuff into the stream
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLocation => _locationController.sink.add;
  Function(String) get changeWateringFrequency => _wateringFrequency.sink.add;

  dispose() {
    _nameController.close();
    _locationController.close();
    _wateringFrequency.close();
  }
}
