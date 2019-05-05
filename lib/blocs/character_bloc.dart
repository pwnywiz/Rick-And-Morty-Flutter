import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:my_app/models/character_page.dart';
import 'package:my_app/api/character_repository.dart';

final String _fetchUrl = 'https://rickandmortyapi.com/api/character/';

class CharacterBloc {
  final CharacterAPI characterApi;
  CharacterPage _characterPage = CharacterPage.empty();

  Stream<CharacterPage> _results = Stream.empty();

  BehaviorSubject<String> _pageUrl = BehaviorSubject<String>.seeded(_fetchUrl);

  Stream<CharacterPage> get results => _results;

  Sink<String> get pageUrl => _pageUrl;

  CharacterBloc(this.characterApi) {
    _characterPage = CharacterPage.empty();
    _results = _pageUrl.asyncMap(characterApi.fetchCharacters).map(mergeResults);
  }

  CharacterPage mergeResults(CharacterPage latest) {
    _characterPage.characters.addAll(latest.characters);
    _characterPage.next = latest.next;

    return _characterPage;
  }

  void dispose() {
    _pageUrl.close();
  }
}
