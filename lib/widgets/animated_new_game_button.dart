import 'package:flutter/material.dart';

class AnimatedScaleButton extends StatefulWidget {
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  const AnimatedScaleButton({
    Key? key,
    required this.onTap,
    this.size = 60.0,
    this.backgroundColor = Colors.deepPurpleAccent,
    this.icon = Icons.add,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
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
            child: CircleAvatar(
              radius: widget.size / 2 - 2,
              backgroundColor: widget.backgroundColor,
              child: Icon(
                widget.icon,
                size: widget.size / 2,
                color: widget.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
