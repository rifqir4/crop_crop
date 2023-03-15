part of crop_crop;

class CropController extends ChangeNotifier {
  late Picture picture;
  late Rect imgRect;
  late Rect zoneRect;

  void preparingImage(Picture newPicture, Size layoutSize) {
    picture = newPicture;
    imgRect = Calculator.calcImgRect(layoutSize, picture.size);
    zoneRect = Calculator.calcInitialRectZone(imgRect);
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
      1,
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
      1,
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
      1,
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
      1,
    );
    notifyListeners();
  }
}
