class Location {
  String id;
  String name;
  String type;

  Location({this.id, this.name, this.type});

  Location.fromData(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
    this.type = data['type'];
  }
}