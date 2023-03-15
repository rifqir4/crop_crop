part of crop_crop;

class CropZone extends StatelessWidget {
  const CropZone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CropController>(builder: (c, controller, _) {
      return IgnorePointer(
        child: ClipPath(
          clipper: _CropAreaClipper(controller.zoneRect),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withAlpha(100),
          ),
        ),
      );
    });
  }
}

class _CropAreaClipper extends CustomClipper<Path> {
  _CropAreaClipper(this.rect);

  final Rect rect;

  @override
  Path getClip(Size size) {
    return Path()
      ..addPath(
        Path()
          ..moveTo(rect.left, rect.top)
          ..arcToPoint(Offset(rect.left, rect.top))
          ..lineTo(rect.right, rect.top)
          ..arcToPoint(Offset(rect.right, rect.top))
          ..lineTo(rect.right, rect.bottom)
          ..arcToPoint(Offset(rect.right, rect.bottom))
          ..lineTo(rect.left, rect.bottom)
          ..arcToPoint(Offset(rect.left, rect.bottom))
          ..close(),
        Offset.zero,
      )
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
