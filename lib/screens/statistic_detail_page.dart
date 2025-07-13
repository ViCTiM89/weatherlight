import 'package:flutter/material.dart';

import '../constants.dart';
import '../game_helper.dart';
import '../services/mongo_service.dart';
import '../widgets/color_identity_pie.dart';

class StatisticsDetailPage extends StatefulWidget {
  final String commanderName;
  final String? partnerName;
  final String? companionName;
  final int games;
  final int wins;
  final double winRate;

  const StatisticsDetailPage(
      {Key? key,
      required this.commanderName,
      this.partnerName,
      this.companionName,
      required this.games,
      required this.wins,
      required this.winRate})
      : super(key: key);

  @override
  State<StatisticsDetailPage> createState() => _StatisticsDetailPageState();
}

class _StatisticsDetailPageState extends State<StatisticsDetailPage> {
  Map<String, dynamic>? commanderData;
  Map<String, dynamic>? partnerData;
  Map<String, dynamic>? companionData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final commander =
        await MongoService.getCommanderByName(widget.commanderName);
    final partner = widget.partnerName != null
        ? await MongoService.getCommanderByName(widget.partnerName!)
        : null;
    final companion = widget.companionName != null
        ? await MongoService.getCommanderByName(widget.companionName!)
        : null;

    if (!mounted) return;
    setState(() {
      commanderData = commander;
      partnerData = partner;
      companionData = companion;
      isLoading = false;
    });
  }

  List<String> get combinedColorIdentity {
    final Set<String> combined = {};

    if (commanderData != null && commanderData!['color_identity'] != null) {
      combined.addAll(List<String>.from(commanderData!['color_identity']));
    }

    if (partnerData != null && partnerData!['color_identity'] != null) {
      combined.addAll(List<String>.from(partnerData!['color_identity']));
    }

    if (companionData != null && companionData!['color_identity'] != null) {
      combined.addAll(List<String>.from(companionData!['color_identity']));
    }

    return combined.toList();
  }

  MaterialColor? nameColor(String legality) {
    return legality == 'banned' ? Colors.red : null;
  }

  String formatPowerToughnessOrLoyalty(Map<String, dynamic> face) {
    final type = face['type_line']?.toLowerCase() ?? '';
    if (type.contains('creature')) {
      return '${face['power'] ?? '?'}/${face['toughness'] ?? '?'}';
    } else if (type.contains('planeswalker')) {
      return face['loyalty'] ?? '?';
    }
    return '';
  }

  String getStatLabel(String typeLine) {
    final type = typeLine.toLowerCase();
    if (type.contains('creature')) return "Power/Toughness";
    if (type.contains('planeswalker')) return "Loyalty";
    return '';
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appBarColor,
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.partnerName != null
                  ? '${widget.commanderName}\n${widget.partnerName}'
                  : widget.commanderName,
              style: appBarTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                bool confirmExit = await confirmExitDialog(context);
                if (!context.mounted) return;
                if (confirmExit) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The top summary ListTile:
                      Card(
                        child: ListTile(
                          title: Text(
                            'Games: ${widget.games}\nWins: ${widget.wins},\nWin Rate: ${widget.winRate.toStringAsFixed(2)}%',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: SizedBox(
                            width: 40,
                            height: 40,
                            child:
                                ColorIdentityPie(colors: combinedColorIdentity),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      buildCommanderSection('Commander', commanderData),
                      if (partnerData != null) ...[
                        const SizedBox(height: 24),
                        buildCommanderSection('Partner', partnerData),
                      ],
                      if (companionData != null) ...[
                        const SizedBox(height: 24),
                        buildCommanderSection('Companion', companionData),
                      ],
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildCommanderSection(String title, Map<String, dynamic>? data) {
    if (data == null) {
      return Text('$title not found');
    }

    final bool hasCardFaces = data['card_faces'] != null &&
        data['card_faces'] is List &&
        data['card_faces'].isNotEmpty;
    final Map<String, dynamic> frontFace =
        hasCardFaces ? data['card_faces'][0] : data;
    final Map<String, dynamic>? backFace =
        hasCardFaces && data['card_faces'].length > 1
            ? data['card_faces'][1]
            : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        frontFace['name'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: nameColor(data['legalities']['commander']),
                        ),
                      ),
                    ),
                    Text(
                      frontFace['mana_cost'] ?? '',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              if (frontFace['image_uris']?['art_crop'] != null)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        children: [
                          Image.network(frontFace['image_uris']['art_crop']),
                          if ((data['legalities']?['commander'] ?? '') ==
                              'banned')
                            Positioned(
                              top: 12,
                              right: -32,
                              child: Transform.rotate(
                                angle: 0.785398, // 45 degrees
                                child: Container(
                                  color: Colors.redAccent,
                                  width:
                                      160, // fixed width to help center the text
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '      BANNED',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ListTile(title: Text(frontFace['type_line'] ?? '')),
              if (frontFace.containsKey('power') ||
                  frontFace.containsKey('loyalty'))
                ListTile(
                  title: Text(
                    formatPowerToughnessOrLoyalty(frontFace),
                    textAlign: TextAlign.right,
                  ),
                  subtitle: Text(
                    getStatLabel(frontFace['type_line'] ?? ''),
                    textAlign: TextAlign.right,
                  ),
                ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                title: Text(frontFace['oracle_text'] ?? ''),
                subtitle: const Text("Oracle Text"),
              ),
            ],
          ),
        ),
        if (backFace != null) ...[
          Card(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          frontFace['name'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Text(
                        frontFace['mana_cost'] ?? '',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                if (backFace['image_uris']?['art_crop'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(backFace['image_uris']['art_crop']),
                  ),
                ListTile(
                    title: Text(backFace['type_line'] ?? ''),
                    subtitle: const Text("Type")),
                if (backFace.containsKey('power') ||
                    backFace.containsKey('loyalty'))
                  ListTile(
                    title: Text(
                      formatPowerToughnessOrLoyalty(backFace),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      getStatLabel(backFace['type_line'] ?? ''),
                      textAlign: TextAlign.right,
                    ),
                  ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(title: Text(backFace['oracle_text'] ?? '')),
              ],
            ),
          ),
        ],
        Card(
          child: Column(
            children: [
              if (data.containsKey('keywords') && data['keywords'].isNotEmpty)
                ListTile(
                  title: Text((data['keywords'] as List).join('\n')),
                  subtitle: const Text("Keywords"),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
