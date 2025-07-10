import 'package:flutter/material.dart';

class PlayerEntry {
  final TextEditingController commanderController;
  bool isPartner;
  final TextEditingController partnerController;
  bool isCompanion;
  final TextEditingController companionController;
  bool isWin;

  PlayerEntry({
    String commander = '',
    this.isPartner = false,
    String partner = '',
    this.isCompanion = false,
    String companion = '',
    this.isWin = false,
  })  : commanderController = TextEditingController(text: commander),
        partnerController = TextEditingController(text: partner),
        companionController = TextEditingController(text: companion);

  void dispose() {
    commanderController.dispose();
    partnerController.dispose();
    companionController.dispose();
  }

  Map<String, dynamic> toMap() {
    return {
      'commander': commanderController.text,
      'isPartner': isPartner,
      'partner': partnerController.text,
      'isCompanion': isCompanion,
      'companion': companionController.text,
      'isWin': isWin,
    };
  }

  factory PlayerEntry.fromMap(Map<String, dynamic> map) {
    return PlayerEntry(
      commander: map['commander'] ?? '',
      isPartner: map['isPartner'] ?? false,
      partner: map['partner'] ?? '',
      isCompanion: map['isCompanion'] ?? false,
      companion: map['companion'] ?? '',
      isWin: map['isWin'] ?? false,
    );
  }
}
