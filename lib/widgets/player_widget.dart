import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
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

  void _updateLP(int i) {
    setState(
      () {
        widget.nLP += i;
        widget.lifeChange += i;
        if (widget.nLP < 10) {
          widget.colorPlayer = widget.shadowDecrement;
        } else {
          widget.colorPlayer = widget.shadowStatus;
        }
      },
    );

    _timer?.cancel(); // Cancel the previous timer
    _timer = Timer(
      const Duration(seconds: 1),
      () {
        setState(() {
          widget.lifeChange = 0;
          widget.lifeHistory.add(widget.nLP);
        });
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

  void _updateRadiation(int i) {
    setState(
      () {
        widget.radiation += i;
      },
    );
  }

  void _showPlayerDialog(BuildContext context) {
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
          return Transform.rotate(
            angle: rotation * (math.pi / 180),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              content: SizedBox(
                width: 400,
                height: 400,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showLPHistoryDialog(
                                          context, widget.lifeHistory);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .deepPurpleAccent, // Background color
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        'LP-History',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              16.0, // Adjust font size as needed
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (int i = 0;
                                      i < widget.playerCount;
                                      i +=
                                          2) // Loop through the number of players
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(height: 80, width: 20),
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
                                              _updateCD(i, -1);
                                            });
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.black,
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "images/CMM.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${cmdDamage[i]}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 45,
                                                  color: Colors.white24
                                                      .withOpacity(0.8),
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    for (double i = 1;
                                                        i < 10;
                                                        i++)
                                                      Shadow(
                                                        color:
                                                            widget.shadowColor,
                                                        blurRadius: 3 * i,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 80, width: 10),
                                        if (i + 1 < widget.playerCount)
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
                                                _updateCD(i + 1, -1);
                                              });
                                            },
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                color: Colors.black,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "images/CMM.jpg"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${cmdDamage[i + 1]}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 45,
                                                    color: Colors.white24
                                                        .withOpacity(0.8),
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      for (double i = 1;
                                                          i < 10;
                                                          i++)
                                                        Shadow(
                                                          color: widget
                                                              .shadowColor,
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
                              const SizedBox(width: 50),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _updatePoison(1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        _updatePoison(-1);
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                          image:
                                              AssetImage("images/poison.png"),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${widget.poison}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: widget.poisonColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _updateExperience(1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        _updateExperience(-1);
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "images/experience.png"),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${widget.experience}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: widget.experienceColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _updateEnergy(1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        _updateEnergy(-1);
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                          image:
                                              AssetImage("images/energy.png"),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${widget.energy}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: widget.energyColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _updateRadiation(1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        _updateRadiation(-1);
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "images/radiation.png"),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${widget.radiation}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: widget.radiationColor,
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
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void _showLPHistoryDialog(BuildContext context, List<int> lpHistory) {
    RotatedBox? parentRotatedBox =
        context.findAncestorWidgetOfExactType<RotatedBox>();
    if (parentRotatedBox != null) {
      double rotation = parentRotatedBox.quarterTurns *
          270 %
          360; // Adjust the rotation to avoid exceeding 360 degrees
      showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Transform.rotate(
            angle: rotation * (math.pi / 180),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text(
                'LP-History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              content: SizedBox(
                width: 250,
                height: 300,
                child: Column(
                  children: [
                    Expanded(
                      child: lpHistory.isEmpty
                          ? const Center(
                              child: Text(
                                'No history available',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: lpHistory.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.history,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  title: Text(
                                    'LP ${index + 1}: ${lpHistory[index]}',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
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
                _showPlayerDialog(context);
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
