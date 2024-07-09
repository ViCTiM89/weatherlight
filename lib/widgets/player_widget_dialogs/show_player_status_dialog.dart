import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:weatherlight/widgets/player_widget_dialogs/show_player_lp_history_dialog.dart';

class ShowPlayerStatusDialog {
  static void showPlayerDialog(
    BuildContext context,
    List<int> cmdDamage,
    List<int> lifeHistory,
    int playerCount,
    bool knockOut,
    bool infinite,
    void Function(int) updateLP,
    void Function(int, int) updateCD,
    void Function(int, int) updatePlayerCounters,
    List<int> playerCounters,
    // void Function(int) updatePoison,
    // void Function(int) updateExperience,
    // void Function(int) updateEnergy,
    // void Function(int) updateRadiation,
    Color shadowColor,
    Color poisonColor,
    Color experienceColor,
    Color energyColor,
    Color radiationColor,
  ) {
    RotatedBox? parentRotatedBox =
        context.findAncestorWidgetOfExactType<RotatedBox>();
    if (parentRotatedBox != null) {
      double rotation = parentRotatedBox.quarterTurns *
          90 %
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
                                      ShowPlayerLPHistory.showLPHistoryDialog(
                                          context, lifeHistory);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        // Background color
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
                                      i < playerCount;
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
                                              if (!knockOut && !infinite) {
                                                updateLP(-1);
                                              }
                                              updateCD(i, 1);
                                            });
                                          },
                                          onLongPress: () {
                                            setState(() {
                                              if (!knockOut && !infinite) {
                                                updateLP(1);
                                              }
                                              updateCD(i, -1);
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
                                                        color: shadowColor,
                                                        blurRadius: 3 * i,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 80, width: 10),
                                        if (i + 1 < playerCount)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (!infinite) {
                                                  updateLP(-1);
                                                }
                                                updateCD(i + 1, 1);
                                              });
                                            },
                                            onLongPress: () {
                                              setState(() {
                                                if (!knockOut && !infinite) {
                                                  updateLP(1);
                                                }
                                                updateCD(i + 1, -1);
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
                                                          color: shadowColor,
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
                                        //updatePoison(1);
                                        updatePlayerCounters(0, 1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        //updatePoison(-1);
                                        updatePlayerCounters(1, -1);
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
                                          '${playerCounters[0]}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: poisonColor,
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
                                        //updateExperience(1);
                                        updatePlayerCounters(1, 1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        //updateExperience(-1);
                                        updatePlayerCounters(1, -1);
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
                                          '${playerCounters[1]}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: experienceColor,
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
                                        //updateEnergy(1);
                                        updatePlayerCounters(2, 1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        //updateEnergy(-1);
                                        updatePlayerCounters(2, -1);
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
                                          '${playerCounters[2]}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: energyColor,
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
                                        //updateRadiation(1);
                                        updatePlayerCounters(3, 1);
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        //updateRadiation(-1);
                                        updatePlayerCounters(3, -1);
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
                                          '${playerCounters[3]}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 45,
                                            color:
                                                Colors.white24.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              for (double i = 1; i < 10; i++)
                                                Shadow(
                                                  color: radiationColor,
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
}