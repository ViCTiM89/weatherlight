import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';


class TestingPage extends StatelessWidget {
  const TestingPage({required Key key}) : super(key: key);

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
        backgroundColor: Colors.transparent,
        body: MechanicExplanations(
          key: ValueKey<String>('unique_key_for_ThirdRoute'),
          title: 'Testing',
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

  Color shadowColor = Colors.white12;


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
          title: const Text("Bingo"),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Center(
                  child: Text('Under Construction'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Go back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white24.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      for (double i = 1; i < 10; i++)
                        Shadow(
                          color: shadowColor,
                          blurRadius: 3 * i,
                        ),
                    ],
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
