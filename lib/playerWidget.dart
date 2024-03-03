import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  final Color shadowColor = Colors.blue;
  final Color poisonColor = Colors.green;
  final Color experienceColor = Colors.deepOrange;
  final Color energyColor = Colors.orangeAccent;
  final List<int> cmdDamage = [0, 0, 0, 0, 0];
  int poison = 0;
  int experience = 0;
  int energy = 0;

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
  void _updateLP(int i) {
    setState(
      () {
        widget.nLP += i;
        if (widget.nLP < 10) {
          widget.colorPlayer = widget.shadowDecrement;
        } else {
          widget.colorPlayer = widget.shadowStatus;
        }
      },
    );
  }

  void _updateCD(int i, int k) {
    setState(
      () {
        widget.cmdDamage[i] += k;
      },
    );
  }

  void _updatePoison(int i) {
    setState(
      () {
        widget.poison += i;
      },
    );
  }

  void _updateExperience(int i) {
    setState(
      () {
        widget.experience += i;
      },
    );
  }

  void _updateEnergy(int i) {
    setState(
      () {
        widget.energy += i;
      },
    );
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
            _updateLP(1);
          },
          onLongPress: () {
            _updateLP(10);
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
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                // Find the RotatedBox parent in the widget tree
                RotatedBox? parentRotatedBox =
                    context.findAncestorWidgetOfExactType<RotatedBox>();

                if (parentRotatedBox != null) {
                  double rotation = parentRotatedBox.quarterTurns *
                      90 %
                      360; // Adjust the rotation to avoid exceeding 360 degrees

                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      List<int> cmdDamage =
                          widget.cmdDamage; // Copy the list to local variable

                      return AlertDialog(
                        content: SizedBox(
                          width: 300, // Width of the dialog
                          height: 300, // Height of the dialog
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Transform.rotate(
                                      angle: rotation *
                                          (math.pi /
                                              180), // Convert degrees to radians
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              for (int i = 0;
                                                  i < widget.playerCount;
                                                  i +=
                                                      2) // Loop through the number of players
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    const SizedBox(
                                                      height: 80,
                                                      width: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _updateLP(-1);
                                                          _updateCD(i, 1);
                                                        });
                                                      },
                                                      onLongPress: () {
                                                        setState(() {
                                                          _updateLP(1);
                                                          _updateCD(
                                                            i,
                                                            -1,
                                                          );
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    20.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20.0),
                                                          ),
                                                          color: Colors.black,
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "images/CMM.jpg"),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${cmdDamage[i]}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 45,
                                                              color: Colors
                                                                  .white24
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              shadows: [
                                                                for (double i =
                                                                        1;
                                                                    i < 10;
                                                                    i++)
                                                                  Shadow(
                                                                    color: widget
                                                                        .shadowColor,
                                                                    blurRadius:
                                                                        3 * i,
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 80,
                                                      width: 10,
                                                    ),
                                                    if (i + 1 <
                                                        widget.playerCount)
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            _updateLP(-1);
                                                            _updateCD(i + 1, 1);
                                                          });
                                                        },
                                                        onLongPress: () {
                                                          setState(() {
                                                            _updateLP(1);
                                                            _updateCD(
                                                                i + 1, -1);
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      20.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            color: Colors.black,
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "images/CMM.jpg"),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '${cmdDamage[i + 1]}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 45,
                                                                color: Colors
                                                                    .white24
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                shadows: [
                                                                  for (double i =
                                                                          1;
                                                                      i < 10;
                                                                      i++)
                                                                    Shadow(
                                                                      color: widget
                                                                          .shadowColor,
                                                                      blurRadius:
                                                                          3 * i,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      _updatePoison(1);
                                                    },
                                                  );
                                                },
                                                onLongPress: () {
                                                  setState(
                                                    () {
                                                      _updatePoison(-1);
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                      bottomRight:
                                                          Radius.circular(20.0),
                                                    ),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "images/poison.png"),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${widget.poison}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 45,
                                                        color: Colors.white24
                                                            .withOpacity(0.8),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        shadows: [
                                                          for (double i = 1;
                                                              i < 10;
                                                              i++)
                                                            Shadow(
                                                              color: widget
                                                                  .poisonColor,
                                                              blurRadius: 3 * i,
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      _updateExperience(1);
                                                    },
                                                  );
                                                },
                                                onLongPress: () {
                                                  setState(
                                                    () {
                                                      _updateExperience(-1);
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                      bottomRight:
                                                          Radius.circular(20.0),
                                                    ),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "images/experience.png"),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${widget.experience}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 45,
                                                        color: Colors.white24
                                                            .withOpacity(0.8),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        shadows: [
                                                          for (double i = 1;
                                                              i < 10;
                                                              i++)
                                                            Shadow(
                                                              color: widget
                                                                  .experienceColor,
                                                              blurRadius: 3 * i,
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      _updateEnergy(1);
                                                    },
                                                  );
                                                },
                                                onLongPress: () {
                                                  setState(
                                                    () {
                                                      _updateEnergy(-1);
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                      bottomRight:
                                                          Radius.circular(20.0),
                                                    ),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "images/energy.png"),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${widget.energy}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 45,
                                                        color: Colors.white24
                                                            .withOpacity(0.8),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        shadows: [
                                                          for (double i = 1;
                                                              i < 10;
                                                              i++)
                                                            Shadow(
                                                              color: widget
                                                                  .energyColor,
                                                              blurRadius: 3 * i,
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
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
            ),
            InkWell(
              child: Container(
                height: widget.statusHeight,
                width: widget.statusWidth,
                color: Colors.white30,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      '${widget.nLP}',
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
              ),
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
            _updateLP(-1);
          },
          onLongPress: () {
            _updateLP(-10);
          },
        ),
      ],
    );
  }
}
