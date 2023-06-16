part of crop_crop;

class CropController extends ChangeNotifier {
  late Picture picture;
  Rect imgRect = Rect.zero;
  Rect zoneRect = Rect.zero;
  double aspectRatio = 1;

  void preparingImage({
    required Picture newPicture,
    required Size layoutSize,
    double? aspectRatio,
  }) {
    picture = newPicture;
    this.aspectRatio = aspectRatio ?? 1;
    imgRect = Calculator.calcImgRect(layoutSize, picture.size);
    zoneRect = Calculator.calcInitialRectZone(
        layoutSize, picture.size, imgRect, this.aspectRatio);
    notifyListeners();
  }

  void updatePoisiton(DragUpdateDetails details) {
    final original = zoneRect;
    zoneRect = Calculator.moveZone(
      details.delta.dx,
      details.delta.dy,
      original,
      imgRect,
    );
    notifyListeners();
  }

  void updateTopLeftDot(DragUpdateDetails details) {
    final original = zoneRect;
    zoneRect = Calculator.dragTopLeftZone(
      details.delta.dx,
      details.delta.dy,
      original,
      imgRect,
      aspectRatio,
    );
    notifyListeners();
  }

  void updateTopRightDot(DragUpdateDetails details) {
    final original = zoneRect;
    zoneRect = Calculator.dragTopRightZone(
      details.delta.dx,
      details.delta.dy,
      original,
      imgRect,
      aspectRatio,
    );
    notifyListeners();
  }

  void updateBottomLeftDot(DragUpdateDetails details) {
    final original = zoneRect;
    zoneRect = Calculator.dragBottomLeftZone(
      details.delta.dx,
      details.delta.dy,
      original,
      imgRect,
      aspectRatio,
    );
    notifyListeners();
  }

  void updateBottomRightDot(DragUpdateDetails details) {
    final original = zoneRect;
    zoneRect = Calculator.dragBottomRightZone(
      details.delta.dx,
      details.delta.dy,
      original,
      imgRect,
      aspectRatio,
    );
    notifyListeners();
  }
}
