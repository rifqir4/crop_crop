part of crop_crop;

class CropDot extends StatelessWidget {
  const CropDot({
    Key? key,
    required this.alignment,
  }) : super(key: key);

  final EdgeAlignment alignment;
  final double _k = 25;

  double _calcTop(Rect cropZone) {
    switch (alignment) {
      case EdgeAlignment.topLeft:
        return cropZone.top - (_k / 2);
      case EdgeAlignment.bottomLeft:
        return cropZone.top + cropZone.height - (_k / 2);
      case EdgeAlignment.topRight:
        return cropZone.top - (_k / 2);
      case EdgeAlignment.bottomRight:
        return cropZone.top + cropZone.height - (_k / 2);
      default:
        return cropZone.top - (_k / 2);
    }
  }

  double _calcLeft(Rect cropZone) {
    switch (alignment) {
      case EdgeAlignment.topLeft:
        return cropZone.left - (_k / 2);
      case EdgeAlignment.bottomLeft:
        return cropZone.left - (_k / 2);
      case EdgeAlignment.topRight:
        return cropZone.left + cropZone.width - (_k / 2);
      case EdgeAlignment.bottomRight:
        return cropZone.left + cropZone.width - (_k / 2);
      default:
        return cropZone.left - (_k / 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CropController>(
      builder: (_, controller, __) {
        final rect = controller.zoneRect;
        return Positioned(
          top: _calcTop(rect),
          left: _calcLeft(rect),
          child: GestureDetector(
            onPanUpdate: (details) {
              switch (alignment) {
                case EdgeAlignment.topLeft:
                  controller.updateTopLeftDot(details);
                  break;
                case EdgeAlignment.bottomLeft:
                  controller.updateBottomLeftDot(details);
                  break;
                case EdgeAlignment.topRight:
                  controller.updateTopRightDot(details);
                  break;
                case EdgeAlignment.bottomRight:
                  controller.updateBottomRightDot(details);
                  break;
                default:
                  break;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(_k),
              ),
              width: _k,
              height: _k,
            ),
          ),
        );
      },
    );
  }
}
