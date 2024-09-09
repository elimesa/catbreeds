import 'dart:convert';
import 'package:http/http.dart';

import 'models/cat_breed_model.dart';
import 'models/cat_image.dart';

class CatApiProvider {
  final _baseUrl = "https://api.thecatapi.com/v1/breeds";
  final String _apiKey =
      "ive_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr";
  Client client = Client();

  Future<List<CatImage>> fetchCatImages() async {
    final response = await client.get(
        Uri.parse('$_baseUrl/images/search?limit=10'),
        headers: {'x-api-key': _apiKey});
    if (response.statusCode == 200) {
      List<dynamic> imagesData = json.decode(response.body);
      return imagesData.map((data) => CatImage.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load cat images');
    }
  }

  Future<List<CatBreedModel>> fetchCatBreeds() async {
    final response = await client
        .get(Uri.parse('$_baseUrl/breeds'), headers: {'x-api-key': _apiKey});
    if (response.statusCode == 200) {
      List<dynamic> breedsData = json.decode(response.body);
      return breedsData.map((data) => CatBreedModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  Future<CatImage> fetchCatImageDetails(String id) async {
    final response = await client.get(Uri.parse('$_baseUrl/images/$id'),
        headers: {'x-api-key': _apiKey});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CatImage.fromJson(data);
    } else {
      throw Exception('Failed to load cat image details');
    }
  }
}
