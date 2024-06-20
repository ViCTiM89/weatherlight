import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:weatherlight/widgets/dice_roll_widget.dart';
import 'dart:math';

import '../model/cards.dart';
import '../services/card_api.dart';

class PlaneChase extends StatefulWidget {
  final String apiUrl;

  const PlaneChase({required this.apiUrl, Key? key}) : super(key: key);

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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double planeHeight = screenHeight / 1.5;
    double planeWidth = screenWidth;

    return GestureDetector(
      onLongPress: () {
        setState(
          () {
            if (planes.isNotEmpty) {
              final randomIndex = Random().nextInt(planes.length);
              final randomPlane = planes[randomIndex];
              currentImageUrl = randomPlane.imageUris?.large ??
                  randomPlane.cardFaces![0].imageUris.large;
            }
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: planeHeight,
          width: planeWidth,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(
            child: currentImageUrl == null
                ? Image.asset('images/planechase.jpg', fit: BoxFit.cover)
                : Image.network(
                    currentImageUrl!,
                    fit: BoxFit.cover,
                  ),
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
                final plane = planes[index];
                final name = plane.name;
                final typeLine = plane.typeLine;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(typeLine),
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Colors.blueAccent,
                  ),
                  onLongPress: () {
                    setState(
                      () {
                        currentImageUrl = plane.imageUris?.large ??
                            plane.cardFaces![0].imageUris.large;
                      },
                    );
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;

    double length = screenHeight / 7;
    double offSet = screenHeight / 12;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.lightBlueAccent,
            Colors.deepPurpleAccent,
            Colors.greenAccent,
          ],
        ),
      ),
      child: Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Plane Chase"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildUnderConstructionWidget(),
              const SizedBox(height: 20),
              DiceRollWidget(
                diceLength: length,
                offsetRight: offSet,
                offsetBottom: offSet,
                diceColor: Colors.white,
                diceBorder: Colors.black,
                eyeColor: Colors.black,
                rollCount: 5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showPlanesDialog(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Show Planes'),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  List<FetchedCards> planes = [];

  Future<void> fetchPlanes() async {
    final response = await CardApi.fetchCards(widget.apiUrl);
    setState(
      () {
        planes = response;
      },
    );
  }
}
