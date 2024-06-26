import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../game_helper.dart';

class CommanderBingo extends StatefulWidget {
  const CommanderBingo({required Key key}) : super(key: key);

  @override
  State<CommanderBingo> createState() => _CommanderBingoState();
}

class _CommanderBingoState extends State<CommanderBingo> {
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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Bingo"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                // Capture the current context
                final currentContext = context;
                // Show confirmation dialog when close button is pressed
                bool confirmExit = await confirmExitDialog(currentContext);
                if (confirmExit) {
                  Navigator.of(currentContext).pop();
                }
              },
            ),
          ],
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
            ],
          ),
        ),
      ),
    );
  }
}
