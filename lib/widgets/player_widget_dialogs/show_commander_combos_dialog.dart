import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../constants.dart';
import '../../services/commander_spellbook_service.dart';
import '../combos_card.dart';

class ShowCommanderCombos {
  static Future<void> showCommanderCombosDialog(
      BuildContext context, List<String> commanderNames, parentRotation) async {
    double rotationInRadians = (parentRotation - 90.0) * (math.pi / 180);

    List<Map<String, dynamic>> combos = [];
    bool isLoading = true;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: rotationInRadians, // Apply the correct rotation
          child: ClipRect(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SizedBox(
                width: 450,
                height: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Combos for entered Commanders:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.deepPurpleAccent),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: commanderNames.isEmpty
                          ? const Center(
                              child: Text(
                                'No Commanders entered',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey),
                              ),
                            )
                          : StatefulBuilder(
                              builder: (context, setStateDialog) {
                                if (isLoading) {
                                  fetchCombosByCommander(commanderNames.first)
                                      .then((result) {
                                    setStateDialog(() {
                                      combos = result;
                                      isLoading = false;
                                    });
                                  });
                                }
                                return SingleChildScrollView(
                                  child: CombosCard(
                                    combos: combos,
                                    isLoading: isLoading,
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
                        decoration: buttonDecoration(),
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
          ),
        );
      },
    );
  }
}
