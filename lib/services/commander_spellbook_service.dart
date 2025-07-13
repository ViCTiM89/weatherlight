import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchCombos(String commanderName) async {
  final url = Uri.https(
    'backend.commanderspellbook.com',
    '/find-my-combos',
    {'q': commanderName},
  );

  final response = await http.get(url);
  print('Status code: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final results = jsonData['results'] as Map<String, dynamic>;
    final includedCombos = results['included'] as List<dynamic>;

    return List<Map<String, dynamic>>.from(includedCombos);
  } else {
    throw Exception('Failed to load combos — status ${response.statusCode}');
  }
}
