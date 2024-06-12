import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../model/dungeons.dart';
import '../services/dungeons_api.dart';
import 'mechanic_dungeon_detail.dart';

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
          colors: [Colors.white, Colors.blue, Colors.red, Colors.green],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Dungeons"),
        ),
        body: ListView.builder(
          itemCount: dungeons.length,
          itemBuilder: (context, index) {
            final dungeon = dungeons[index];
            final name = dungeon.name;
            final typeLine = dungeon.typeLine;
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(name),
              subtitle: Text(typeLine),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DungeonDetail(
                  dungeon: dungeon,
                ),
              )),
            );
          },
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  List<Dungeon> dungeons = [];

  Future<void> fetchDungeons() async {
    final response = await DungeonsApi.fetchDungeons();
    setState(() {
      dungeons = response;
    });
  }
}