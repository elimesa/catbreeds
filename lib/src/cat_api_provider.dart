import 'dart:convert';
import 'package:http/http.dart';

import 'package:catbreeds/src/models/cat_breed_model.dart';


class CatApiProvider {
  Client client = Client();
  final _apiKey = "ive_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr";
  final _baseUrl = "https://api.thecatapi.com/v1/breeds";

  Future<CatBreedModel> fetchCatList() async{
    final response = await client.get(_baseUrl as Uri);

    if (response.statusCode == 200) {
      return CatBreedModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}