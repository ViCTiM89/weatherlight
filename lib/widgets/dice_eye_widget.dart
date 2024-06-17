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
    // Define the eye widgets based on the dice number
    final List<Widget> eyeWidgets = _calculateEyeWidgets(numberOfEyes);

    return Center(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: eyeWidgets,
        ),
      ),
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
  List<Widget> _calculateEyeWidgets(int numberOfEyes) {
    final double offsetX = eyeOffsetRight;
    final double offsetY = eyeOffsetBottom;

    final double offsetXCenter = offsetX / 2;
    final double offsetYCenter = offsetY / 2;

    switch (numberOfEyes) {
      case 1:
        return [
          Center(
            //child: _buildEye(eyeColor),
            child: Image.asset('images/chaos.png', fit: BoxFit.cover),
          ),
        ];
      case 2:
        return [
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
        ];
      case 3:
        return [
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: _buildEye(eyeColor),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
        ];
      case 4:
        return [
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
        ];
      case 5:
        return [
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: _buildEye(eyeColor),
          ),
        ];
      case 6:
        return [
          Center(
            //child: _buildEye(eyeColor),
            child: Image.asset('images/pw_symbol.png', fit: BoxFit.cover),
          ),

          /*
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, 0),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(-offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, -offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, 0),
              child: _buildEye(eyeColor),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(offsetXCenter, offsetYCenter),
              child: _buildEye(eyeColor),
            ),
          ),
        */];

      default:
        return [];
    }
  }
}
