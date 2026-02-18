import 'package:flutter/material.dart';

class CombosCard extends StatefulWidget {
  final List<Map<String, dynamic>> combos;
  final String title;

  const CombosCard({Key? key, required this.combos, this.title = 'Available Combos'}) : super(key: key);

  @override
  State<CombosCard> createState() => _CombosCardState();
}

class _CombosCardState extends State<CombosCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        initiallyExpanded: _expanded,
        onExpansionChanged: (v) => setState(() => _expanded = v),
        children: [
          SizedBox(
            width: double.infinity,
            child: widget.combos.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Text('No combos found', style: TextStyle(color: Colors.grey.shade600)),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.combos.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final combo = widget.combos[index];
                      final cards = combo['cards'] as List<dynamic>? ?? [];

                      // Split the card widgets into rows of max 5 cards each
                      final List<Widget> rows = [];
                      for (int i = 0; i < cards.length; i += 5) {
                        int end = i + 5;
                        if (end > cards.length) end = cards.length;
                        final chunk = cards.sublist(i, end);
                        rows.add(
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: chunk.map<Widget>((c) {
                                final name = (c is Map) ? (c['name'] ?? '') as String : c.toString();
                                final image = (c is Map) ? (c['image'] ?? '') as String : '';
                                if (image.isNotEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        image,
                                        width: 56,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) => SizedBox(
                                          width: 56,
                                          height: 80,
                                          child: Center(child: Text(name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10))),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Container(
                                      width: 56,
                                      height: 80,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text(name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
                                    ),
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: rows,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
