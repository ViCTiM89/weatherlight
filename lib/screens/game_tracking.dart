import 'package:flutter/material.dart';
import '../game_helper.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await MongoService.init('Commanders');
    var results = await MongoService.fetchCommanders();
    setState(() {
      commanderNames = results.map((e) => e['name'] as String).toList();

      partnerNames = results
          .where((data) =>
              (data['keywords'].contains('Partner with') ||
                  data['keywords'].contains('Partner') ||
                  data['keywords'].contains("Doctor's companion")) ||
              data['type_line'] == "Legendary Enchantment — Background")
          .map((data) => data['name'].toString())
          .toList();

      companionNames = results
          .where((data) => data['keywords'].contains('Companion'))
          .map((data) => data['name'].toString())
          .toList();
      isLoading = false;
    });
    await MongoService.close();
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Track Your Games"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                final currentContext = context;
                bool confirmExit = await confirmExitDialog(currentContext);
                if (confirmExit) {
                  Navigator.of(currentContext).pop();
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CommanderTrackerWidget(
                      textFieldLabel: 'Commander',
                      optionalTextLabel: 'Partner/Background',
                      companionTextLabel: 'Companion',
                      autofillNames: commanderNames,
                      partnerAutofillNames: partnerNames,
                      companionAutofillNames: companionNames,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                  ],
                ),
        ),
      ),
    );
  }
}
