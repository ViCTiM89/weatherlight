import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/mongo_service.dart';
import '../utils/player_entry.dart';
import '../widgets/commander_tracker_widget.dart';

class CommanderGameTracking extends StatefulWidget {
  const CommanderGameTracking({Key? key}) : super(key: key);

  @override
  State<CommanderGameTracking> createState() => _CommanderGameTrackingState();
}

class _CommanderGameTrackingState extends State<CommanderGameTracking> {
  List<String> commanderNames = [];
  List<String> partnerNames = [];
  List<String> companionNames = [];

  final commander1Controller = TextEditingController();
  final partner1Controller = TextEditingController();
  final companion1Controller = TextEditingController();

  final commander1Focus = FocusNode();
  final partner1Focus = FocusNode();
  final companion1Focus = FocusNode();

  bool isWin1 = false;
  bool isPartner1 = false;
  bool isCompanion1 = false;

  final commander2Controller = TextEditingController();
  final partner2Controller = TextEditingController();
  final companion2Controller = TextEditingController();

  final commander2Focus = FocusNode();
  final partner2Focus = FocusNode();
  final companion2Focus = FocusNode();

  bool isWin2 = false;
  bool isPartner2 = false;
  bool isCompanion2 = false;

  final commander3Controller = TextEditingController();
  final partner3Controller = TextEditingController();
  final companion3Controller = TextEditingController();

  final commander3Focus = FocusNode();
  final partner3Focus = FocusNode();
  final companion3Focus = FocusNode();

  bool isWin3 = false;
  bool isPartner3 = false;
  bool isCompanion3 = false;

  final commander4Controller = TextEditingController();
  final partner4Controller = TextEditingController();
  final companion4Controller = TextEditingController();

  final commander4Focus = FocusNode();
  final partner4Focus = FocusNode();
  final companion4Focus = FocusNode();

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

  Future<bool> confirmDrawDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(drawTitle),
            content: const Text(drawDescription),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(drawConfirmationText),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _saveStats(List<Map<String, dynamic>> games) async {
    await MongoService.init('CommanderStats');

    for (var game in games) {
      await MongoService.upsertStats('CommanderStats', game);
    }

    await MongoService.close();
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (final controller in [
      commander1Controller,
      partner1Controller,
      companion1Controller,
      commander2Controller,
      partner2Controller,
      companion2Controller,
      commander3Controller,
      partner3Controller,
      companion3Controller,
      commander4Controller,
      partner4Controller,
      companion4Controller,
    ]) {
      controller.dispose();
    }

    for (final node in [
      commander1Focus,
      partner1Focus,
      companion1Focus,
      commander2Focus,
      partner2Focus,
      companion2Focus,
      commander3Focus,
      partner3Focus,
      companion3Focus,
      commander4Focus,
      partner4Focus,
      companion4Focus,
    ]) {
      node.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appBarColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
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
                    if (value) isWin2 = isWin3 = isWin4 = false;
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
                    if (value) isWin1 = isWin3 = isWin4 = false;
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
                    if (value) isWin1 = isWin2 = isWin4 = false;
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
                    if (value) isWin1 = isWin2 = isWin3 = false;
                  }),
                  onPartnerChanged: (value) =>
                      setState(() => isPartner4 = value),
                  onCompanionChanged: (value) =>
                      setState(() => isCompanion4 = value),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        decoration: buttonDecoration(),
                        child: const Center(
                          child: Text(
                            'Go back!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        final focusNodes = [
                          commander1Focus,
                          partner1Focus,
                          companion1Focus,
                          commander2Focus,
                          partner2Focus,
                          companion2Focus,
                          commander3Focus,
                          partner3Focus,
                          companion3Focus,
                          commander4Focus,
                          partner4Focus,
                          companion4Focus,
                        ];

                        final entries = [
                          PlayerEntry(
                            commander: commander1Controller.text,
                            isPartner: isPartner1,
                            partner: partner1Controller.text,
                            isCompanion: isCompanion1,
                            companion: companion1Controller.text,
                            isWin: isWin1,
                          ),
                          PlayerEntry(
                            commander: commander2Controller.text,
                            isPartner: isPartner2,
                            partner: partner2Controller.text,
                            isCompanion: isCompanion2,
                            companion: companion2Controller.text,
                            isWin: isWin2,
                          ),
                          PlayerEntry(
                            commander: commander3Controller.text,
                            isPartner: isPartner3,
                            partner: partner3Controller.text,
                            isCompanion: isCompanion3,
                            companion: companion3Controller.text,
                            isWin: isWin3,
                          ),
                          PlayerEntry(
                            commander: commander4Controller.text,
                            isPartner: isPartner4,
                            partner: partner4Controller.text,
                            isCompanion: isCompanion4,
                            companion: companion4Controller.text,
                            isWin: isWin4,
                          ),
                        ];

                        // Validate commander names
                        for (int i = 0; i < entries.length; i++) {
                          if (entries[i]
                              .commanderController
                              .text
                              .trim()
                              .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Commander name missing for Player ${i + 1}')),
                            );
                            FocusScope.of(context)
                                .requestFocus(focusNodes[i * 3]);
                            return;
                          }

                          if (entries[i].isPartner &&
                              entries[i]
                                  .partnerController
                                  .text
                                  .trim()
                                  .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Partner name missing for Player ${i + 1}')),
                            );
                            FocusScope.of(context)
                                .requestFocus(focusNodes[i * 3 + 1]);
                            return;
                          }

                          if (entries[i].isCompanion &&
                              entries[i]
                                  .companionController
                                  .text
                                  .trim()
                                  .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Companion name missing for Player ${i + 1}')),
                            );
                            FocusScope.of(context)
                                .requestFocus(focusNodes[i * 3 + 2]);
                            return;
                          }
                        }

                        final games = entries.map((e) {
                          final commanders = [
                            if (e.commanderController.text.trim().isNotEmpty)
                              e.commanderController.text.trim(),
                            if (e.isPartner &&
                                e.partnerController.text.trim().isNotEmpty)
                              e.partnerController.text.trim(),
                          ]..sort();

                          final companion = e.isCompanion
                              ? e.companionController.text.trim()
                              : null;

                          return {
                            'commander': commanders,
                            'companion': companion?.isNotEmpty == true
                                ? companion
                                : null,
                            'isWin': e.isWin,
                          };
                        }).toList();

                        if (!entries.any((e) => e.isWin)) {
                          if (!await confirmDrawDialog(context)) return;
                        }

                        _saveStats(games);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Game stats saved to database!'),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        decoration: buttonDecoration(),
                        child: const Center(
                          child: Text(
                            'Submit!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
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
