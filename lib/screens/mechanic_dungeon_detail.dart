import 'package:flutter/material.dart';
import 'package:weatherlight/model/cards.dart';

import '../constants.dart';
import '../widgets/app_bar_widget.dart';

class DungeonDetail extends StatefulWidget {
  final FetchedCards dungeon;

  const DungeonDetail({
    Key? key,
    required this.dungeon,
  }) : super(key: key);

  @override
  State<DungeonDetail> createState() => _DungeonDetailState();
}

class _DungeonDetailState extends State<DungeonDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const SharedAppBar(
          backgroundColor: appBarColor,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(20),
                      minScale: 0.5,
                      maxScale: 3,
                      child: Image.network(
                        widget.dungeon.imageUris?.large ??
                            widget.dungeon.cardFaces![0].imageUris.large,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Go back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
