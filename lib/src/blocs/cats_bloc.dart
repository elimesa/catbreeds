import 'package:rxdart/rxdart.dart';

import 'package:catbreeds/src/models/cat_breed_model.dart';
import 'package:catbreeds/src/models/cat_image.dart';
import 'package:catbreeds/src/resources/repository.dart';

class CatsBloc {
  final _repository = Repository();
  final _catsFetcher = PublishSubject<List<CatBreedModel>>();
  final _catsImagesFetcher = PublishSubject<List<CatImage>>();
  final _catsImageDetailFetcher = PublishSubject<CatImage>();

  Stream<List<CatBreedModel>> get allCats => _catsFetcher.stream;

  fetchAllCats() async {
    List<CatBreedModel> catBreedModel = await _repository.fetchAllCats();
    _catsFetcher.sink.add(catBreedModel);
  }

  fetchImagesCats() async {
    List<CatImage> catImages = await _repository.fetchImagesCats();
    _catsImagesFetcher.sink.add(catImages);
  }

  fetchCatImageDetails(String id) async {
    CatImage catImageDetail = await _repository.fetchCatImageDetails(id);
    _catsImageDetailFetcher.sink.add(catImageDetail);
  }

  dispose() {
    _catsFetcher.close();
    _catsImagesFetcher.close();
    _catsImageDetailFetcher.close();
  }
}

final bloc = CatsBloc();
