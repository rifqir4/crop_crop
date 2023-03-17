part of crop_crop;

extension CropFunction on CropController {
  Future<File> crop() async {
    final zone = Calculator.calcZoneToImg(zoneRect, imgRect, picture.size);

    return await FlutterNativeImage.cropImage(
      picture.file.path,
      zone.left.toInt(),
      zone.top.toInt(),
      zone.width.toInt(),
      zone.height.toInt(),
    );
  }
}
