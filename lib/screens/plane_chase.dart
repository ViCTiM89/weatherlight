import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:weatherlight/widgets/dice_roll_widget.dart';
import 'dart:math';

import '../model/planes.dart';
import '../services/planes_api.dart';

class PlaneChase extends StatefulWidget {
  const PlaneChase({required Key key}) : super(key: key);

  @override
  State<PlaneChase> createState() => _PlaneChaseState();
}

class _PlaneChaseState extends State<PlaneChase> {
  int diceRoll = 0;
  String? currentImageUrl;

  @override
  void initState() {
    super.initState();
    // Enable wakelock when entering the screen
    Wakelock.enable();
    fetchPlanes();
  }

  @override
  void dispose() {
    // Disable wakelock when leaving the screen
    Wakelock.disable();
    super.dispose();
  }

  Widget _buildUnderConstructionWidget() {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (planes.isNotEmpty) {
            final randomIndex = Random().nextInt(planes.length);
            final randomPlane = planes[randomIndex];
            currentImageUrl = randomPlane.imageUris?.large ??
                randomPlane.cardFaces![0].imageUris.large;
          }
        });
      },
      child: Container(
        height: 500,
        width: 350,
        decoration: const BoxDecoration(
          color: Colors.transparent, // Make the background transparent
        ),
        child: Center(
          child: currentImageUrl == null
              ? Image.asset('images/wastes.jpg', fit: BoxFit.cover)
              : Image.network(
                  currentImageUrl!,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  void _showPlanesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Planes: ${planes.length}'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: planes.length,
              itemBuilder: (context, index) {
                final dungeon = planes[index];
                final name = dungeon.name;
                final typeLine = dungeon.typeLine;
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(name),
                  subtitle: Text(typeLine),
                  onLongPress: () {
                    setState(() {
                      currentImageUrl = dungeon.imageUris?.large ??
                          dungeon.cardFaces![0].imageUris.large;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Plane Chase"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.blue, Colors.red, Colors.green],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildUnderConstructionWidget(),
              const SizedBox(height: 20),
              const DiceRollWidget(
                diceLength: 100,
                offsetRight: 55,
                offsetBottom: 55,
                diceColor: Colors.white,
                diceBorder: Colors.black,
                eyeColor: Colors.black,
                rollCount: 5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showPlanesDialog(context),
                child: const Text('Planes'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  List<Plane> planes = [];

  Future<void> fetchPlanes() async {
    final response = await PlanesApi.fetchPlanes();
    setState(
      () {
        planes = response;
      },
    );
  }
}
