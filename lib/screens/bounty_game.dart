import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:weatherlight/services/card_api.dart';
import '../constants.dart';
import '../model/cards.dart';

const Color rewardColorActive = Colors.amberAccent;
const Color rewardColorInactive = Colors.grey;

const List<String> rewards = [
  'Create a Treasure Token',
  'Create Two Treasure Tokens',
  'Create two Treasure tokens *or* draw a card',
  '(Max) Create two Treasure tokens *and* draw a card.'
];

class BountyGame extends StatefulWidget {
  const BountyGame({Key? key}) : super(key: key);

  @override
  State<BountyGame> createState() => _BountyGameState();
}

class _BountyGameState extends State<BountyGame> {
  int rewardLevel = 0;
  String? currentImageUrl;
  List<FetchedCards> bounties = [];

  @override
  void initState() {
    super.initState();
    // Enable wakelock when entering the screen
    Wakelock.enable();
    fetchBounties();
  }

  @override
  void dispose() {
    // Disable wakelock when leaving the screen
    Wakelock.disable();
    super.dispose();
  }

  void _incrementRewardLevel() {
    setState(() {
      if (rewardLevel < 3) {
        rewardLevel++;
      } else {
        rewardLevel = 0;
      }
    });
  }

  void _resetRewardLevel() {
    setState(() {
      rewardLevel = 0;
    });
  }

  Color _getTextColor(int index) {
    return rewardLevel >= index ? rewardColorActive : rewardColorInactive;
  }

  void _showBountiesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bounties: ${bounties.length}'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: bounties.length,
              itemBuilder: (context, index) {
                final dungeon = bounties[index];
                final name = dungeon.name;
                final typeLine = dungeon.typeLine;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(typeLine),
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Colors.blueAccent,
                  ),
                  onLongPress: () {
                    setState(
                      () {
                        currentImageUrl = dungeon.imageUris?.large ??
                            dungeon.cardFaces![0].imageUris.large;
                      },
                    );
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    double bountyHeight = screenHeight / 2;
    double bountyWidth = screenWidth;
    double rewardLevelHeight = screenHeight / 8.5;
    double rewardLevelWidth = screenWidth;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.lightBlueAccent,
            Colors.deepPurpleAccent,
            Colors.greenAccent,
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Bounty"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onLongPress: () {
                  setState(
                    () {
                      if (bounties.isNotEmpty) {
                        final randomIndex = Random().nextInt(bounties.length);
                        final randomBounty = bounties[randomIndex];
                        currentImageUrl = randomBounty.imageUris?.large ??
                            randomBounty.cardFaces![0].imageUris.large;
                      }
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: bountyHeight,
                    width: bountyWidth,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: currentImageUrl == null
                          ? Image.asset('images/bounty.jpg', fit: BoxFit.cover)
                          : Image.network(
                              currentImageUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _incrementRewardLevel,
                onLongPress: _resetRewardLevel,
                child: Container(
                  height: rewardLevelHeight * 2,
                  width: rewardLevelWidth,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4,
                        (index) {
                          return RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                              height: rewardLevelHeight,
                              width: rewardLevelWidth,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  rewards[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _getTextColor(index),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showBountiesDialog(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Show Bounties'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchBounties() async {
    final response = await CardApi.fetchCards(fetchAllBounties);
    setState(
      () {
        bounties = response;
      },
    );
  }
}
