import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../game_helper.dart';
import '../widgets/animated_new_game_button.dart';
import '../widgets/app_bar_widget.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  int activePlayerIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double pmWidth = screenWidth / 2.1;
    double pmHeight = screenHeight / 7;
    double statusHeight = screenHeight / 7;
    const int playerCount = 4;

    void onPlayerStopped(int index) {
      setState(() {
        activePlayerIndex = (index + 1) % playerCount;
      });
    }

    return Scaffold(
      appBar: const SharedAppBar(
        backgroundColor: appBarColor,
      ),
      backgroundColor: Colors.white10,
      body: Center(
        child: Stack(
          children: [
            Center(
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
                            key: player2Key,
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            initialCommanderName: p2,
                            initialLP: startingLife,
                            shadowIncrement: shadowIncrement,
                            shadowDecrement: shadowDecrement,
                            shadowStatus: shadowStatus,
                            initialColorPlayer: shadowStatus,
                            controller: _textController,
                            playerCount: playerCount,
                            isActive: activePlayerIndex == 1,
                            onStopped: () => onPlayerStopped(1),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RotatedBox(
                          quarterTurns: 2,
                          child: PlayerWidget(
                            key: player1Key,
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            initialCommanderName: p1,
                            initialLP: startingLife,
                            shadowIncrement: shadowIncrement,
                            shadowDecrement: shadowDecrement,
                            shadowStatus: shadowStatus,
                            initialColorPlayer: shadowStatus,
                            controller: _textController,
                            playerCount: playerCount,
                            isActive: activePlayerIndex == 0,
                            onStopped: () => onPlayerStopped(0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: 0,
                          child: PlayerWidget(
                            key: player3Key,
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            initialCommanderName: p3,
                            initialLP: startingLife,
                            shadowIncrement: shadowIncrement,
                            shadowDecrement: shadowDecrement,
                            shadowStatus: shadowStatus,
                            initialColorPlayer: shadowStatus,
                            controller: _textController,
                            playerCount: playerCount,
                            isActive: activePlayerIndex == 2,
                            onStopped: () => onPlayerStopped(2),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RotatedBox(
                          quarterTurns: 0,
                          child: PlayerWidget(
                            key: player4Key,
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            initialCommanderName: p4,
                            initialLP: startingLife,
                            shadowIncrement: shadowIncrement,
                            shadowDecrement: shadowDecrement,
                            shadowStatus: shadowStatus,
                            initialColorPlayer: shadowStatus,
                            controller: _textController,
                            playerCount: playerCount,
                            isActive: activePlayerIndex == 3,
                            onStopped: () => onPlayerStopped(3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: AnimatedScaleButton(
                onTap: () {
                  newGame(context, setState, startingLife, shadowStatus);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
