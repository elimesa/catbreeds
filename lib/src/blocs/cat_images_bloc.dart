import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'cat_images_event.dart';
import 'cat_images_state.dart';
import '../resources/repository.dart';
import '../models/cat_image.dart';
import '../models/cat_breed_model.dart';

class CatImagesBloc {
  final Repository _repository;

  final _imageStateSubject = BehaviorSubject<CatImagesState>();
  final _loadingSubject = BehaviorSubject<bool>();

  Stream<CatImagesState> get stateStream => _imageStateSubject.stream;
  final _eventController = StreamController<CatImagesEvent>();
  Sink<CatImagesEvent> get eventSink => _eventController.sink;

  List<CatImage> _allCatImages = [];

  CatImagesBloc(this._repository) {
    _eventController.stream.listen((event) async {
      await onEvent(event);
    });
  }

  Future<void> onEvent(CatImagesEvent event) async {
    if (event is LoadCatImages) {
      await _loadCatImages();
    } else if (event is FilterCatImages) {
      filterCatImages(event.query);
    }
  }

  Future<void> _loadCatImages() async {
    _imageStateSubject.add(CatImagesLoading());

    try {
      final List<CatBreedModel> catBreeds = await _repository.fetchAllCats();

      List<String> imageIds = catBreeds
          .map((breed) => breed.referenceImageId)
          .where((id) => id != null && id != "")
          .cast<String>()
          .toList();

      List<CatImage> catDetailsList = [];

      for (String id in imageIds) {
        final CatImage catDetails = await _repository.fetchCatImageDetails(id);
        catDetailsList.add(catDetails);
      }

      _imageStateSubject.add(CatImagesLoaded(catDetailsList));

      _allCatImages = catDetailsList;
    } catch (e) {
      _imageStateSubject.add(CatImagesError('An error occurred: $e'));
    }
  }

  void filterCatImages(String query) {
    List<CatImage> filteredList;
    if (query.isEmpty) {
      filteredList = _allCatImages;
    } else {
      filteredList = _allCatImages
          .where((catImage) =>
              catImage.breeds!.isNotEmpty &&
              catImage.breeds![0].name
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
    _imageStateSubject.add(CatImagesLoaded(filteredList));
  }

  void dispose() {
    _loadingSubject.close();
  }
}
