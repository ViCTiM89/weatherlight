import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:weatherlight/widgets/dice_roll_widget.dart';

class PlaneChase extends StatefulWidget {
  const PlaneChase({required Key key}) : super(key: key);

  @override
  State<PlaneChase> createState() => _PlaneChaseState();
}

class _PlaneChaseState extends State<PlaneChase> {
  int diceRoll = 0;

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

  Widget _buildUnderConstructionWidget() {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: const Center(
        child: Text('Under Construction'),
      ),
    );
  }

  Widget _buildGoBackButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Go back!'),
    );
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
          title: const Text("Plane Chase"),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
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
              _buildGoBackButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
