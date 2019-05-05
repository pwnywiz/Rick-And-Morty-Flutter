import 'package:flutter/material.dart';

import 'package:my_app/api/character_repository.dart';
import 'package:my_app/blocs/character_bloc.dart';
import 'package:my_app/components/list_page.dart';
import 'package:my_app/providers/base_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<CharacterBloc>(
      bloc: CharacterBloc(
        CharacterAPI(),
      ),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final CharacterBloc characterBloc = Provider.of<CharacterBloc>(context);

    _scrollController.addListener(() {
      ScrollPosition scrollPosition = _scrollController.position;
      if (scrollPosition.pixels == scrollPosition.maxScrollExtent) {
        print(_scrollController.position.pixels);
        characterBloc.pageUrl
            .add('https://rickandmortyapi.com/api/character/2');
      }
    });

    return MaterialApp(
      title: 'Rick And Morty DB',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text('Rick And Morty DB',
                    style: TextStyle(color: Colors.white))),
          ),
          body: ListPage(
            bloc: characterBloc,
            scrollController: _scrollController,
          )),
    );
  }
}
