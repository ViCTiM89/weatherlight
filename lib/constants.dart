import 'package:flutter/material.dart';
import 'package:weatherlight/widgets/player_widget.dart';

//constants for the PlayerWidget
// LP
const int startingLife = 40;
const int startingLifeDuel = 25;
int nLP1 = 40, nLP2 = 40, nLP3 = 40, nLP4 = 40, nLP5 = 40;

// Names
const String p1 = 'Player 1';
const String p2 = 'Player 2';
const String p3 = 'Player 3';
const String p4 = 'Player 4';
const String p5 = 'Player 5';

// Tracker
const String commander = 'Commander';
const String partner = 'Partner/Background';
const String companion = 'Companion';

const String drawTitle = 'Confirm Draw';
const String drawDescription =
    'There was no winner selected. Was this game a draw?';
const String drawConfirmationText = 'Yes, Save as Draw';

// Theme Colors
const Color appBarColor = Color(0xFF1E1E1E);
//Text colors
const Color shadowStatus = Colors.white24;
const Color shadowDecrement = Colors.red;
const Color shadowIncrement = Colors.green;

const Color shadowColorCommanderDamage = Colors.blue;
const Color poisonColor = Colors.green;
const Color experienceColor = Colors.deepOrange;
const Color energyColor = Colors.orangeAccent;
final Color infiniteColor = Colors.lightGreenAccent.shade400;
final Color koColor = Colors.red.shade700;

final player1Key = GlobalKey<PlayerWidgetState>();
final player2Key = GlobalKey<PlayerWidgetState>();
final player3Key = GlobalKey<PlayerWidgetState>();
final player4Key = GlobalKey<PlayerWidgetState>();
final player5Key = GlobalKey<PlayerWidgetState>();

late final List<GlobalKey<PlayerWidgetState>> playerKeys;

// Sizes
const double dialogButtonSize = 60;
//uris
String fetchAllDungeons = 'https://api.scryfall.com/cards/search?q=t%3Adungeon';
String fetchAllPlanes =
    'https://api.scryfall.com/cards/search?q=t%3Aplane+or+t%3Aphenomenon';
String fetchAnthology =
    'https://api.scryfall.com/cards/search?q=set%3Aopca+(t%3Aplane+or+t%3Aphenomenon)';
String fetchMOM =
    'https://api.scryfall.com/cards/search?q=set%3Amoc+(t%3Aplane+or+t%3Aphenomenon)';
String fetchWHO =
    'https://api.scryfall.com/cards/search?q=set%3Awho+(t%3Aplane+or+t%3Aphenomenon)';
String fetchAllBounties =
    'https://api.scryfall.com/cards/search?q=bounty+t%3Acard+o%3Abounty';

LinearGradient backgroundGradient() {
  return const LinearGradient(
    colors: [
      Color(0xFF5D54A4),
      Color(0xFF8F94FB),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}

BoxDecoration buttonDecoration() {
  return BoxDecoration(
    color: Colors.deepPurpleAccent,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 3,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

TextStyle labelStyle() {
  return const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.amberAccent,
    letterSpacing: 0.5,
  );
}

TextStyle appBarTextStyle() {
  return const TextStyle(
    color: Colors.white, // Use a light color for contrast
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.5,
  );
}

TextStyle hintTextStyle() {
  return const TextStyle(
    color: Colors.white,
    letterSpacing: 0.5,
  );
}

BoxDecoration inputBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2))
    ],
  );
}

RoundedRectangleBorder checkboxStyle() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4.0),
  );
}

InputDecoration textFieldStyle(String labelText) {
  return InputDecoration(
    labelText: labelText,
    border: const OutlineInputBorder(),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    filled: true,
    fillColor: Colors.grey[100],
  );
}
