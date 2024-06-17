import 'package:flutter/material.dart';
import 'package:weatherlight/model/dungeons.dart';

class DungeonDetail extends StatelessWidget {
  final Dungeon dungeon;
  const DungeonDetail({
    Key? key,
    required this.dungeon,
  }) : super(key: key);

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
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Make the background transparent
                ),
                child: ListTile(
                  title: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(20),
                      minScale: 0.5,
                      maxScale: 3,
                      child: Image.network(
                        dungeon.imageUris?.large ??
                            dungeon.cardFaces![0].imageUris.large,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Go back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
