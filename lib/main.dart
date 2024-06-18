import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'screens/bingo.dart';
import 'screens/bounty_game.dart';
import 'screens/game_Five_Players.dart';
import 'screens/game_four_players.dart';
import 'screens/game_three_players.dart';
import 'screens/game_two_players.dart';
import 'screens/mechanic_dungeons.dart';
import 'screens/mechanic_the_ring.dart';
import 'screens/plane_chase.dart';
import 'screens/route6.dart';

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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double buttonSize = screenWidth / 2.2;

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
                  _buildGameButton(
                    buttonSize,
                    'Life \n Counter',
                    'images/thb-250-plains.jpg',
                    () {
                      _showPlayerSelectionDialog(context);
                    },
                    shadowColor,
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  _buildGameButton(
                    buttonSize,
                    'Plane \n Chase',
                    'images/thb-251-island.jpg',
                    () {
                      _showPlaneSetSelectionDialog(context);
                    },
                    shadowColor,
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
                  _buildGameButton(
                    buttonSize,
                    'Bounty',
                    'images/thb-252-swamp.jpg',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BountyGame(
                            key: ValueKey<String>('unique_key_Bounty'),
                          ),
                        ),
                      );
                    },
                    shadowColor,
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  _buildGameButton(
                    buttonSize,
                    'Commander \n Bingo',
                    'images/thb-253-mountain.jpg',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommanderBingo(
                            key: ValueKey<String>('unique_key_Bingo'),
                          ),
                        ),
                      );
                    },
                    shadowColor,
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
                  _buildGameButton(
                    buttonSize,
                    'Reading the Card Does not explain the Card',
                    'images/thb-254-forest.jpg',
                    () {
                      _showMechanicSelectionDialog(context);
                    },
                    shadowColor,
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  _buildGameButton(
                    buttonSize,
                    'Nothing to see Here',
                    'images/wastes.jpg',
                    () {
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
                    shadowColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildGameButton(double buttonSize, String text,
      String imagePath, Function() onTap, Color shadowColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            text,
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
    );
  }
}

void _showPlayerSelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Select Number \n of Players",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThreePlayers(
                          key: ValueKey<String>(
                              'unique_key_for_gameThreePlayers'),
                        ),
                      ),
                    );
                  },
                  child: const Text("3 Players"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purpleAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TwoPlayers(
                          key:
                              ValueKey<String>('unique_key_for_gameTwoPlayers'),
                        ),
                      ),
                    );
                  },
                  child: const Text("2 Players"),
                ),
              ),
            ),
            // Add buttons for other player counts...
          ],
        ),
      );
    },
  );
}

void _showPlaneSetSelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Select Set of Planes \n You Want to Play with",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity, // Ensures uniform button width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaneChase(
                          key: const ValueKey<String>(
                              'unique_key_for_Plane_Chase'),
                          apiUrl: fetchAllPlanes,
                        ),
                      ),
                    );
                  },
                  child: const Text("All Planes"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity, // Ensures uniform button width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaneChase(
                          key: const ValueKey<String>(
                              'unique_key_for_Plane_Chase'),
                          apiUrl: fetchAnthology,
                        ),
                      ),
                    );
                  },
                  child: const Text("Anthology"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity, // Ensures uniform button width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaneChase(
                          key: const ValueKey<String>(
                              'unique_key_for_Plane_Chase'),
                          apiUrl: fetchMOM,
                        ),
                      ),
                    );
                  },
                  child: const Text("March of the Machine"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity, // Ensures uniform button width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purpleAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaneChase(
                          key: const ValueKey<String>(
                              'unique_key_for_Plane_Chase'),
                          apiUrl: fetchWHO,
                        ),
                      ),
                    );
                  },
                  child: const Text("Dr Who"),
                ),
              ),
            ),
            // Add buttons for other player counts...
          ],
        ),
      );
    },
  );
}

void _showMechanicSelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Select Mechanic \n You Need An Explanation For",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity, // Ensures uniform button width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TheRing(
                          key: ValueKey<String>('unique_key_for_The_Ring'),
                        ),
                      ),
                    );
                  },
                  child: const Text("The Ring tempts You"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity, // Ensures uniform button width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dungeons(
                          key: ValueKey<String>('unique_key_for_Dungeons'),
                        ),
                      ),
                    );
                  },
                  child: const Text("Dungeons"),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
