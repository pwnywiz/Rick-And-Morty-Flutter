import 'package:flutter/material.dart';

import 'package:my_app/models/character.dart';

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
          Text(
            character.species,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.cyan.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
