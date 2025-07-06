import 'dart:async';
import 'package:flutter/material.dart';

import '../services/mongo_service.dart';

class CommanderTrackerWidget extends StatefulWidget {
  final String textFieldLabel;
  final String optionalTextLabel;
  final String companionTextLabel;
  final List<String> autofillNames;
  final List<String> partnerAutofillNames;
  final List<String> companionAutofillNames;

  const CommanderTrackerWidget({
    required this.textFieldLabel,
    required this.optionalTextLabel,
    required this.companionTextLabel,
    this.autofillNames = const [],
    this.partnerAutofillNames = const [],
    this.companionAutofillNames = const [],
    Key? key,
  }) : super(key: key);

  @override
  _CommanderTrackerWidgetState createState() => _CommanderTrackerWidgetState();
}

class _CommanderTrackerWidgetState extends State<CommanderTrackerWidget> {
  bool _isPartnerChecked = false;
  bool _isCompanionChecked = false;
  bool _isWinChecked = false;
  List<String> _commanderSuggestions = [];
  Timer? _debounce;
  final double _rowBoxHeight = 12;

  final TextEditingController _commanderController = TextEditingController();
  final TextEditingController _companionController = TextEditingController();
  final TextEditingController _partnerController =
      TextEditingController(); // Controller for partner field

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await MongoService.searchCommanders(query);
      setState(() {
        _commanderSuggestions = results;
      });
    });
  }

  BoxDecoration _inputBoxDecoration() {
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

  TextStyle _labelStyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.amberAccent,
      letterSpacing: 0.5,
    );
  }

  RoundedRectangleBorder _checkboxStyle() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  InputDecoration _textfieldStyle(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      filled: true,
      fillColor: Colors.grey[100],
    );
  }

  Iterable<String> _commanderOptionsBuilder(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
    return _commanderSuggestions.where((name) =>
        name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double inputFieldWidth = screenWidth > 600 ? 250 : screenWidth * 0.6;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Commander Row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                shape: _checkboxStyle(),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: Colors.white),
                ),
                value: _isWinChecked,
                onChanged: (value) {
                  setState(() {
                    _isWinChecked = value!;
                  });
                },
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(
                width: 70,
                child: Text(
                  "Win",
                  style: _labelStyle(),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: inputFieldWidth,
                  decoration: _inputBoxDecoration(),
                  child: Autocomplete<String>(
                    optionsBuilder: _commanderOptionsBuilder,
                    onSelected: (selection) =>
                        _commanderController.text = selection,
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = _commanderController.text;
                      controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length),
                      );
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: _textfieldStyle(widget.textFieldLabel),
                        onChanged: (text) {
                          _commanderController.text = text;
                          _onSearchChanged(text);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: _rowBoxHeight),
          // Partner Row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                shape: _checkboxStyle(),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: Colors.white),
                ),
                value: _isPartnerChecked,
                onChanged: (value) {
                  setState(() {
                    _isPartnerChecked = value!;
                  });
                },
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(
                width: 70,
                child: Text(
                  'Partner',
                  style: _labelStyle(),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _isPartnerChecked
                    ? Container(
                        width: inputFieldWidth,
                        decoration: _inputBoxDecoration(),
                        child: Autocomplete<String>(
                          optionsBuilder: _commanderOptionsBuilder,
                          onSelected: (String selection) {
                            _partnerController.text = selection;
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration:
                                  _textfieldStyle(widget.optionalTextLabel),
                              onSubmitted: (value) => onFieldSubmitted(),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
          SizedBox(height: _rowBoxHeight),
          // Companion Row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                shape: _checkboxStyle(),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: Colors.white),
                ),
                value: _isCompanionChecked,
                onChanged: (value) {
                  setState(() {
                    _isCompanionChecked = value!;
                  });
                },
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(
                width: 80,
                child: Text(
                  "Companion",
                  style: _labelStyle(),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: _isCompanionChecked
                    ? Container(
                        width: inputFieldWidth,
                        decoration: _inputBoxDecoration(),
                        child: Autocomplete<String>(
                          optionsBuilder: _commanderOptionsBuilder,
                          onSelected: (String selection) {
                            _companionController.text = selection;
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration:
                                  _textfieldStyle(widget.companionTextLabel),
                              onSubmitted: (value) => onFieldSubmitted(),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
