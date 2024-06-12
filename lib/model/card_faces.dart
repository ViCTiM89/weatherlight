import 'image_uris.dart';

class CardFace {
  final String name;
  final String typeLine;
  final ImageUris imageUris;

  final String? oracleText;

  CardFace({
    required this.name,
    required this.typeLine,
    required this.imageUris,

    this.oracleText,
  });


  factory CardFace.fromJson(Map<String, dynamic> json) {
    return CardFace(
        name: json['name'],
        typeLine: json['type_line'],
        imageUris: ImageUris.fromMap(json['image_uris']),
        oracleText: json['oracle_text']
    );
  }
}
