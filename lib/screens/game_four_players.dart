import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../game_helper.dart';
import '../widgets/animated_new_game_button.dart';
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
    Wakelock.enable();
  }

  @override
  void dispose() {
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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
                      initialCommanderName: "Player 2",
                      initialLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      initialColorPlayer: colorPlayer2,
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
                      initialCommanderName: "Player 1",
                      initialLP: startingLife,
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
              AnimatedScaleButton(
                onTap: () {
                  newGame(context, setState, startingLife, shadowStatus);
                },
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
                      initialCommanderName: "Player 3",
                      initialLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      initialColorPlayer: colorPlayer3,
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
                      initialCommanderName: "Player 4",
                      initialLP: startingLife,
                      shadowIncrement: shadowIncrement,
                      shadowDecrement: shadowDecrement,
                      shadowStatus: shadowStatus,
                      initialColorPlayer: colorPlayer4,
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
