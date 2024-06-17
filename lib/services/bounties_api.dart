import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/bounties.dart';

class BountiesApi {
  static Future<List<Bounty>> fetchBounties() async {
    const String url = 'https://api.scryfall.com/cards/search?q=bounty+t%3Acard+o%3Abounty';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    final planes = data.map((e) {
      return Bounty.fromMap(e);
    }).toList();
    return planes;
  }
}
