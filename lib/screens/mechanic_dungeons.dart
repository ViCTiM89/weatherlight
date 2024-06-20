import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:weatherlight/services/card_api.dart';
import '../constants.dart';
import '../model/cards.dart';
import 'mechanic_dungeon_detail.dart';

const List<String> rulings = [
  'Whenever one or more creatures a player controls deal combat damage to you, that player takes the initiative.',
  '• Whenever you take the initiative and at the beginning of your upkeep, venture into Undercity.',
  '(If you’re in a dungeon, advance to the next room. If you’re not, enter Undercity. You can take the initiative even if you already have it.) '
];

class Dungeons extends StatelessWidget {
  const Dungeons({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: MechanicDungeons(
        key: ValueKey<String>('unique_key_for_Dungeons'),
        title: 'Dungeons',
      ),
    );
  }
}

class MechanicDungeons extends StatefulWidget {
  const MechanicDungeons({required Key key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<MechanicDungeons> createState() => _MechanicDungeonsState();
}

class _MechanicDungeonsState extends State<MechanicDungeons> {
  @override
  void initState() {
    super.initState();
    // Enable wakelock when entering the screen
    Wakelock.enable();
    fetchDungeons();
  }

  @override
  void dispose() {
    // Disable wakelock when leaving the screen
    Wakelock.disable();
    super.dispose();
  }

  Color shadowColor = Colors.white12;

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
          title: const Text("Dungeons"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                border: Border.all(color: Colors.black, width: 2),
              ),
              height: 500,
              width: 500,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: dungeons.length,
                      itemBuilder: (context, index) {
                        final dungeon = dungeons[index];
                        final name = dungeon.name;
                        final typeLine = dungeon.typeLine;
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            typeLine,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DungeonDetail(
                                dungeon: dungeon,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                    ),
                    onPressed: () => _showRulingsDialog(context),
                    child: const Text(
                      'Show Rulings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Go back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  List<FetchedCards> dungeons = [];

  Future<void> fetchDungeons() async {
    final response = await CardApi.fetchCards(fetchAllDungeons);
    setState(() {
      dungeons = response;
    });
  }
}

void _showRulingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          "Rulings For\n Venturing into the Dungeon",
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildRulingsWithSpacing(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

List<Widget> _buildRulingsWithSpacing() {
  List<Widget> widgets = [];

  for (var i = 0; i < rulings.length; i++) {
    widgets.add(
      Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        child: Text(
          rulings[i],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
    widgets.add(SizedBox(height: i == 0 ? 10 : 5));
  }

  if (widgets.isNotEmpty) {
    widgets.removeLast();
  }

  return widgets;
}
