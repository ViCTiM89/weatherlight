import 'package:flutter/material.dart';
import 'constants.dart';

void newGame(BuildContext context, Function setState, int startingLife,
    Color shadowStatus) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Start a New Game?'),
        content: const Text('Are you sure you want to start a new game?'),
        actions: <Widget>[
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // Dismiss the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              const Expanded(
                child: SizedBox(),
              ), // Spacer to push the next button to the right
              TextButton(
                onPressed: () {
                  setState(() {
                    player1Key.currentState
                        ?.resetPlayer(startingLife, shadowStatus);
                    player2Key.currentState
                        ?.resetPlayer(startingLife, shadowStatus);
                    player3Key.currentState
                        ?.resetPlayer(startingLife, shadowStatus);
                    player4Key.currentState
                        ?.resetPlayer(startingLife, shadowStatus);
                    player5Key.currentState
                        ?.resetPlayer(startingLife, shadowStatus);
                  });
                  // Dismiss the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<bool> confirmExitDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Are you sure you want to exit this page?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // Return false when canceled
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Return true when confirmed
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      ) ??
      false; // Return false if dialog is dismissed
}
