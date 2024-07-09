import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherlight/widgets/player_widget_dialogs/show_player_status_dialog.dart';
import '../constants.dart' as constants;

class PlayerWidget extends StatefulWidget {
  final double pmHeight;
  final double pmWidth;
  final double statusHeight;
  final double statusWidth;
  late String commanderName;
  final String initialCommanderName;
  int nLP;
  final Color shadowIncrement;
  final Color shadowDecrement;
  final Color shadowStatus;
  Color colorPlayer;
  final TextEditingController controller;
  final TextEditingController controllerName;
  final int playerCount;
  final Color shadowColor = constants.shadowColorCommanderDamage;
  final Color poisonColor = constants.poisonColor;
  final Color experienceColor = constants.experienceColor;
  final Color energyColor = constants.energyColor;
  final Color radiationColor = Colors.lightGreenAccent;
  final Color infiniteColor = constants.infiniteColor;
  final Color koColor = constants.koColor;
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

  PlayerWidget({
    super.key,
    required this.pmHeight,
    required this.pmWidth,
    required this.statusHeight,
    required this.statusWidth,
    required this.commanderName,
    required this.initialCommanderName,
    required this.nLP,
    required this.shadowIncrement,
    required this.shadowDecrement,
    required this.shadowStatus,
    required this.colorPlayer,
    required this.controller,
    required this.controllerName,
    required this.playerCount,
  });

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Timer? _timer;

  void updateLP(int i) {
    setState(() {
      widget.nLP += i;
      widget.lifeChange += i;
      if (widget.nLP < 10) {
        widget.colorPlayer = widget.shadowDecrement;
      } else {
        widget.colorPlayer = widget.shadowStatus;
      }
    });

    _timer?.cancel(); // Cancel the previous timer
    _timer = Timer(
      const Duration(seconds: 1),
      () {
        setState(() {
          widget.lifeChange = 0;
          if (widget.lifeHistory.isEmpty ||
              widget.nLP != widget.lifeHistory.last) {
            widget.lifeHistory.add(widget.nLP);
          }
        });
      },
    );
  }

  void updateCD(int i, int k) {
    setState(
      () {
        widget.cmdDamage[i] += k;
      },
    );
  }

  void updatePlayerCounters(int i, int k) {
    setState(() {
      widget.playerCounter[i] += k;
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
            if (!widget.knockout && !widget.infinite) {
              updateLP(1);
            }
          },
          onLongPress: () {
            if (!widget.knockout && !widget.infinite) {
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
                width: widget.statusWidth,
                color: Colors.white30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: FittedBox(
                      child: Text(
                        widget.commanderName,
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
                  widget.cmdDamage,
                  widget.lifeHistory,
                  widget.playerCount,
                  widget.knockout,
                  widget.infinite,
                  updateLP,
                  updateCD,
                  updatePlayerCounters,
                  widget.playerCounter,
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
                      setState(
                        () {
                          if (widget.controllerName.text.isEmpty) {
                            widget.commanderName = widget.initialCommanderName;
                          } else {
                            widget.commanderName = widget.controllerName.text;
                            widget.controllerName.clear();
                          }
                        },
                      );
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
                setState(
                  () {
                    widget.knockout = !widget.knockout;
                    if (widget.knockout) {
                      widget.colorPlayer = widget.koColor;
                    } else {
                      widget.colorPlayer = widget.shadowStatus;
                    }
                  },
                );
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
                          widget.nLP = int.parse(widget.controller.text);
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
                setState(
                  () {
                    if (!widget.knockout) {
                      widget.infinite = !widget.infinite;
                      if (widget.infinite) {
                        widget.colorPlayer = widget.infiniteColor;
                      } else {
                        widget.colorPlayer = widget.shadowStatus;
                      }
                    }
                  },
                );
              },
              child: Container(
                height: widget.statusHeight,
                width: widget.statusWidth,
                color: Colors.white30,
                child: Stack(
                  children: [
                    Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          widget.knockout
                              ? 'K.O.'
                              : (widget.infinite ? '∞' : '${widget.nLP}'),
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            shadows: [
                              for (double i = 1; i < 10; i++)
                                Shadow(
                                  color: widget.colorPlayer,
                                  blurRadius: 3 * i,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (widget.lifeChange != 0)
                      Positioned.fill(
                        child: Align(
                          alignment: widget.lifeChange > 0
                              ? Alignment.topLeft
                              : Alignment.bottomLeft,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              '${widget.lifeChange > 0 ? '+' : ''}${widget.lifeChange}',
                              style: TextStyle(
                                fontSize: 30,
                                color: widget.lifeChange > 0
                                    ? Colors.green
                                    : Colors.red,
                                shadows: [
                                  for (double i = 1; i < 10; i++)
                                    Shadow(
                                      color: widget.colorPlayer,
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
            if (!widget.knockout && !widget.infinite) {
              updateLP(-1);
            }
          },
          onLongPress: () {
            if (!widget.knockout && !widget.infinite) {
              updateLP(-10);
            }
          },
        ),
      ],
    );
  }
}