import 'package:flutter/material.dart';

import 'package:my_app/api/character_repository.dart';
import 'package:my_app/models/character.dart';
import 'package:my_app/models/character_page.dart';

void main() => runApp(MyApp(characterAPI: CharacterAPI()));

class MyApp extends StatefulWidget {
  final CharacterAPI characterAPI;

  MyApp({Key key, this.characterAPI}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScrollController _scrollController = ScrollController();
  List<Character> characters = [];
  CharacterPage characterPage;

  @override
  void initState() {
    super.initState();
    fetchData('https://rickandmortyapi.com/api/character/');

    _scrollController.addListener(() {
      ScrollPosition scrollPosition = _scrollController.position;
      if (scrollPosition.pixels == scrollPosition.maxScrollExtent) {
        print(_scrollController.position.pixels);
        fetchData(characterPage.next);
        print('Fetched $characterPage');
      }
    });
  }

  void fetchData(String url) async {
    characterPage = await widget.characterAPI.fetchCharacters(url);
    setState(() {
      characters.addAll(characterPage.characterList);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty DB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Rick And Morty DB')),
          ),
          body: _createListView()),
    );
  }

  Widget _createListView() {
    return ListView.builder(
      itemCount: characters.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Hero(
            tag: characters[index].name,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPage(
                            character: characters[index],
                          ))),
              child: Container(
                child: Image.network(
                  characters[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ));
      },
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Character character;

  DetailsPage({Key key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: character.name,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                    radius: 200,
                  ),
                ),
              )
            ],
          ),
          Text(
            character.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6),
                height: 5.0,
                fontSize: 25),
          ),
          Text(character.species, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.cyan.withOpacity(0.8)),),
        ],
      ),
    );
  }
}
