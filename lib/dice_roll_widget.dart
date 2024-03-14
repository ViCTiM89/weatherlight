import 'package:flutter/material.dart';
import 'dart:math';

import 'dice_eye_widget.dart';

class DiceRollWidget extends StatefulWidget {
  final double diceLength;
  final Color diceColor;
  final Color diceBorder;
  final Color eyeColor;
  final int rollCount;
  final double offsetRight;
  final double offsetBottom;

  const DiceRollWidget({
    Key? key,
    required this.diceLength,
    required this.diceColor,
    required this.diceBorder,
    required this.rollCount,
    required this.eyeColor,
    required this.offsetRight,
    required this.offsetBottom,
  }) : super(key: key);

  @override
  State<DiceRollWidget> createState() => _DiceRollWidgetState();
}

class _DiceRollWidgetState extends State<DiceRollWidget> {
  int diceRoll = 1;
  int previousRoll = 0;

  Future<void> _startRollAnimation() async {
    for (int i = 0; i < widget.rollCount; i++) {
      await Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          do {
            diceRoll = Random().nextInt(6) + 1;
          } while (diceRoll == previousRoll); // Repeat until it's different
          previousRoll = diceRoll; // Update previous roll
          diceRoll = 5;
          print(diceRoll);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.diceLength,
          width: widget.diceLength,
          decoration: BoxDecoration(
            color: widget.diceColor,
            border: Border.all(color: widget.diceBorder, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: _startRollAnimation,
            child: diceRoll == 0
                ? SizedBox() // No dice image to show initially
                : DiceEyesWidget(
                    numberOfEyes: diceRoll,
                    eyeColor: widget.eyeColor,
                    eyeOffsetRight: widget.offsetRight,
                    eyeOffsetBottom:
                        widget.offsetBottom, // Customize eye color here
                  ),
          ),
        ),
      ],
    );
  }
}
