import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

import 'package:my_app/models/character.dart';
import 'package:my_app/blocs/character_bloc.dart';
import 'package:my_app/components/details_page.dart';
import 'package:my_app/models/character_page.dart';

class ListPage extends StatelessWidget {
  final CharacterBloc bloc;

  ListPage({Key key, @required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.results,
        builder: (BuildContext context, AsyncSnapshot<CharacterPage> snapshot) {
          print('Building again');
          final List<Character> characters = snapshot?.data?.characters;

          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return DisplayCharacters(bloc: bloc, characters: characters, next: snapshot.data.next);
        });
  }
}

class DisplayCharacters extends StatelessWidget {
  final String next;
  final List<Character> characters;
  final CharacterBloc bloc;

  DisplayCharacters({Key key, @required this.bloc, @required this.characters, @required this.next}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length + 1,
      itemBuilder: (BuildContext context, int index) {
        print(index);

        if (index >= (characters.length) && next.isNotEmpty) {
          print('Reached the ${index}th element');
          bloc.pageUrl.add(next);
          return Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: CircularProgressIndicator(),
          ));
        }

        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        character: characters[index],
                      ))),
          child: Hero(
            tag: characters[index].id,
            child: FadeInImage.memoryNetwork(
              height: 400.0,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(seconds: 0),
              placeholder: kTransparentImage,
              image: characters[index].image,
            ),
          ),
        );
      },
    );
  }
}
