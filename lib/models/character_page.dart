import 'package:my_app/models/character.dart';

class CharacterPage {
  int count;
  int pages;
  String next;
  String prev;
  List<Character> characters;

  CharacterPage(
      {this.count, this.pages, this.next, this.prev, this.characters});

  factory CharacterPage.empty() => CharacterPage(
    count: 0,
    pages: 0,
    next: '',
    prev: '',
    characters: []
  );

  factory CharacterPage.fromJson(Map<String, dynamic> json) => CharacterPage(
        count: json['info']['count'],
        pages: json['info']['pages'],
        next: json['info']['next'],
        prev: json['info']['prev'],
        characters: (json['results'] as List)
            .map((json) => Character.fromJson(json))
            .toList()
      );
}
