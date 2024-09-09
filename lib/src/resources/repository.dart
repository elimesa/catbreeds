import 'package:catbreeds/src/models/cat_breed_model.dart';
import 'package:catbreeds/src/models/cat_image.dart';

import '../cat_api_provider.dart';

class Repository {
  final catApiProvider = CatApiProvider();

  Future<List<CatBreedModel>> fetchAllCats() => catApiProvider.fetchCatBreeds();

  Future<List<CatImage>> fetchImagesCats() => catApiProvider.fetchCatImages();

  Future<CatImage> fetchCatImageDetails(String id) =>
      catApiProvider.fetchCatImageDetails(id);
}
