import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../widgets/animated_new_game_button.dart';
import '../widgets/app_bar_widget.dart';
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
          key: ValueKey<String>('unique_key_game_five_players'),
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
  int activePlayerIndex = 0;

  @override
  Widget build(BuildContext context) {
    const int playerCount = 5;

    void onPlayerStopped(int index) {
      setState(() {
        activePlayerIndex = (index + 1) % playerCount;
      });
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double pmWidth = screenWidth / 2.1;
    double pmHeight = screenHeight / 10;
    double statusHeight = screenHeight / 7;
    double pmWidthP5 = screenWidth / 2.5;
    double pmHeightP5 = screenHeight / 6;
    double statusWidthP5 = screenHeight / 6;

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
                                controllerName: _nameController,
                                playerCount: playerCount,
                                isActive: activePlayerIndex == 1,
                                onStopped: () => onPlayerStopped(1),
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
                                initialCommanderName: p1,
                                initialLP: startingLife,
                                shadowIncrement: shadowIncrement,
                                shadowDecrement: shadowDecrement,
                                shadowStatus: shadowStatus,
                                initialColorPlayer: shadowStatus,
                                controller: _textController,
                                controllerName: _nameController,
                                playerCount: playerCount,
                                isActive: activePlayerIndex == 0,
                                onStopped: () => onPlayerStopped(0),
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
                            //Player 3
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
                                controllerName: _nameController,
                                playerCount: playerCount,
                                isActive: activePlayerIndex == 2,
                                onStopped: () => onPlayerStopped(2),
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
                                initialCommanderName: p4,
                                initialLP: startingLife,
                                shadowIncrement: shadowIncrement,
                                shadowDecrement: shadowDecrement,
                                shadowStatus: shadowStatus,
                                initialColorPlayer: shadowStatus,
                                controller: _textController,
                                controllerName: _nameController,
                                playerCount: playerCount,
                                isActive: activePlayerIndex == 3,
                                onStopped: () => onPlayerStopped(3),
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
                            statusHeight: statusWidthP5,
                            initialCommanderName: p5,
                            initialLP: startingLife,
                            shadowIncrement: shadowIncrement,
                            shadowDecrement: shadowDecrement,
                            shadowStatus: shadowStatus,
                            initialColorPlayer: shadowStatus,
                            controller: _textController,
                            controllerName: _nameController,
                            playerCount: playerCount,
                            isActive: activePlayerIndex == 4,
                            onStopped: () => onPlayerStopped(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight / 2 - statusWidthP5 - 5,
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
