import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShowPlayerLPHistory {
  static void showLPHistoryDialog(BuildContext context, List<int> lpHistory) {
    RotatedBox? parentRotatedBox =
    context.findAncestorWidgetOfExactType<RotatedBox>();
    if (parentRotatedBox != null) {
      double rotation = parentRotatedBox.quarterTurns *
          270 %
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
              title: const Text(
                'LP-History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.deepPurpleAccent,
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
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
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
}
