import 'package:catbreeds/src/cat_api_provider.dart';
import 'package:catbreeds/src/models/cat_breed_model.dart';

class Repository {
  final catApiProvider = CatApiProvider();

  Future<CatBreedModel> fetchAllCats() => catApiProvider.fetchCatList();
}
