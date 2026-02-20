import 'dart:async';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/mongo_service.dart';

class CommanderTrackerWidget extends StatefulWidget {
  final String textFieldLabel;
  final String optionalTextLabel;
  final String companionTextLabel;
  final List<String> autofillNames;
  final List<String> partnerAutofillNames;
  final List<String> companionAutofillNames;
  final TextEditingController commanderController;
  final TextEditingController companionController;
  final TextEditingController partnerController;
  final ValueChanged<bool>? onWinChanged;
  final ValueChanged<bool>? onPartnerChanged;
  final ValueChanged<bool>? onCompanionChanged;
  final bool isWin;

  const CommanderTrackerWidget({
    Key? key,
    required this.textFieldLabel,
    required this.optionalTextLabel,
    required this.companionTextLabel,
    required this.commanderController,
    required this.partnerController,
    required this.companionController,
    required this.isWin,
    this.autofillNames = const [],
    this.partnerAutofillNames = const [],
    this.companionAutofillNames = const [],
    this.onWinChanged,
    this.onPartnerChanged,
    this.onCompanionChanged,
  }) : super(key: key);

  @override
  State<CommanderTrackerWidget> createState() => _CommanderTrackerWidgetState();
}

class _CommanderTrackerWidgetState extends State<CommanderTrackerWidget> {
  bool _isPartnerChecked = false;
  bool _isCompanionChecked = false;
  bool _isWinChecked = false;
  List<String> _commanderSuggestions = [];
  List<String> _partnerSuggestions = [];
  List<String> _companionSuggestions = [];
  Timer? _debounce;
  final double _rowBoxHeight = 12;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onCommanderSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await MongoService.searchCommanders(query);
      setState(() {
        _commanderSuggestions = results;
      });
    });
  }

  void _onPartnerSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await MongoService.searchPartners(
          query); // Replace with correct partner query if needed
      setState(() {
        _partnerSuggestions = results;
      });
    });
  }

  void _onCompanionSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await MongoService.searchCompanions(query);
      setState(() {
        _companionSuggestions = results;
      });
    });
  }

  Iterable<String> _commanderOptionsBuilder(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return _commanderSuggestions;
  }

  Iterable<String> _partnerOptionsBuilder(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return _partnerSuggestions;
  }

  Iterable<String> _companionOptionsBuilder(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return _companionSuggestions;
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
          // Commander Row
          Row(
            children: [
              Expanded(
                child: Container(
                  width: inputFieldWidth,
                  decoration: inputBoxDecoration(),
                  child: Autocomplete<String>(
                    optionsBuilder: _commanderOptionsBuilder,
                    onSelected: (selection) {
                      widget.commanderController.text = selection;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                      controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length),
                      );
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: textFieldStyle(widget.textFieldLabel),
                        onChanged: (text) {
                          widget.commanderController.text = text;
                          _onCommanderSearchChanged(text);
                        },
                        onSubmitted: (text) {
                          focusNode.unfocus();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: _rowBoxHeight),
          // Checkbox Row
          Row(
            children: [
              Checkbox(
                shape: checkboxStyle(),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: Colors.white),
                ),
                value: widget.isWin,
                onChanged: (value) {
                  setState(() {
                    _isWinChecked = value ?? false;
                  });
                  if (widget.onWinChanged != null) {
                    widget.onWinChanged!(_isWinChecked);
                  }
                },
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(
                width: 60,
                child: Text("Win", style: labelStyle()),
              ),
              Checkbox(
                shape: checkboxStyle(),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: Colors.white),
                ),
                value: _isPartnerChecked,
                onChanged: (value) {
                  setState(() {
                    _isPartnerChecked = value ?? false;
                  });
                  if (widget.onPartnerChanged != null) {
                    widget.onPartnerChanged!(_isPartnerChecked);
                  }
                },
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(
                width: 60,
                child: Text('Partner', style: labelStyle()),
              ),
              const SizedBox(width: 10),
              Checkbox(
                shape: checkboxStyle(),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: Colors.white),
                ),
                value: _isCompanionChecked,
                onChanged: (value) {
                  setState(() {
                    _isCompanionChecked = value ?? false;
                  });
                  if (widget.onCompanionChanged != null) {
                    widget.onCompanionChanged!(_isCompanionChecked);
                  }
                },
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(
                width: 80,
                child: Text('Companion', style: labelStyle()),
              ),
            ],
          ),
          // Partner Row
          Row(
            children: [
              Expanded(
                child: _isPartnerChecked
                    ? Container(
                        width: inputFieldWidth,
                        decoration: inputBoxDecoration(),
                        child: Autocomplete<String>(
                          optionsBuilder: _partnerOptionsBuilder,
                          onSelected: (selection) {
                            widget.partnerController.text = selection;
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: controller.text.length),
                            );
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration:
                                  textFieldStyle(widget.optionalTextLabel),
                              onChanged: (text) {
                                widget.partnerController.text = text;
                                _onPartnerSearchChanged(text);
                              },
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
            children: [
              Expanded(
                child: _isCompanionChecked
                    ? Container(
                        width: inputFieldWidth,
                        decoration: inputBoxDecoration(),
                        child: Autocomplete<String>(
                          optionsBuilder: _companionOptionsBuilder,
                          onSelected: (selection) {
                            widget.companionController.text = selection;
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: controller.text.length),
                            );
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration:
                                  textFieldStyle(widget.companionTextLabel),
                              onChanged: (text) {
                                widget.companionController.text = text;
                                _onCompanionSearchChanged(text);
                              },
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
