import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherlight/widgets/player_widget_dialogs/show_player_status_dialog.dart';
import 'package:weatherlight/widgets/player_widget_dialogs/stopwatch_inkwell.dart';
import '../constants.dart' as constants;

class PlayerWidget extends StatefulWidget {
  final double pmHeight;
  final double pmWidth;
  final double statusHeight;
  final String initialCommanderName;
  final int initialLP;
  final Color shadowIncrement;
  final Color shadowDecrement;
  final Color shadowStatus;
  final Color initialColorPlayer;
  final TextEditingController controller;
  final TextEditingController controllerName;
  final int playerCount;

  // These colors can stay here as constants or final fields
  final Color shadowColor = constants.shadowColorCommanderDamage;
  final Color poisonColor = constants.poisonColor;
  final Color experienceColor = constants.experienceColor;
  final Color energyColor = constants.energyColor;
  final Color radiationColor = Colors.lightGreenAccent;
  final Color infiniteColor = constants.infiniteColor;
  final Color koColor = constants.koColor;

  final bool isActive;
  final VoidCallback onStopped;

  PlayerWidget({
    super.key,
    required this.pmHeight,
    required this.pmWidth,
    required this.statusHeight,
    required this.initialCommanderName,
    required this.initialLP,
    required this.shadowIncrement,
    required this.shadowDecrement,
    required this.shadowStatus,
    required this.initialColorPlayer,
    required this.controller,
    required this.controllerName,
    required this.playerCount,
    required this.isActive,
    required this.onStopped,
  });

  @override
  State<PlayerWidget> createState() => PlayerWidgetState();
}

class PlayerWidgetState extends State<PlayerWidget> {
  late String commanderName;
  late int nLP;
  late Color colorPlayer;

  int lifeChange = 0;
  final List<int> lifeHistory = [];
  final List<int> cmdDamage = [0, 0, 0, 0, 0];
  final List<int> playerCounter = [0, 0, 0, 0];

  int poison = 0;
  int experience = 0;
  int energy = 0;
  int radiation = 0;

  bool knockout = false;
  bool infinite = false;

  Timer? _timer;
  int stopwatchReset = 0;

