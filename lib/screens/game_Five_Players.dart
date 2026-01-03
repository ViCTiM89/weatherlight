import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../widgets/animated_new_game_button.dart';
import '../widgets/player_widget.dart';
import '../constants.dart';
import '../game_helper.dart';

class FivePlayers extends StatefulWidget {
  const FivePlayers({required Key key}) : super(key: key);

  @override
  State<FivePlayers> createState() => _FivePlayersState();
}

class _FivePlayersState extends State<FivePlayers> {
  @override
  void initState() {
    super.initState();
    // Enable wakelock when entering the screen
    Wakelock.enable();
  }

  @override
  void dispose() {
    // Disable wakelock when leaving the screen
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient(),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: MyHomePage(
          key: ValueKey<String>('unique_key_game_Five_Players'),
          title: 'Game',
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
    const int playerCount = 5;

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double pmWidth = screenWidth / 2.5;
    double pmHeight = screenHeight / 10;
    double statusHeight = screenHeight / 7;
    double statusWidth = pmWidth / 2;
    double pmWidthP5 = screenWidth / 2.5;
    double pmHeightP5 = screenHeight / 6;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              // Capture the current context
              final currentContext = context;
              // Show confirmation dialog when close button is pressed
              bool confirmExit = await confirmExitDialog(currentContext);
              if (!mounted) return;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Player 2
                      RotatedBox(
                        quarterTurns: 2,
                        child: PlayerWidget(
                          key: player5Key,
                          pmHeight: pmHeight,
                          pmWidth: pmWidth,
                          statusHeight: statusHeight,
                          statusWidth: statusWidth,
                          initialCommanderName: p2,
                          initialLP: startingLife,
                          shadowIncrement: shadowIncrement,
                          shadowDecrement: shadowDecrement,
                          shadowStatus: shadowStatus,
                          initialColorPlayer: shadowStatus,
                          controller: _textController,
                          controllerName: _nameController,
                          playerCount: playerCount,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      //Player 1
                      RotatedBox(
                        key: player1Key,
                        quarterTurns: 2,
                        child: PlayerWidget(
                          pmHeight: pmHeight,
                          pmWidth: pmWidth,
                          statusHeight: statusHeight,
                          statusWidth: statusWidth,
                          initialCommanderName: p1,
                          initialLP: startingLife,
                          shadowIncrement: shadowIncrement,
                          shadowDecrement: shadowDecrement,
                          shadowStatus: shadowStatus,
                          initialColorPlayer: shadowStatus,
                          controller: _textController,
                          controllerName: _nameController,
                          playerCount: playerCount,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                    width: 5.0,
                  ),
                  AnimatedScaleButton(
                    onTap: () {
                      newGame(context, setState, startingLife, shadowStatus);
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Player 3
                      RotatedBox(
                        quarterTurns: 0,
                        child: PlayerWidget(
                          key: player3Key,
                          pmHeight: pmHeight,
                          pmWidth: pmWidth,
                          statusHeight: statusHeight,
                          statusWidth: statusWidth,
                          initialCommanderName: p3,
                          initialLP: startingLife,
                          shadowIncrement: shadowIncrement,
                          shadowDecrement: shadowDecrement,
                          shadowStatus: shadowStatus,
                          initialColorPlayer: shadowStatus,
                          controller: _textController,
                          controllerName: _nameController,
                          playerCount: playerCount,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Player 4
                      RotatedBox(
                        quarterTurns: 0,
                        child: PlayerWidget(
                          key: player4Key,
                          pmHeight: pmHeight,
                          pmWidth: pmWidth,
                          statusHeight: statusHeight,
                          statusWidth: statusWidth,
                          initialCommanderName: p4,
                          initialLP: startingLife,
                          shadowIncrement: shadowIncrement,
                          shadowDecrement: shadowDecrement,
                          shadowStatus: shadowStatus,
                          initialColorPlayer: shadowStatus,
                          controller: _textController,
                          controllerName: _nameController,
                          playerCount: playerCount,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Player 5
                  RotatedBox(
                    quarterTurns: 1,
                    child: PlayerWidget(
                      key: player5Key,
                      pmHeight: pmHeightP5,
                      pmWidth: pmWidthP5,
                      statusHeight: statusHeight,
                      statusWidth: statusWidth,
                      initialCommanderName: p5,
                      initialLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      initialColorPlayer: shadowStatus,
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
