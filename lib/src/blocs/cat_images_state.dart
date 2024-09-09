import '../models/cat_image.dart';

abstract class CatImagesState {}

class CatImagesLoading extends CatImagesState {}

class CatImagesLoaded extends CatImagesState {
  final List<CatImage> images;

  CatImagesLoaded(this.images);
}

class CatImagesError extends CatImagesState {
  final String message;

  CatImagesError(this.message);
}
