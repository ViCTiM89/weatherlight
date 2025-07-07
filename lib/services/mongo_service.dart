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

  static Future<List<String>> searchPartners(String query) async {
    try {
      final results = await _commanderCollection.find({
        'name': {'\$regex': query, '\$options': 'i'},
        '\$or': [
          {
            'keywords': {
              '\$in': ['Partner', 'Doctor\'s companion']
            }
          },
          {
            'type_line': {'\$regex': 'Background', '\$options': 'i'}
          }
        ],
      }).toList();

      return results.map((e) => e['name'] as String).toList();
    } catch (e) {
      print('Error searching partners: $e');
      return [];
    }
  }

  static Future<List<String>> searchCompanions(String query) async {
    try {
      final results = await _commanderCollection.find({
        'name': {'\$regex': query, '\$options': 'i'},
        'keywords': 'Companion', // matches if "Companion" is in keywords array
      }).toList();

      return results.map((e) => e['name'] as String).toList();
    } catch (e) {
      print('Error searching companions: $e');
      return [];
    }
  }

  static Future<void> insertDocument(
      String collectionName, Map<String, dynamic> document) async {
    try {
      final collection = _db.collection(collectionName);
      await collection.insertOne(document);
      print('Document inserted into $collectionName');
    } catch (e) {
      print('Error inserting document: $e');
    }
  }

  static Future<void> insertMany(
      String collectionName, List<Map<String, dynamic>> documents) async {
    try {
      final collection = _db.collection(collectionName);
      await collection.insertMany(documents);
      print('Inserted ${documents.length} documents into $collectionName');
    } catch (e) {
      print('Error inserting documents: $e');
    }
  }

  static Future<void> upsertStats(
      String collectionName, Map<String, dynamic> game) async {
    try {
      final collection = _db.collection(collectionName);

      final query = {
        'commander': game['commander'],
        'companion': game['companion'],
      };

      final update = ModifierBuilder()
        ..inc('Games', 1)
        ..inc('Wins', game['isWin'] == true ? 1 : 0);

      await collection.updateOne(
        query,
        update,
        upsert: true,
      );

      print('Stats updated for commander: ${game['commander']}');
    } catch (e) {
      print('Error updating stats: $e');
    }
  }

  static Future<void> close() async {
    await _db.close();
  }
}
