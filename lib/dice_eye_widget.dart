import 'package:flutter/material.dart';

class DiceEyesWidget extends StatelessWidget {
  final int numberOfEyes;
  final Color eyeColor;
  final double eyeOffsetRight;
  final double eyeOffsetBottom;

  const DiceEyesWidget({
    Key? key,
    required this.numberOfEyes,
    required this.eyeColor,
    required this.eyeOffsetRight,
    required this.eyeOffsetBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the eye positions based on the dice number
    final List<Offset> eyePositions = _calculateEyePositions(numberOfEyes);

    return Stack(
      children: [
        for (final position in eyePositions)
          Positioned(
            left: position.dx,
            top: position.dy,
            child: _buildEye(eyeColor),
          ),
      ],
    );
  }

  Widget _buildEye(Color color) {
    return Container(
      width: 10, // Adjust size of the eye as needed
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  // Calculate the positions of additional eyes based on the dice number
  List<Offset> _calculateEyePositions(int numberOfEyes) {
    final double offsetX = eyeOffsetRight;
    final double offsetY = eyeOffsetBottom;

    final double offsetTop = offsetY/10;
    final double offsetBottom = offsetY + offsetY/10;

    final double offsetLeft = offsetX/10;
    final double offsetRight = offsetX;

    final double offsetXCenter = offsetX / 2 + offsetLeft;
    final double offsetYCenter = offsetY / 2 + offsetTop;

    switch (numberOfEyes) {
      case 1:
        return [
          Offset(offsetXCenter, offsetYCenter), // Center
        ];
      case 2:
        return [
          Offset(offsetLeft, offsetTop), // Top Left
          Offset(offsetRight, offsetBottom), // Bottom Right
        ];
      case 3:
        return [
          Offset(offsetLeft, offsetTop), // Top Left
          Offset(offsetXCenter, offsetYCenter), // Center
          Offset(offsetRight, offsetBottom), // Bottom Right
        ];
      case 4:
        return [
          Offset(offsetLeft, offsetTop), // Top left
          Offset(offsetLeft, offsetBottom), // Bottom left
          Offset(offsetRight, offsetTop), // Top right
          Offset(offsetRight, offsetBottom), // Bottom right
        ];
      case 5:
        return [
          Offset(offsetLeft, offsetTop), // Top left
          Offset(offsetLeft, offsetBottom), // Bottom left
          Offset(offsetXCenter, offsetYCenter), // Center
          Offset(offsetRight, offsetTop), // Top right
          Offset(offsetRight, offsetBottom), // Bottom right
        ];
      case 6:
        return [
          Offset(offsetLeft, offsetTop), // Top left
          Offset(offsetLeft, offsetBottom), // Bottom left
          Offset(offsetLeft, offsetYCenter), // Left center
          Offset(offsetRight, offsetYCenter), // Right center
          Offset(offsetRight, offsetTop), // Top right
          Offset(offsetRight, offsetBottom), // Bottom right
        ];
      default:
        return [];
    }
  }
}
