class Episode {
  String id;
  String name;
  String airDate;

  Episode({this.id, this.name, this.airDate});

  Episode.fromData(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
    this.airDate = data['air_date'];
  }
}