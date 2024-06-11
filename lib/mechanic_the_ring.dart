import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

const double ringLeveHeight = 90;
const double ringLevelWidth = 300;
const Color temptingColorActive = Colors.white;
const Color temptingColorInactive = Colors.grey;
const double borderRadius = 8.0;

const List<String> abilities = [
  'Your Ring-bearer is legendary and can’t be blocked by creatures with greater power.',
  'Whenever your Ring-bearer attacks, draw a card, then discard a card.',
  'Whenever your Ring-bearer becomes blocked by a creature, that creature’s controller sacrifices it at end of combat.',
  'Whenever your Ring-bearer deals combat damage to a player, each opponent loses 3 life.'
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
          colors: [Colors.white, Colors.blue, Colors.red, Colors.green],
        ),
      ),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: Colors.transparent,
        backgroundColor: Colors.white,
        body: MechanicExplanations(
          key: ValueKey<String>('unique_key_for_The_Ring'),
          title: 'The Ring',
        ),
      ),
    );
  }
}

class MechanicExplanations extends StatefulWidget {
  const MechanicExplanations({required Key key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<MechanicExplanations> createState() => _MechanicExplanationsState();
}

class _MechanicExplanationsState extends State<MechanicExplanations> {
  // seize of Player fields
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

  int ringLevel = 0;

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
        appBar: AppBar(
          centerTitle: true,
          title: const Text("The Ring"),
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
                  height: 400,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: ringLeveHeight,
                          width: ringLevelWidth,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
                          ),
                          child: Center(
                            child: Text(
                              abilities[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _getTextColor(0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: ringLeveHeight,
                          width: ringLevelWidth,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
                          ),
                          child: Center(
                            child: Text(
                              abilities[1],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _getTextColor(1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: ringLeveHeight,
                          width: ringLevelWidth,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
                          ),
                          child: Center(
                            child: Text(
                              abilities[2],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _getTextColor(2),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: ringLeveHeight,
                          width: ringLevelWidth,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
                          ),
                          child: Center(
                            child: Text(
                              abilities[3],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _getTextColor(3),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
