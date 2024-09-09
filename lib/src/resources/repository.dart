import 'package:catbreeds/src/models/cat_breed_model.dart';

import '../cat_api_provider.dart';

class Repository {
  final catApiProvider = CatApiProvider();

  Future<CatBreedModel> fetchAllCats() => catApiProvider.fetchCatList();
}
