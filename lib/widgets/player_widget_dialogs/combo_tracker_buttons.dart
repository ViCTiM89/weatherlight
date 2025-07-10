import 'package:flutter/material.dart';

import '../../constants.dart';

class CounterButton extends StatefulWidget {
  final String backgroundImage; // Path to the background image
  final double width; // Width of the button
  final double height; // Height of the button

  const CounterButton({
    Key? key,
    required this.backgroundImage,
    this.width = dialogButtonSize, // Default width
    this.height = dialogButtonSize, // Default height
  }) : super(key: key);

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int count = 0; // Counter variable

  void _increment() {
    setState(() {
      count++; // Increment the counter
    });
  }

  void _decrement() {
    setState(() {
      count--; // Decrement the counter
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _increment, // Increment on tap
      onLongPress: _decrement, // Decrement on long press
      child: Container(
        width: widget.width, // Set button width
        height: widget.height, // Set button height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          image: DecorationImage(
            image: AssetImage(widget.backgroundImage),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$count',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                for (double i = 1; i < 10; i++)
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 3 * i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
