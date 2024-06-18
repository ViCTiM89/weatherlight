import 'card_faces.dart';
import 'image_uris.dart';

class FetchedCards {
  final String id;
  final String name;
  final String typeLine;
  //nullable
  final ImageUris? imageUris;
  final List<CardFace>? cardFaces;

  FetchedCards({
    required this.id,
    required this.name,
    required this.typeLine,
    //nullable
    this.imageUris,
    this.cardFaces,
  });

  factory FetchedCards.fromMap(Map<String, dynamic> json) {
    return FetchedCards(
      id: json['id'],
      name: json['name'],
      typeLine: json['type_line'],
      imageUris: json['image_uris'] != null
          ? ImageUris.fromMap(
              json['image_uris'],
            )
          : null,
      cardFaces: json['card_faces'] != null
          ? List<CardFace>.from(
              json['card_faces'].map((face) => CardFace.fromJson(face)))
          : null,
    );
  }
}
