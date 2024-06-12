import 'package:flutter/material.dart';
import 'package:weatherlight/model/dungeons.dart';

class DungeonDetail extends StatelessWidget {
  final Dungeon dungeon;
  const DungeonDetail({super.key,
    required this.dungeon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.white, Colors.blue, Colors.red, Colors.green],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(dungeon.name),
        ),
        body: SingleChildScrollView(
          child: Card(
              child: Column(
            children: <Widget>[
              ListTile(
                title: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(dungeon.imageUris?.large ??
                      dungeon.cardFaces![0].imageUris.large
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
