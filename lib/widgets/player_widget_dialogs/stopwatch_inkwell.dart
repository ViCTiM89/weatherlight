import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchInkWell extends StatefulWidget {
  final double height;
  final double width;
  final Color shadowColor;
  final VoidCallback? onStopped;
  final bool isActive;
  final int resetTrigger;

  const StopwatchInkWell({
    super.key,
    required this.height,
    required this.width,
    required this.shadowColor,
    this.onStopped,
    required this.isActive,
    required this.resetTrigger,
  });

  @override
  State<StopwatchInkWell> createState() => StopwatchInkWellState();
}

class StopwatchInkWellState extends State<StopwatchInkWell> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  String get _formattedTime {
    final elapsed = _stopwatch.elapsed;
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void start() {
    if (_stopwatch.isRunning) return;
    _stopwatch.start();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  void stop({bool notify = true}) {
    if (!_stopwatch.isRunning) return;
    _stopwatch.stop();
    _timer?.cancel();
    if (notify) {
      widget.onStopped?.call();
    }
    setState(() {});
  }

  void toggle() {
    _stopwatch.isRunning ? stop() : start();
  }

  void _reset() {
    _stopwatch.reset();
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant StopwatchInkWell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !_stopwatch.isRunning) {
      start();
    }
    if (!widget.isActive && _stopwatch.isRunning) {
      stop(notify: false);
    }

    // 🔁 reset requested
    if (widget.resetTrigger != oldWidget.resetTrigger) {
      _stopwatch
        ..stop()
        ..reset();
      _timer?.cancel();
      setState(() {});
    }

    // ▶️ active changed
    if (widget.isActive && !oldWidget.isActive) {
      start();
    } else if (!widget.isActive && oldWidget.isActive) {
      stop();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggle,
      onLongPress: _reset,
      child: Container(
        height: widget.height,
        width: widget.width,
        color: Colors.white30,
        child: Center(
          child: RotatedBox(
            quarterTurns: 3,
            child: FittedBox(
              child: Text(
                _formattedTime,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                  shadows: [
                    for (double i = 1; i < 10; i++)
                      Shadow(
                        color: widget.shadowColor,
                        blurRadius: 3 * i,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
