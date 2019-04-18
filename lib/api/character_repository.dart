import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/models/character_page.dart';

class CharacterAPI {
  Future<CharacterPage> fetchCharacters(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return CharacterPage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}