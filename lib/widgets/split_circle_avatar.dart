import 'package:flutter/material.dart';

class SplitCircleAvatar extends StatelessWidget {
  final String? leftImageUrl;
  final String? rightImageUrl;
  final double radius;

  const SplitCircleAvatar({
    super.key,
    this.leftImageUrl,
    this.rightImageUrl,
    this.radius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: ClipOval(
        child: Row(
          children: [
            // Left half
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: leftImageUrl != null
                    ? Image.network(
                        leftImageUrl!,
                        key: ValueKey(leftImageUrl),
                        fit: BoxFit.cover,
                        width: radius,
                        height: radius * 2,
                      )
                    : Container(
                        key: const ValueKey('left-fallback'),
                        color: Colors.grey,
                        width: radius,
                        height: radius * 2,
                      ),
              ),
            ),

            // Right half
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: rightImageUrl != null
                    ? Image.network(
                        rightImageUrl!,
                        key: ValueKey(rightImageUrl),
                        fit: BoxFit.cover,
                        width: radius,
                        height: radius * 2,
                      )
                    : Container(
                        key: const ValueKey('right-fallback'),
                        color: Colors.grey.shade400,
                        width: radius,
                        height: radius * 2,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
