class Plant extends Object {
  final String name;
  final String location;
  final String imagePath;
  String watering;
  String feeding;

  Plant(this.name, this.location, this.imagePath);

  Plant.fromJSON(Map<String, dynamic> json)
    : name = json['name'],
      location = json['location'],
      imagePath = json['imagePath'];
}