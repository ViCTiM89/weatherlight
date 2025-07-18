import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../constants.dart';

class ShowPlayerLPHistory {
  static void showLPHistoryDialog(
      BuildContext context, List<int> lpHistory, parentRotation) {
    double rotationInRadians = (parentRotation - 90.0) * (math.pi / 180);

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: rotationInRadians, // Apply the correct rotation
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Center(
              child: Text(
                'LP-History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.deepPurpleAccent,
                ),
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
        );
      },
    );
  }
}
