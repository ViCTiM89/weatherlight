// image_uris.dart
class ImageUris {
  final String normal;
  final String large;
  final String artCrop;

  ImageUris({
    required this.normal,
    required this.large,
    required this.artCrop,
  });

  factory ImageUris.fromMap(Map<String, dynamic> json) {
    return ImageUris(
      normal: json['normal'],
      large: json['large'],
      artCrop: json['art_crop'],
    );
  }
}