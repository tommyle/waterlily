import 'package:rxdart/rxdart.dart';

class PlantDetailsBloc {
  final _nameController = BehaviorSubject<String>();
  final _locationController = BehaviorSubject<String>();
  final _wateringSchedule = BehaviorSubject<int>();
  final _wateringFrequency = BehaviorSubject<int>();

  // Getters to Streams. What is the difference between Stream and Observable? Observable returns a future?
  Stream<String> get name => _nameController.stream;
  Stream<String> get location => _locationController.stream;
  Stream<int> get wateringSchedule => _wateringSchedule.stream;
  Stream<int> get wateringFrequency => _wateringFrequency.stream; 
  
  Stream<String> get getWateringScheduleAndFrequency => Observable.combineLatest2(wateringSchedule, wateringFrequency, (wateringSchedule, wateringFrequency){
    String schedule = 'days';
    if (wateringSchedule == 1) {
      schedule = 'weeks';
    }
    else if (wateringSchedule == 2) {
      schedule = 'months';
    }

    return 'Every $wateringFrequency $schedule';
  });

  // Value gettings
  String get nameValue => _nameController.value;
  String get locationValue => _locationController.value;
  int get wateringScheduleValue => _wateringSchedule.value;
  int get wateringFrequencyValue => _wateringFrequency.value;

  // Sinks - puts stuff into the stream
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLocation => _locationController.sink.add;
  Function(int) get changeWateringSchedule => _wateringSchedule.sink.add;
  Function(int) get changeWateringFrequency => _wateringFrequency.sink.add;

  dispose() {
    _nameController.close();
    _locationController.close();
    _wateringSchedule.close();
    _wateringFrequency.close();
  }
}
