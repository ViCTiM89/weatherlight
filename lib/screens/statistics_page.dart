import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:weatherlight/screens/statistic_detail_page.dart';
import 'package:weatherlight/services/mongo_service.dart';

import '../constants.dart';
import '../game_helper.dart';
import '../widgets/split_circle_avatar.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({required Key key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Future<List<Map<String, dynamic>>> _statsFuture;
  List<Map<String, dynamic>> _allStats = [];
  List<Map<String, dynamic>> _filteredStats = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final Map<String, bool> _bannedCommanders = {}; // true if banned

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    _statsFuture = _initializeMongoAndLoadStats();
  }

  final Map<String, String?> _commanderImages = {};

  Future<List<Map<String, dynamic>>> _initializeMongoAndLoadStats() async {
    await MongoService.init('CommanderStats');
    final stats = await MongoService.fetchSortedStats('CommanderStats');

    for (var stat in stats) {
      final commanderData = stat['commander'];

      if (commanderData is List) {
        for (final commander in commanderData) {
          final name = commander.toString().trim();
          if (!_commanderImages.containsKey(name)) {
            final imageUrl = await MongoService.fetchCommanderImage(name);
            _commanderImages[name] = imageUrl;

            final commanderData = await MongoService.getCommanderByName(name);
            final legality = commanderData?['legalities']?['commander'];
            _bannedCommanders[name] = legality == 'banned';
            print(legality);
          }
        }
      } else {
        final name = (commanderData ?? 'Unknown').toString().trim();
        if (!_commanderImages.containsKey(name)) {
          final imageUrl = await MongoService.fetchCommanderImage(name);
          _commanderImages[name] = imageUrl;
        }
      }
    }

    _allStats = stats;
    _filteredStats = stats;
    return stats;
  }

  void _filterStats(String query) {
    setState(() {
      _filteredStats = _allStats.where((stat) {
        final commander = stat['commander'];
        final commanderNames = (commander is List)
            ? commander.join(' ').toLowerCase()
            : commander.toString().toLowerCase();

        return commanderNames.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  Color _getWinRateColor(num winRate) {
    if (winRate < 15) {
      return Colors.red.shade700;
    } else if (winRate < 20) {
      return Colors.deepOrange.shade600;
    } else if (winRate < 30) {
      return Colors.orange.shade600;
    } else if (winRate < 40) {
      return Colors.lightGreen.shade600;
    } else {
      return Colors.green.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient(),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appBarColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search commanders...',
                    hintStyle: hintTextStyle(),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: _filterStats,
                )
              : Text(
                  "Commander Stats",
                  style: appBarTextStyle(),
                ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _isSearching = false;
                    _searchController.clear();
                    _filteredStats = _allStats;
                  } else {
                    _isSearching = true;
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                final currentContext = context;
                bool confirmExit = await confirmExitDialog(currentContext);
                if (!mounted) return;
                if (confirmExit) {
                  Navigator.of(currentContext).pop();
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _statsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available.'));
            }

            final stats = _filteredStats;

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final stat = stats[index];

                final commanderData = stat['commander'];
                final commander = (commanderData is List)
                    ? commanderData.join('\n')
                    : (commanderData ?? 'Unknown');

                final commanderList = (commanderData is List)
                    ? commanderData.map((e) => e.toString()).toList()
                    : [commanderData.toString()];

                final companion = stat['companion'];
                final games = int.tryParse('${stat['Games']}') ?? 0;
                final wins = int.tryParse('${stat['Wins']}') ?? 0;
                final double winRate = games > 0 ? (wins / games * 100) : 0;
                final winRateColor = _getWinRateColor(winRate);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StatisticsDetailPage(
                          commanderName: commanderList[0].toString(),
                          partnerName: commanderList.length > 1
                              ? commanderList[1].toString()
                              : null,
                          companionName: companion?.toString(),
                          games: games,
                          wins: wins,
                          winRate: winRate,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Circle avatar on the left
                          (commanderList.length > 1)
                              ? SplitCircleAvatar(
                                  leftImageUrl:
                                      _commanderImages[commanderList[0]],
                                  rightImageUrl:
                                      _commanderImages[commanderList[1]],
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      _commanderImages[commander] != null
                                          ? NetworkImage(
                                              _commanderImages[commander]!)
                                          : null,
                                  child: _commanderImages[commander] == null
                                      ? Text(
                                          commander.toString().substring(0, 1),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : null,
                                ),
                          const SizedBox(width: 12),
                          // Main content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Commander name
                                Text(
                                  commander.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: commanderList.any((name) =>
                                            _bannedCommanders[name] == true)
                                        ? Colors.red
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Companion line
                                if (companion != null &&
                                    companion.toString().isNotEmpty)
                                  Text.rich(
                                    TextSpan(
                                      text: 'Companion: ',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: companion.toString(),
                                          style: TextStyle(
                                            color: _bannedCommanders[companion
                                                        ?.toString()] ==
                                                    true
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                // Stats row with icons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.videogame_asset,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text('Games: $games'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.emoji_events,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text('Wins: $wins'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.percent, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${winRate.toStringAsFixed(1)}%',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: winRateColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                // Progress bar
                                LinearProgressIndicator(
                                  value: winRate / 100,
                                  color: winRateColor,
                                  backgroundColor: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
