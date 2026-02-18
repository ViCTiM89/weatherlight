import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

/// Fetch combos for a given commander by paging the `/variants/` endpoint.
/// Returns a list of simplified combos: { 'comboId': ..., 'variantId': ..., 'cards': [...], 'cardsList': 'A + B' }
Future<List<Map<String, dynamic>>> fetchCombosByCommander(
    String commanderName) async {
  const host = 'backend.commanderspellbook.com';
  const path = '/variants/';
  const pageLimit = 200; // reasonable page size

  int offset = 0;
  bool more = true;
  final Map<String, Map<String, dynamic>> dedup = {};

  offset = 0;
  more = true;
  while (more) {
    final url = Uri.https(host, path, {
      'q': '$commanderName legal:commander',
      'group_by_combo': 'true',
      'limit': pageLimit.toString(),
      'offset': offset.toString(),
      'ordering': '-popularity',
    });

    log('Fetching variants page offset=$offset for query: $commanderName');
    log('URL: $url');

    final response = await http.get(url).timeout(const Duration(seconds: 30));
    log('Status code: ${response.statusCode}');

    if (response.statusCode != 200) {
      log('Failed to load variants — status ${response.statusCode}');
      break;
    }

    final Map<String, dynamic> jsonData = json.decode(response.body);

    // results is a list of variant objects
    final results = jsonData['results'] as List<dynamic>? ?? [];
    log('Received ${results.length} variants (offset $offset) for query $commanderName');

    for (var variant in results) {
      if (variant is! Map<String, dynamic>) continue;

      // Determine combo id (use `of` if present, else fallback to variant id)
      String comboId = 'unknown';
      if (variant['of'] is List && (variant['of'] as List).isNotEmpty) {
        final of0 = (variant['of'] as List).first;
        if (of0 is Map && of0['id'] != null) comboId = of0['id'].toString();
      } else if (variant['of'] is Map && variant['of']['id'] != null) {
        comboId = variant['of']['id'].toString();
      } else if (variant['id'] != null) {
        comboId = variant['id'].toString();
      }

      // collect card info from `uses` (name + image)
      final List<Map<String, String>> cardInfos = [];
      if (variant['uses'] is List) {
        for (var use in variant['uses'] as List<dynamic>) {
          if (use is Map<String, dynamic>) {
            String? name;
            String? imageUrl;
            if (use['card'] is Map<String, dynamic>) {
              final card = use['card'] as Map<String, dynamic>;
              name = card['name'] as String?;
              // prefer full/front images first (normal/large/png), fall back to art_crop
              imageUrl = card['imageUriFrontNormal'] as String? ??
                  card['imageUriFrontLarge'] as String? ??
                  card['imageUriFrontPng'] as String? ??
                  card['imageUriFrontSmall'] as String? ??
                  card['imageUriFrontArtCrop'] as String?;
            } else if (use['name'] is String) {
              name = use['name'] as String;
            }

            if (name != null &&
                name.trim().isNotEmpty &&
                name.trim().toLowerCase() !=
                    commanderName.trim().toLowerCase()) {
              cardInfos.add({'name': name, 'image': imageUrl ?? ''});
            }
          }
        }
      }

      if (cardInfos.isEmpty) continue;

      // build simplified combo object
      final comboKey = comboId; // dedupe by combo id
      final comboData = {
        'comboId': comboId,
        'variantId': variant['id'] ?? 'unknown',
        'cards': cardInfos,
        'cardsList': cardInfos.map((c) => c['name']).join(' + '),
      };

      // keep first occurrence per combo id
      if (!dedup.containsKey(comboKey)) dedup[comboKey] = comboData;
    }

    // pagination: if backend provides `next`, stop when null; otherwise use length check
    final next = jsonData['next'];
    if (next == null) {
      // stop if returned less than requested
      if (results.length < pageLimit) {
        more = false;
      } else {
        offset += pageLimit;
      }
    } else {
      offset += pageLimit;
    }
  }

  final simplified =
      dedup.values.map((m) => Map<String, dynamic>.from(m)).toList();
  log('Aggregated ${simplified.length} unique combos for $commanderName');
  return simplified;
}
