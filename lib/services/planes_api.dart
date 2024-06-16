import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/planes.dart';




class PlanesApi {
  static Future<List<Plane>> fetchPlanes() async {
    //const String url = 'https://api.scryfall.com/cards/search?q=t%3Adungeon';
    const String url = 'https://api.scryfall.com/cards/search?q=t%3Aplane';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    final planes = data.map((e) {
      return Plane.fromMap(e);
    }).toList();
    return planes;
  }
}