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
  List<String> _commanderSuggestions = [];
  Timer? _debounce;

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
          // Main Commander Input Field
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  width: inputFieldWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return _commanderSuggestions.where((name) => name
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (String selection) {
                      _commanderController.text = selection;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = _commanderController.text;
                      controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length),
                      );

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: widget.textFieldLabel,
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                        ),
                        onChanged: (text) {
                          _commanderController.text = text;
                          _onSearchChanged(text);
                        },
                      );
                    },
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Partner checkbox and label
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 2.0, color: Colors.white),
                        ),
                        value: _isPartnerChecked,
                        onChanged: (value) {
                          setState(() {
                            _isPartnerChecked = value!;
                          });
                        },
                        activeColor: Colors.deepPurpleAccent,
                      ),
                      const Text(
                        'Partner',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  // Companion checkbox and label
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 2.0, color: Colors.white),
                        ),
                        value: _isCompanionChecked,
                        onChanged: (value) {
                          setState(() {
                            _isCompanionChecked = value!;
                          });
                        },
                        activeColor: Colors.deepPurpleAccent,
                      ),
                      const Text(
                        "Companion",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Partner Input Field (only shown if checked)
          if (_isPartnerChecked)
            Container(
              width: inputFieldWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return widget.partnerAutofillNames.where((name) => name
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  _partnerController.text = selection;
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: widget.optionalTextLabel,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                    onSubmitted: (value) => onFieldSubmitted(),
                  );
                },
              ),
            ),

          // Companion Input Field (only shown if checked)
          if (_isCompanionChecked)
            Container(
              width: inputFieldWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return widget.companionAutofillNames.where((name) => name
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  _companionController.text = selection;
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: widget.companionTextLabel,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                    onSubmitted: (value) => onFieldSubmitted(),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
