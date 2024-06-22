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
                    List<int> lifePoints = List.filled(5, startingLife);
                    List<Color> playerColors = List.filled(5, shadowStatus);

                    nLP1 = lifePoints[0];
                    nLP2 = lifePoints[1];
                    nLP3 = lifePoints[2];
                    nLP4 = lifePoints[3];
                    nLP5 = lifePoints[4];

                    colorPlayer1 = playerColors[0];
                    colorPlayer2 = playerColors[1];
                    colorPlayer3 = playerColors[2];
                    colorPlayer4 = playerColors[3];
                    colorPlayer5 = playerColors[4];
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