// import 'package:flutter/material.dart';

// import 'package:my_app/api/character_repository.dart';
// import 'package:my_app/components/list_page.dart';
// import 'package:my_app/models/character.dart';
// import 'package:my_app/models/character_page.dart';

// void main() => runApp(MyApp(characterAPI: CharacterAPI()));

// class MyApp extends StatefulWidget {
//   final CharacterAPI characterAPI;

//   MyApp({Key key, this.characterAPI}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   ScrollController _scrollController = ScrollController();
//   List<Character> characters = [];
//   CharacterPage characterPage;

//   @override
//   void initState() {
//     super.initState();
//     fetchData('https://rickandmortyapi.com/api/character/');

//     _scrollController.addListener(() {
//       ScrollPosition scrollPosition = _scrollController.position;
//       if (scrollPosition.pixels == scrollPosition.maxScrollExtent) {
//         print(_scrollController.position.pixels);
//         fetchData(characterPage.next);
//         print('Fetched $characterPage');
//       }
//     });
//   }

//   void fetchData(String url) async {
//     characterPage = await widget.characterAPI.fetchCharacters(url);
//     setState(() {
//       characters.addAll(characterPage.characterList);
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Rick And Morty DB',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//           appBar: AppBar(
//             title: Center(child: Text('Rick And Morty DB')),
//           ),
//           body: ListPage(
//             characters: characters,
//             scrollController: _scrollController,
//           )),
//     );
//   }
// }
