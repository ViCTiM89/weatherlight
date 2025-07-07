import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherlight/game_helper.dart';
import 'dart:convert';

import '../services/mongo_service.dart';
import '../widgets/commander_tracker_widget.dart';

class CommanderGamerTracking extends StatefulWidget {
  const CommanderGamerTracking({Key? key}) : super(key: key);

  @override
  State<CommanderGamerTracking> createState() => _CommanderGamerTrackingState();
}

class _CommanderGamerTrackingState extends State<CommanderGamerTracking> {
  List<String> commanderNames = [];
  List<String> partnerNames = [];
  List<String> companionNames = [];

  final commander1Controller = TextEditingController();
  final partner1Controller = TextEditingController();
  final companion1Controller = TextEditingController();
  bool isWin1 = false;
  bool isPartner1 = false;
  bool isCompanion1 = false;

  final commander2Controller = TextEditingController();
  final partner2Controller = TextEditingController();
  final companion2Controller = TextEditingController();
  bool isWin2 = false;
  bool isPartner2 = false;
  bool isCompanion2 = false;

  final commander3Controller = TextEditingController();
  final partner3Controller = TextEditingController();
  final companion3Controller = TextEditingController();
  bool isWin3 = false;
  bool isPartner3 = false;
  bool isCompanion3 = false;

  final commander4Controller = TextEditingController();
  final partner4Controller = TextEditingController();
  final companion4Controller = TextEditingController();
  bool isWin4 = false;
  bool isPartner4 = false;
  bool isCompanion4 = false;

  @override
  void initState() {
    super.initState();
    _initializeMongo();
  }

  void _initializeMongo() async {
    await MongoService.init('Commanders');
  }

  void _saveStats(List<Map<String, dynamic>> games) async {
    await MongoService.init('CommanderStats');
    await MongoService.insertMany('CommanderStats', games);
  }

