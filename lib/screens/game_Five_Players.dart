import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../widgets/playerWidget.dart';
import '../constants.dart';

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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.white, Colors.blue, Colors.red, Colors.green],
        ),
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
  // seize of Player fields
  double pmWidth = 160;
  double pmHeight = 70;
  double statusHeight = 100;
  double statusWidth = 80;
  double pmWidthP5 = 160;
  double pmHeightP5 = 140;
  int playerCount = 5;

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _newGame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Start a New Game?'),
          content: const Text('Are you sure you want to start a new game?'),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Dismiss the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const Expanded(
                  child: SizedBox(),
                ), // Spacer to push the next button to the right
                TextButton(
                  onPressed: () {
                    setState(() {
                      List<int> lifePoints = List.filled(5, startingLife);
                      List<Color> playerColors = List.filled(5, shadowStatus);

                      nLP1 = lifePoints[0];
                      nLP2 = lifePoints[1];
                      nLP3 = lifePoints[2];
                      nLP4 = lifePoints[3];
                      nLP5 = lifePoints[4];

                      colorPlayer1 = playerColors[0];
                      colorPlayer2 = playerColors[1];
                      colorPlayer3 = playerColors[2];
                      colorPlayer4 = playerColors[3];
                      colorPlayer5 = playerColors[4];
                    });
                    // Dismiss the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Game5'),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(0.0),
            color: Colors.white,
            tooltip: 'New Game',
            icon: const Icon(Icons.add, size: 25.0),
            onPressed: _newGame,
          ),
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
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            statusWidth: statusWidth,
                            commanderName: p2,
                            initialCommanderName: "Player 2",
                            nLP: nLP2,
                            shadowIncrement: shadowIncrement,
                            shadowDecrement: shadowDecrement,
                            shadowStatus: shadowStatus,
                            colorPlayer: colorPlayer2,
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
                          quarterTurns: 2,
                          child: PlayerWidget(
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            statusWidth: statusWidth,
                            commanderName: p1,
                            initialCommanderName: "Player 1",
                            nLP: nLP1,
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
                    const SizedBox(
                      height: 5.0,
                      width: 5.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: const EdgeInsets.all(0.0),
                          color: Colors.white,
                          tooltip: 'New Game',
                          icon: const Icon(Icons.add, size: 25.0),
                          onPressed: _newGame,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Player 3
                        RotatedBox(
                          quarterTurns: 0,
                          child: PlayerWidget(
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            statusWidth: statusWidth,
                            commanderName: p3,
                            initialCommanderName: "Player 3",
                            nLP: nLP3,
                            shadowIncrement: shadowIncrement,
                            shadowDecrement: shadowDecrement,
                            shadowStatus: shadowStatus,
                            colorPlayer: colorPlayer3,
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
                            pmHeight: pmHeight,
                            pmWidth: pmWidth,
                            statusHeight: statusHeight,
                            statusWidth: statusWidth,
                            commanderName: p4,
                            initialCommanderName: "Player 4",
                            nLP: nLP4,
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
                        pmHeight: pmHeightP5,
                        pmWidth: pmWidthP5,
                        statusHeight: statusHeight,
                        statusWidth: statusWidth,
                        commanderName: p5,
                        initialCommanderName: "Player 5",
                        nLP: nLP5,
                        shadowIncrement: shadowIncrement,
                        shadowDecrement: shadowDecrement,
                        shadowStatus: shadowStatus,
                        colorPlayer: colorPlayer5,
                        controller: _textController,
                        controllerName: _nameController,
                        playerCount: playerCount,
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
