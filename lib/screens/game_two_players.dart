import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../widgets/animated_new_game_button.dart';
import '../widgets/player_widget.dart';
import '../constants.dart';
import '../game_helper.dart';

class TwoPlayers extends StatefulWidget {
  const TwoPlayers({required Key key}) : super(key: key);

  @override
  State<TwoPlayers> createState() => _TwoPlayersState();
}

class _TwoPlayersState extends State<TwoPlayers> {
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
          key: ValueKey<String>('unique_key_for_gameTwoPlayers'),
          title: 'Testing',
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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double pmWidth = screenWidth / 2.3;
    double pmHeight = screenHeight / 5;
    double statusHeight = screenHeight / 4;
    double statusWidth = pmWidth / 2;
    const int playerCount = 2;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
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
                if (!mounted) return;
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      //Player 1
                      RotatedBox(
                        quarterTurns: 2,
                        child: PlayerWidget(
                          pmHeight: pmHeight,
                          pmWidth: pmWidth,
                          statusHeight: statusHeight,
                          statusWidth: statusWidth,
                          initialCommanderName: p1,
                          initialLP: startingLifeDuel,
                          shadowIncrement: shadowIncrement,
                          shadowDecrement: shadowDecrement,
                          shadowStatus: shadowStatus,
                          initialColorPlayer: colorPlayer1,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      // Player 2
                      RotatedBox(
                        quarterTurns: 0,
                        child: PlayerWidget(
                          pmHeight: pmHeight,
                          pmWidth: pmWidth,
                          statusHeight: statusHeight,
                          statusWidth: statusWidth,
                          initialCommanderName: p2,
                          initialLP: startingLifeDuel,
                          shadowIncrement: shadowIncrement,
                          shadowDecrement: shadowDecrement,
                          shadowStatus: shadowStatus,
                          initialColorPlayer: colorPlayer2,
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
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedScaleButton(
                    onTap: () {
                      newGame(context, setState, startingLife, shadowStatus);
                    },
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
