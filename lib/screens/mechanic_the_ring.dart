import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

const double ringLevelHeight = 90;
const double ringLevelWidth = 300;
const Color temptingColorActive = Colors.amberAccent;
const Color temptingColorInactive = Colors.grey;
const double borderRadius = 8.0;

const List<String> abilities = [
  'Your Ring-bearer is legendary and can’t be blocked by creatures with greater power.',
  'Whenever your Ring-bearer attacks, draw a card, then discard a card.',
  'Whenever your Ring-bearer becomes blocked by a creature, that creature’s controller sacrifices it at end of combat.',
  'Whenever your Ring-bearer deals combat damage to a player, each opponent loses 3 life.'
];

const List<String> rulings = [
  'As the Ring tempts you, you get an emblem named The Ring if you don’t have one. Then your emblem gains its next ability and you choose a creature you control to become or remain your Ring-bearer.',
  '• The Ring can tempt you even if you don’t control a creature.',
  '• The Ring gains its abilities in order from top to bottom. Once it gains an ability, it has that ability for the rest of the game.',
  '• Each time the Ring tempts you, you must choose a creature if you control one.',
  '• Each player can have only one emblem named The Ring and only one Ring-bearer at a time.'
];

class TheRing extends StatelessWidget {
  const TheRing({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.lightBlueAccent,
            Colors.deepPurpleAccent,
            Colors.greenAccent
          ],
        ),
      ),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: MechanicTheRing(
          key: ValueKey<String>('unique_key_for_The_Ring'),
          title: 'The Ring',
        ),
      ),
    );
  }
}

class MechanicTheRing extends StatefulWidget {
  const MechanicTheRing({required Key key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<MechanicTheRing> createState() => _MechanicTheRingState();
}

class _MechanicTheRingState extends State<MechanicTheRing> {
  int ringLevel = 0;

  @override
  void initState() {
    super.initState();
    // Enable wakelock when entering the screen
    Wakelock.enable();
  }

  @override
  void dispose() {
    // Disable wakelock when leaving the screen
    Wakelock.disable();
    super.dispose();
  }

  void _incrementRingLevel() {
    setState(() {
      if (ringLevel < 3) {
        ringLevel++;
      } else {
        ringLevel = 0;
      }
    });
  }

  void _decrementRingLevel() {
    setState(() {
      if (ringLevel > 0) {
        ringLevel--;
      } else {
        ringLevel = 3;
      }
    });
  }

  Color _getTextColor(int index) {
    return ringLevel >= index ? temptingColorActive : temptingColorInactive;
  }

  void _showRulingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Rulings For\nThe Ring",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildRulingsWithSpacing(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildRulingsWithSpacing() {
    List<Widget> widgets = [];

    for (var i = 0; i < rulings.length; i++) {
      widgets.add(
        Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          child: Text(
            rulings[i],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
      widgets.add(SizedBox(height: i == 0 ? 10 : 5));
    }

    if (widgets.isNotEmpty) {
      widgets.removeLast();
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("The Ring"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _incrementRingLevel,
              onLongPress: _decrementRingLevel,
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(abilities.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          height: ringLevelHeight,
                          width: ringLevelWidth,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(borderRadius)),
                          ),
                          child: Center(
                            child: Text(
                              abilities[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _getTextColor(index),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _showRulingsDialog(context);
              },
              child: Container(
                height: 50.0,
                width: 150.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
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
                    'Show Rulings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50.0,
                width: 150.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
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
            )

          ],
        ),
      ),
    );
  }
}
