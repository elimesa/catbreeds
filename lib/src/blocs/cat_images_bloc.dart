import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

import '../models/cat_image.dart';

class CatImagesBloc {
  final _catImagesSubject = BehaviorSubject<List<CatImage>>();
  final _filteredCatImagesSubject = BehaviorSubject<List<CatImage>>();
  final _loadingSubject = BehaviorSubject<bool>();

  List<CatImage> _allCatImages = [];

  Stream<List<CatImage>> get catImagesStream =>
      _filteredCatImagesSubject.stream;

  Stream<bool> get loadingStream => _loadingSubject.stream;

  Future<void> loadCatImages() async {
    _loadingSubject.add(true);

    try {
      final breedsResponse =
          await http.get(Uri.parse('https://api.thecatapi.com/v1/breeds'));

      if (breedsResponse.statusCode == 200) {
        List<dynamic> imagesData = json.decode(breedsResponse.body);

        List<String> imageIds = imagesData
            .map((image) => image['reference_image_id'] as String?)
            .where((id) => id != null)
            .cast<String>()
            .toList();

        List<CatImage> catDetailsList = [];

        for (String id in imageIds) {
          final detailsResponse = await http
              .get(Uri.parse('https://api.thecatapi.com/v1/images/$id'));

          if (detailsResponse.statusCode == 200) {
            final detailsData = json.decode(detailsResponse.body);
            final catDetails = CatImage.fromJson(detailsData);
            catDetailsList.add(catDetails);
          } else {
            throw Exception('Failed to load cat details for id: $id');
          }
        }

        _allCatImages = catDetailsList;
        _catImagesSubject.add(_allCatImages);
        _filteredCatImagesSubject.add(_allCatImages);
      } else {
        throw Exception('Failed to load cat images');
      }
    } catch (e) {
      _catImagesSubject.addError('An error occurred: $e');
    }

    _loadingSubject.add(false);
  }

  void filterCatImages(String query) {
    if (query.isEmpty) {
      _filteredCatImagesSubject.add(_allCatImages);
    } else {
      final filteredList = _allCatImages
          .where((catImage) =>
              catImage.breeds!.isNotEmpty &&
              catImage.breeds![0].name
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();

      _filteredCatImagesSubject.add(filteredList);
    }
  }

  void dispose() {
    _catImagesSubject.close();
    _loadingSubject.close();
  }
}
