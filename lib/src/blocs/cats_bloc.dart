import 'package:rxdart/rxdart.dart';

import 'package:catbreeds/src/models/cat_breed_model.dart';
import 'package:catbreeds/src/resources/repository.dart';

class CatsBloc {
  final _repository = Repository();
  final _catsFetcher = PublishSubject<CatBreedModel>();

  Stream<CatBreedModel> get allCats => _catsFetcher.stream;

  fetchAllCats() async {
    CatBreedModel catBreedModel = await _repository.fetchAllCats();
    _catsFetcher.sink.add(catBreedModel);
  }

  dispose() {
    _catsFetcher.close();
  }
}

final bloc = CatsBloc();