  @override
  void initState() {
    super.initState();
    commanderName = widget.initialCommanderName;
    nLP = widget.initialLP;
    colorPlayer = widget.initialColorPlayer;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void updateLP(int i) {
    setState(() {
      nLP += i;
      lifeChange += i;
      if (nLP < 10) {
        colorPlayer = widget.shadowDecrement;
      } else {
        colorPlayer = widget.shadowStatus;
      }
    });

    _timer?.cancel(); // Cancel the previous timer
    _timer = Timer(
      const Duration(seconds: 1),
      () {
        setState(() {
          lifeChange = 0;
          if (lifeHistory.isEmpty || nLP != lifeHistory.last) {
            lifeHistory.add(nLP);
          }
        });
      },
    );
  }

  void updateCD(int i, int k) {
    setState(() {
      cmdDamage[i] += k;
    });
  }

  void updatePlayerCounters(int i, int k) {
    setState(() {
      playerCounter[i] += k;
    });
  }

  void resetPlayer(int startingLife, Color newColor) {
    setState(() {
      lifeHistory.clear();
      nLP = startingLife;
      colorPlayer = newColor;
      playerCounter.fillRange(0, playerCounter.length, 0);
      cmdDamage.fillRange(0, cmdDamage.length, 0);
      stopwatchReset++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            height: widget.pmHeight,
            width: widget.pmWidth,
            decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.greenAccent,
                  shadows: [
                    for (double i = 1; i < 5; i++)
                      Shadow(
                        color: widget.shadowIncrement,
                        blurRadius: 3 * i,
                      )
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            if (!knockout && !infinite) {
              updateLP(1);
            }
          },
          onLongPress: () {
            if (!knockout && !infinite) {
              updateLP(10);
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                height: widget.statusHeight,
                width: widget.pmWidth / 4,
                color: Colors.white30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: FittedBox(
                      child: Text(
                        commanderName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                          shadows: [
                            for (double i = 1; i < 10; i++)
                              Shadow(
                                color: widget.shadowStatus,
                                blurRadius: 3 * i,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                ShowPlayerStatusDialog.showPlayerDialog(
                  context,
                  cmdDamage,
                  lifeHistory,
                  widget.playerCount,
                  knockout,
                  infinite,
                  updateLP,
                  updateCD,
                  updatePlayerCounters,
                  playerCounter,
                  widget.shadowColor,
                  widget.poisonColor,
                  widget.experienceColor,
                  widget.energyColor,
                  widget.radiationColor,
                );
              },
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Player Name"),
                  content: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: widget.controllerName,
                    onSubmitted: (value) {
                      setState(() {
                        if (widget.controllerName.text.isEmpty) {
                          commanderName = widget.initialCommanderName;
                        } else {
                          commanderName = widget.controllerName.text;
                          widget.controllerName.clear();
                        }
                      });
                      Navigator.pop(context, 'OK');
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
              onDoubleTap: () {
                setState(() {
                  knockout = !knockout;
                  if (knockout) {
                    colorPlayer = widget.koColor;
                  } else {
                    colorPlayer = widget.shadowStatus;
                  }
                });
              },
            ),
            InkWell(
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Enter Life Points"),
                  content: TextField(
                    keyboardType: TextInputType.number,
                    controller: widget.controller,
                    onSubmitted: (value) {
                      if (widget.controller.text.isNotEmpty) {
                        setState(() {
                          nLP = int.parse(widget.controller.text);
                        });
                        widget.controller.clear();
                      }
                      Navigator.pop(context, 'OK');
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
              onDoubleTap: () {
                setState(() {
                  if (!knockout) {
                    infinite = !infinite;
                    if (infinite) {
                      colorPlayer = widget.infiniteColor;
                    } else {
                      colorPlayer = widget.shadowStatus;
                    }
                  }
                });
              },
              child: Container(
                height: widget.statusHeight,
                width: widget.pmWidth / 2,
                color: Colors.white30,
                child: Stack(
                  children: [
                    Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          knockout ? 'K.O.' : (infinite ? '∞' : '$nLP'),
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            shadows: [
                              for (double i = 1; i < 10; i++)
                                Shadow(
                                  color: colorPlayer,
                                  blurRadius: 3 * i,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (lifeChange != 0)
                      Positioned.fill(
                        child: Align(
                          alignment: lifeChange > 0
                              ? Alignment.topLeft
                              : Alignment.bottomLeft,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              '${lifeChange > 0 ? '+' : ''}$lifeChange',
                              style: TextStyle(
                                fontSize: 30,
                                color:
                                    lifeChange > 0 ? Colors.green : Colors.red,
                                shadows: [
                                  for (double i = 1; i < 10; i++)
                                    Shadow(
                                      color: colorPlayer,
                                      blurRadius: 3 * i,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            StopwatchInkWell(
              isActive: widget.isActive,
              onStopped: widget.onStopped,
              height: widget.statusHeight,
              width: widget.pmWidth / 4,
              shadowColor: widget.shadowStatus,
              resetTrigger: stopwatchReset,
            ),
          ],
        ),
        InkWell(
          child: Container(
            height: widget.pmHeight,
            width: widget.pmWidth,
            decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.remove,
                  size: 50,
                  color: Colors.red,
                  shadows: [
                    for (double i = 1; i < 10; i++)
                      Shadow(
                        color: widget.shadowStatus,
                        blurRadius: 3 * i,
                      ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            if (!knockout && !infinite) {
              updateLP(-1);
            }
          },
          onLongPress: () {
            if (!knockout && !infinite) {
              updateLP(-10);
            }
          },
        ),
      ],
    );
  }
}
