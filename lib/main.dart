import 'package:flutter/material.dart';

import 'package:my_app/api/character_repository.dart';
import 'package:my_app/models/character_page.dart';


void main() => runApp(MyApp(characterPage: fetchCharacters()));

class MyApp extends StatelessWidget {
  final Future<CharacterPage> characterPage;

  MyApp({Key key, this.characterPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty DB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rick And Morty DB'),
        ),
        body: Center(
          child: FutureBuilder<CharacterPage>(
            future: characterPage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.characterList[0].name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}