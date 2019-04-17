class Character {
  final int id;
  final String name;
  final String species;
  final String image;

  Character({this.id, this.name, this.species, this.image});

  factory Character.fromJson(Map<String, dynamic> json) =>
    Character(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      image: json['image'],
    );
}