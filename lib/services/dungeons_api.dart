import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/dungeons.dart';

class DungeonsApi {
  static Future<List<Dungeon>> fetchDungeons() async {
    const String url = 'https://api.scryfall.com/cards/search?q=t%3Adungeon';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    final dungeons = data.map((e) {
      return Dungeon.fromMap(e);
    }).toList();
    return dungeons;
  }
}
