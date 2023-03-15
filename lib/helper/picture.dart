part of crop_crop;

class Picture {
  Picture({
    required this.file,
    required this.size,
    this.sample,
  });

  final File file;
  final Size size;
  final File? sample;
}
