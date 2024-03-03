import 'package:flutter/material.dart';
import 'playerWidget.dart';
import 'constants.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({required Key key}) : super(key: key);

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: MyHomePage(
          key: ValueKey<String>('unique_key_for_ThirdRoute'),
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // seize of Player fields
  double pmWidth = 160;
  double pmHeight = 100;
  double statusHeight = 100;
  double statusWidth = 80;
  int playerCount = 4;

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
        title: const Text('Testing'),
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
                    height: 10,
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
                  PlayerWidget(
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
                  const SizedBox(
                    height: 10,
                  ),
                  // Player 4
                  PlayerWidget(
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
                ],
              ),
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _newGame,
        tooltip: 'New Game',
        child: Icon(Icons.add),
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
