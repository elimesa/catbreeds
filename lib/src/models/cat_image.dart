import 'package:catbreeds/src/models/cat_breed_model.dart';

class CatImage {
  final String id;
  final String url;
  final int width;
  final int height;
  final List<CatBreedModel>? breeds;

  CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.breeds,
  });

  factory CatImage.fromJson(Map<String, dynamic> json) {
    return CatImage(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      breeds: json['breeds'] != null
          ? (json['breeds'] as List<dynamic>)
          .map((breedJson) => CatBreedModel.fromJson(breedJson))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'width': width,
      'height': height,
      'breeds': breeds?.map((breed) => breed.toJson()).toList(),
    };
  }
}
