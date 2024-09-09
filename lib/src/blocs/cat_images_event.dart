abstract class CatImagesEvent {}

class LoadCatImages extends CatImagesEvent {}

class FilterCatImages extends CatImagesEvent {
  final String query;

  FilterCatImages(this.query);
}
