import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:weatherlight/widgets/player_widget_dialogs/combo_tracker_buttons.dart';

class ShowComboTracker {
  static void showComboTrackerDialog(BuildContext context, parentRotation) {
    double rotationInRadians = (parentRotation - 90.0) * (math.pi / 180);

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: rotationInRadians, // Apply the correct rotation
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Center(
              child: Text(
                'Combo Tracker',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            content: const SizedBox(
              width: 250,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CounterButton(backgroundImage: 'images/Mana-W.png'),
                      SizedBox(width: 5),
                      CounterButton(backgroundImage: 'images/Mana-U.png'),
                      SizedBox(width: 5),
                      CounterButton(backgroundImage: 'images/Mana-B.png'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CounterButton(backgroundImage: 'images/Mana-R.png'),
                      SizedBox(width: 5),
                      CounterButton(backgroundImage: 'images/Mana-G.png'),
                      SizedBox(width: 5),
                      CounterButton(backgroundImage: 'images/Mana-C.png'),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CounterButton(
                          backgroundImage: 'images/Instant_symbol.png'),
                      SizedBox(width: 5),
                      CounterButton(
                          backgroundImage: 'images/Enchantment_symbol.png'),
                      SizedBox(width: 5),
                      CounterButton(
                          backgroundImage: 'images/Creature_symbol.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
