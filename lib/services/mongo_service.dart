import 'package:mongo_dart/mongo_dart.dart';
import 'api_key.dart';

class MongoService {
  static late Db _db;
  static late DbCollection _commanderCollection;

  static Future<void> init(String collectionName) async {
    _db = await Db.create(apiKey);
    await _db.open();
    _commanderCollection = _db.collection(collectionName);
  }

  static Future<List<String>> searchCommanders(String query) async {
    try {
      final results = await _commanderCollection.find({
        'name': {'\$regex': query, '\$options': 'i'}
      }).toList();

      return results.map((e) => e['name'] as String).toList();
    } catch (e) {
      print('Error searching commanders: $e');
      return [];
    }
  }

  static Future<void> close() async {
    await _db.close();
  }
}
