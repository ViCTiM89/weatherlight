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

  static Future<List<Map<String, dynamic>>> fetchCommanders() async {
    try {
      return await _commanderCollection.find().toList();
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  static Future<void> close() async {
    await _db.close();
  }
}
