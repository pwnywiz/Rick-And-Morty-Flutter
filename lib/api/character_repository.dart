import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/models/character_page.dart';

Future<CharacterPage> fetchCharacters() async {
  final response = await http.get('https://rickandmortyapi.com/api/character/');

  if (response.statusCode == 200) {
    return CharacterPage.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
