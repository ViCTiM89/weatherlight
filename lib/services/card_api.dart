import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/cards.dart';

class CardApi {
  static Future<List<FetchedCards>> fetchCards(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    final planes = data.map((e) {
      return FetchedCards.fromMap(e);
    }).toList();
    return planes;
  }
}
