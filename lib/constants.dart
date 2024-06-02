import 'package:flutter/material.dart';

//constants for the PlayerWidget
// LP
const int startingLife = 40;
int nLP1 = 40, nLP2 = 40, nLP3 = 40, nLP4 = 40, nLP5 = 40;

// Names
const String p1 = 'Player 1';
const String p2 = 'Player 2';
const String p3 = 'Player 3';
const String p4 = 'Player 4';
const String p5 = 'Player 5';

//Text colors
const Color shadowStatus = Colors.white24;
const Color shadowDecrement = Colors.red;
const Color shadowIncrement = Colors.green;

Color colorPlayer1 = Colors.white24;
Color colorPlayer2 = Colors.white24;
Color colorPlayer3 = Colors.white24;
Color colorPlayer4 = Colors.white24;
Color colorPlayer5 = Colors.white24;

const Color shadowColorCommanderDamage = Colors.blue;
const Color poisonColor = Colors.green;
const Color experienceColor = Colors.deepOrange;
const Color energyColor = Colors.orangeAccent;
final Color infiniteColor = Colors.lightGreenAccent.shade400;
final Color koColor = Colors.red.shade700;

//uris
String dungeonAndRing = 'https://api.scryfall.com/cards/search?q=(t%3Adungeon+r%3Ac)+or+(t%3Aemblem+AND++%22The+Ring%22+o%3Aring-bearer)&order=name';