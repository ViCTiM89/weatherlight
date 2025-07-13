import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'screens/game_tracking.dart';
import 'screens/bounty_game.dart';
import 'screens/game_Five_Players.dart';
import 'screens/game_four_players.dart';
import 'screens/game_three_players.dart';
import 'screens/game_two_players.dart';
import 'screens/mechanic_dungeons.dart';
import 'screens/mechanic_the_ring.dart';
import 'screens/plane_chase.dart';
import 'screens/statistics_page.dart';

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

class WeatherlightApp extends StatelessWidget {
  const WeatherlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weatherlight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      home: const FirstRoute(key: ValueKey('first_route')),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final size = MediaQuery.of(context).size;
    final buttonSize = size.width / 2.3;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Weatherlight',
          style: appBarTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: appBarColor, // Dark purple tone
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient(),
        ),
        child: Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _GameButton(
                size: buttonSize,
                text: 'Life\nCounter',
                imagePath: 'images/thb-250-plains.jpg',
                onTap: () => _showPlayerSelectionDialog(context),
              ),
              _GameButton(
                size: buttonSize,
                text: 'Plane\nChase',
                imagePath: 'images/thb-251-island.jpg',
                onTap: () => _showPlaneSetSelectionDialog(context),
              ),
              _GameButton(
                size: buttonSize,
                text: 'Bounty',
                imagePath: 'images/thb-252-swamp.jpg',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const BountyGame(key: ValueKey('bounty_game'))));
                },
              ),
              _GameButton(
                size: buttonSize,
                text: 'Reading the Card Does Not Explain the Card',
                imagePath: 'images/thb-253-mountain.jpg',
                onTap: () => _showMechanicSelectionDialog(context),
              ),
              _GameButton(
                size: buttonSize,
                text: 'Track Games',
                imagePath: 'images/thb-254-forest.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CommanderGameTracking(
                        key: ValueKey('commander_tracking'),
                      ),
                    ),
                  );
                },
              ),
              _GameButton(
                size: buttonSize,
                text: 'Commander\nStatistics',
                imagePath: 'images/wastes.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StatisticsPage(
                        key: ValueKey('statistics_page'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameButton extends StatelessWidget {
  final double size;
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const _GameButton({
    required this.size,
    required this.text,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.darken,
            ),
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 28,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
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
