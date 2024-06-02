import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

double rewardLeveHeight = 90;
double rewardLevelWidth = 200;
int rewardLevel = 1;
const Color rewardColorActive = Colors.white;
const Color rewardColorInactive = Colors.grey;

const List<String> rewards = [
  'Create a Treasure Token',
  'Create Two Treasure Tokens',
  'Create two Treasure tokens *or* draw a card',
  '(Max) Create two Treasure tokens *and* draw a card.'
];

class BountyGame extends StatefulWidget {
  const BountyGame({Key? key}) : super(key: key);

  @override
  State<BountyGame> createState() => _BountyGameState();
}

class _BountyGameState extends State<BountyGame> {
  @override
  void initState() {
    super.initState();
    // Enable wakelock when entering the screen
    Wakelock.enable();
  }

  @override
  void dispose() {
    // Disable wakelock when leaving the screen
    Wakelock.disable();
    super.dispose();
  }

  int rewardLevel = 1;

  void _incrementRewardLevel() {
    setState(() {
      if (rewardLevel < 3) {
        rewardLevel++;
      } else {
        rewardLevel = 0;
      }
    });
  }

  void _resetRewardLevel() {
    setState(() {
      rewardLevel = 0;
    });
  }

  Color _getTextColor(int index) {
    return rewardLevel >= index ? rewardColorActive : rewardColorInactive;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.white, Colors.blue, Colors.red, Colors.green],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Bounty"),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Center(
                  child: Text('Under Construction'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: _incrementRewardLevel,
                onLongPress: _resetRewardLevel,
                child: Container(
                  height: 210,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                            height: rewardLeveHeight,
                            width: rewardLevelWidth,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                rewards[0],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _getTextColor(0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                            height: rewardLeveHeight,
                            width: rewardLevelWidth,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                rewards[1],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _getTextColor(1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                            height: rewardLeveHeight,
                            width: rewardLevelWidth,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                rewards[2],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _getTextColor(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                            height: rewardLeveHeight,
                            width: rewardLevelWidth,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                rewards[3],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _getTextColor(3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: BountyGame()));