  @override
  void dispose() {
    commander1Controller.dispose();
    partner1Controller.dispose();
    companion1Controller.dispose();

    commander2Controller.dispose();
    partner2Controller.dispose();
    companion2Controller.dispose();

    commander3Controller.dispose();
    partner3Controller.dispose();
    companion3Controller.dispose();

    commander4Controller.dispose();
    partner4Controller.dispose();
    companion4Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.lightBlueAccent,
            Colors.deepPurpleAccent,
            Colors.greenAccent
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommanderTrackerWidget(
                  textFieldLabel: 'Commander',
                  optionalTextLabel: 'Partner/Background',
                  companionTextLabel: 'Companion',
                  autofillNames: commanderNames,
                  partnerAutofillNames: partnerNames,
                  companionAutofillNames: companionNames,
                  commanderController: commander1Controller,
                  partnerController: partner1Controller,
                  companionController: companion1Controller,
                  isWin: isWin1,
                  onWinChanged: (value) => setState(() {
                    isWin1 = value;
                    if (value) {
                      isWin2 = false;
                      isWin3 = false;
                      isWin4 = false;
                    }
                  }),
                  onPartnerChanged: (value) =>
                      setState(() => isPartner1 = value),
                  onCompanionChanged: (value) =>
                      setState(() => isCompanion1 = value),
                ),
                CommanderTrackerWidget(
                  textFieldLabel: 'Commander',
                  optionalTextLabel: 'Partner/Background',
                  companionTextLabel: 'Companion',
                  autofillNames: commanderNames,
                  partnerAutofillNames: partnerNames,
                  companionAutofillNames: companionNames,
                  commanderController: commander2Controller,
                  partnerController: partner2Controller,
                  companionController: companion2Controller,
                  isWin: isWin2,
                  onWinChanged: (value) => setState(() {
                    isWin2 = value;
                    if (value) {
                      isWin1 = false;
                      isWin3 = false;
                      isWin4 = false;
                    }
                  }),
                  onPartnerChanged: (value) =>
                      setState(() => isPartner2 = value),
                  onCompanionChanged: (value) =>
                      setState(() => isCompanion2 = value),
                ),
                CommanderTrackerWidget(
                  textFieldLabel: 'Commander',
                  optionalTextLabel: 'Partner/Background',
                  companionTextLabel: 'Companion',
                  autofillNames: commanderNames,
                  partnerAutofillNames: partnerNames,
                  companionAutofillNames: companionNames,
                  commanderController: commander3Controller,
                  partnerController: partner3Controller,
                  companionController: companion3Controller,
                  isWin: isWin3,
                  onWinChanged: (value) => setState(() {
                    isWin3 = value;
                    if (value) {
                      isWin1 = false;
                      isWin2 = false;
                      isWin4 = false;
                    }
                  }),
                  onPartnerChanged: (value) =>
                      setState(() => isPartner3 = value),
                  onCompanionChanged: (value) =>
                      setState(() => isCompanion3 = value),
                ),
                CommanderTrackerWidget(
                  textFieldLabel: 'Commander',
                  optionalTextLabel: 'Partner/Background',
                  companionTextLabel: 'Companion',
                  autofillNames: commanderNames,
                  partnerAutofillNames: partnerNames,
                  companionAutofillNames: companionNames,
                  commanderController: commander4Controller,
                  partnerController: partner4Controller,
                  companionController: companion4Controller,
                  isWin: isWin4,
                  onWinChanged: (value) => setState(() {
                    isWin4 = value;
                    if (value) {
                      isWin1 = false;
                      isWin2 = false;
                      isWin3 = false;
                    }
                  }),
                  onPartnerChanged: (value) =>
                      setState(() => isPartner4 = value),
                  onCompanionChanged: (value) =>
                      setState(() => isCompanion4 = value),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final currentContext = context;
                        bool confirmExit =
                            await confirmExitDialog(currentContext);
                        if (confirmExit) {
                          Navigator.of(currentContext).pop();
                        }
                      },
                      child: Container(
                        height: 50.0,
                        width: 150.0,
                        decoration: BoxDecoration(
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
                        ),
                        child: const Center(
                          child: Text(
                            'Go back!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        List<Map<String, dynamic>> games = [];

                        void addGame({
                          required TextEditingController commanderController,
                          required bool isPartner,
                          required TextEditingController partnerController,
                          required bool isCompanion,
                          required TextEditingController companionController,
                          required bool isWin,
                        }) {
                          List<String> partners = [];

                          if (commanderController.text.trim().isNotEmpty) {
                            partners.add(commanderController.text.trim());
                          }
                          if (isPartner &&
                              partnerController.text.trim().isNotEmpty) {
                            partners.add(partnerController.text.trim());
                          }

                          if (partners.isEmpty)
                            return; // Skip if no valid names

                          partners.sort(); // Alphabetical order

                          String? companion;
                          if (isCompanion &&
                              companionController.text.trim().isNotEmpty) {
                            companion = companionController.text.trim();
                          }

                          games.add({
                            'commander': partners,
                            'companion': companion,
                            'isWin': isWin,
                          });
                        }

                        // Add each game if filled:
                        addGame(
                          commanderController: commander1Controller,
                          isPartner: isPartner1,
                          partnerController: partner1Controller,
                          isCompanion: isCompanion1,
                          companionController: companion1Controller,
                          isWin: isWin1,
                        );

                        addGame(
                          commanderController: commander2Controller,
                          isPartner: isPartner2,
                          partnerController: partner2Controller,
                          isCompanion: isCompanion2,
                          companionController: companion2Controller,
                          isWin: isWin2,
                        );

                        addGame(
                          commanderController: commander3Controller,
                          isPartner: isPartner3,
                          partnerController: partner3Controller,
                          isCompanion: isCompanion3,
                          companionController: companion3Controller,
                          isWin: isWin3,
                        );

                        addGame(
                          commanderController: commander4Controller,
                          isPartner: isPartner4,
                          partnerController: partner4Controller,
                          isCompanion: isCompanion4,
                          companionController: companion4Controller,
                          isWin: isWin4,
                        );

                        print(jsonEncode(games));
                        String jsonData = jsonEncode(games);
                      },
                      child: Container(
                        height: 50.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Print Texts',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
