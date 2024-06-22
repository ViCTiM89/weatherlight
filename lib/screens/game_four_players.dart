import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../game_helper.dart';
import '../widgets/player_widget.dart';
import '../constants.dart';

class FourPlayers extends StatefulWidget {
  const FourPlayers({required Key key}) : super(key: key);

  @override
  State<FourPlayers> createState() => _FourPlayersState();
}

class _FourPlayersState extends State<FourPlayers> {
  @override
  void initState() {
    super.initState();
    Wakelock.enable(); // Enable wakelock when entering the screen
  }

  @override
  void dispose() {
    Wakelock.disable(); // Disable wakelock when leaving the screen
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
            Colors.greenAccent,
          ],
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: MyHomePage(
          key: ValueKey<String>('unique_key_for_gameFourPlayers'),
          title: 'Four Players',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double pmWidth = screenWidth / 2.4;
    double pmHeight = screenHeight / 7;
    double statusHeight = screenHeight / 7;
    double statusWidth = pmWidth / 2;
    const int playerCount = 4;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('4 Players'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              // Capture the current context
              final currentContext = context;
              // Show confirmation dialog when close button is pressed
              bool confirmExit = await confirmExitDialog(currentContext);
              if (confirmExit) {
                Navigator.of(currentContext).pop();
              }
            },
          )
        ],
      ),
      backgroundColor: Colors.white10,
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 2,
                    child: PlayerWidget(
                      pmHeight: pmHeight,
                      pmWidth: pmWidth,
                      statusHeight: statusHeight,
                      statusWidth: statusWidth,
                      commanderName: p2,
                      initialCommanderName: "Player 2",
                      nLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      colorPlayer: colorPlayer2,
                      controller: _textController,
                      controllerName: _nameController,
                      playerCount: playerCount,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RotatedBox(
                    quarterTurns: 2,
                    child: PlayerWidget(
                      pmHeight: pmHeight,
                      pmWidth: pmWidth,
                      statusHeight: statusHeight,
                      statusWidth: statusWidth,
                      commanderName: p1,
                      initialCommanderName: "Player 1",
                      nLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      colorPlayer: colorPlayer1,
                      controller: _textController,
                      controllerName: _nameController,
                      playerCount: playerCount,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  newGame(context, setState, startingLife, shadowStatus);
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2), // Shadow position
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      height: 46.0,
                      width: 46.0,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 0,
                    child: PlayerWidget(
                      pmHeight: pmHeight,
                      pmWidth: pmWidth,
                      statusHeight: statusHeight,
                      statusWidth: statusWidth,
                      commanderName: p3,
                      initialCommanderName: "Player 3",
                      nLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      colorPlayer: colorPlayer3,
                      controller: _textController,
                      controllerName: _nameController,
                      playerCount: playerCount,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RotatedBox(
                    quarterTurns: 0,
                    child: PlayerWidget(
                      pmHeight: pmHeight,
                      pmWidth: pmWidth,
                      statusHeight: statusHeight,
                      statusWidth: statusWidth,
                      commanderName: p4,
                      initialCommanderName: "Player 4",
                      nLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      colorPlayer: colorPlayer4,
                      controller: _textController,
                      controllerName: _nameController,
                      playerCount: playerCount,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
