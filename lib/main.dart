import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherlight/bingo.dart';
import 'package:weatherlight/game_four_players.dart';
import 'package:weatherlight/game_two_players.dart';
import 'package:weatherlight/game_three_players.dart';
import 'package:weatherlight/game_Five_Players.dart';
import 'package:weatherlight/plane_chase.dart';
import 'package:weatherlight/route3.dart';
import 'package:weatherlight/route6.dart';

import 'bounty_game.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Weatherlight',
      home: FirstRoute(
        key: ValueKey<String>('unique_key_for_FirstRoute'),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color shadowColor = Colors.blueAccent.shade700;
    Color shadowColor = Colors.white12;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.blue,
            Colors.red,
            Colors.green,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Weatherlight'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("images/thb-250-plains.jpg"),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Text(
                          'Life \n Counter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white24.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              for (double i = 1; i < 10; i++)
                                Shadow(
                                  color: shadowColor,
                                  blurRadius: 3 * i,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _showPlayerSelectionDialog(context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("images/thb-251-island.jpg"),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Text(
                          'Plane Chase',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white24.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              for (double i = 1; i < 10; i++)
                                Shadow(
                                  color: shadowColor,
                                  blurRadius: 3 * i,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaneChase(
                            key: ValueKey<String>(
                                'unique_key_for_planeChase'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("images/thb-252-swamp.jpg"),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Text(
                          'Bounty',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white24.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              for (double i = 1; i < 10; i++)
                                Shadow(
                                  color: shadowColor,
                                  blurRadius: 3 * i,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BountyGame(
                            key: ValueKey<String>(
                              'unique_key_Bounty',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("images/thb-253-mountain.jpg"),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Text(
                          'Commander \n Bingo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white24.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              for (double i = 1; i < 10; i++)
                                Shadow(
                                  color: shadowColor,
                                  blurRadius: 3 * i,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommanderBingo(
                            key: ValueKey<String>(
                                'unique_key_Bingo'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("images/thb-254-forest.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestingPage(
                            key: ValueKey<String>(
                              'unique_key_for_ThirdRoute',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("images/wastes.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FourthRoute(
                            key: ValueKey<String>(
                              'unique_key_for_gameFourPlayers',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showPlayerSelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Select Number \n of Players",
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FourPlayers(
                      key: ValueKey<String>(
                        'unique_key_for_gameFourPlayers',
                      ),
                    ),
                  ),
                );
              },
              child: const Text("4 Players"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThreePlayers(
                      key: ValueKey<String>('unique_key_for_gameThreePlayers'),
                    ),
                  ),
                );
              },
              child: const Text("3 Players"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FivePlayers(
                      key: ValueKey<String>('unique_key_game_Five_Players'),
                    ),
                  ),
                );
              },
              child: const Text("5 Players"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TwoPlayers(
                      key: ValueKey<String>('unique_key_for_gameTwoPlayers'),
                    ),
                  ),
                );
              },
              child: const Text("2 Players"),
            ),
            // Add buttons for other player counts...
          ],
        ),
      );
    },
  );
}
