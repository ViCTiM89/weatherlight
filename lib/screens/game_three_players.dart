import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '../widgets/player_widget.dart';
import '../constants.dart';

class ThreePlayers extends StatefulWidget {
  const ThreePlayers({required Key key}) : super(key: key);

  @override
  State<ThreePlayers> createState() => _ThreePlayersState();
}

class _ThreePlayersState extends State<ThreePlayers> {
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
          colors: [
            Colors.white,
            Colors.lightBlueAccent,
            Colors.deepPurpleAccent,
            Colors.greenAccent
          ],
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: MyHomePage(
          key: ValueKey<String>('unique_key_for_gameThreePlayers'),
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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double pmWidth = screenWidth / 2.4;
    double pmHeight = screenHeight / 6;
    double statusHeight = screenHeight / 7;
    double statusWidth = pmWidth / 2;
    const int playerCount = 3;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('3 Players'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _newGame,
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
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800, // Dark grey color for the button container
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 25.0,
                              color: Colors.white, // Icon color remains white for contrast
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
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 1,
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
            ],
          ),
        ),
      ),
    );
  }
}
