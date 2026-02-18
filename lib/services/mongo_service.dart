import 'dart:developer';
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
      return [];
    }
  }

  static Future<void> insertDocument(
      String collectionName, Map<String, dynamic> document) async {
    try {
      final collection = _db.collection(collectionName);
      await collection.insertOne(document);
    } catch (e) {
      log('Error inserting document: $e');
    }
  }

  static Future<void> insertMany(
      String collectionName, List<Map<String, dynamic>> documents) async {
    try {
      final collection = _db.collection(collectionName);
      await collection.insertMany(documents);
    } catch (e) {
      log('Error inserting documents: $e');
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
    } catch (e) {
      log('Error updating stats: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchSortedStats(
      String collectionName) async {
    try {
      final collection = _db.collection(collectionName);
      final results = await collection.find().toList();

      results.sort((a, b) {
        final gamesA = (a['Games'] ?? 0) as int;
        final winsA = (a['Wins'] ?? 0) as int;
        final gamesB = (b['Games'] ?? 0) as int;
        final winsB = (b['Wins'] ?? 0) as int;

        final winRateA = gamesA > 0 ? winsA / gamesA : 0;
        final winRateB = gamesB > 0 ? winsB / gamesB : 0;

        // Primary: winrate descending
        final winRateComparison = winRateB.compareTo(winRateA);
        if (winRateComparison != 0) return winRateComparison;

        // Secondary: games descending
        final gamesComparison = gamesB.compareTo(gamesA);
        if (gamesComparison != 0) return gamesComparison;

        // Tertiary: commander name alphabetically
        final commanderA = (a['commander'] != null && a['commander'].isNotEmpty)
            ? a['commander'][0].toString()
            : '';
        final commanderB = (b['commander'] != null && b['commander'].isNotEmpty)
            ? b['commander'][0].toString()
            : '';

        return commanderA.compareTo(commanderB);
      });

      return results;
    } catch (e) {
      return [];
    }
  }

  static Future<String?> fetchCommanderImage(String commanderName) async {
    final collection = _db.collection('Commanders');
    final result = await collection.findOne({'name': commanderName});

    if (result == null) return null;

    // Case 1: Single-faced card
    if (result['image_uris']?['art_crop'] != null) {
      return result['image_uris']['art_crop'];
    }

    // Case 2: Double-faced card
    if (result['card_faces'] != null &&
        result['card_faces'] is List &&
        result['card_faces'].isNotEmpty &&
        result['card_faces'][0]['image_uris']?['art_crop'] != null) {
      return result['card_faces'][0]['image_uris']['art_crop'];
    }

    return null; // fallback
  }

  static Future<Map<String, dynamic>?> getCommanderByName(String name) async {
    final collection = _db.collection('Commanders');
    final doc = await collection.findOne({'name': name});
    return doc;
  }

  static Future<void> close() async {
    await _db.close();
  }
}
