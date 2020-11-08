class Character {
  String id;
  String name;
  String imageURL;
  String species;

  Character({this.id, this.name, this.imageURL, this.species});

  Character.fromData(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
    this.imageURL = data['image'];
    this.species = data['species'];
  }
}