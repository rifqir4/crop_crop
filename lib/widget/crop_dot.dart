part of crop_crop;

class CropDot extends StatelessWidget {
  const CropDot({
    Key? key,
    required this.alignment,
    this.dotSize = 25,
    this.widget,
  }) : super(key: key);

  final EdgeAlignment alignment;
  final double dotSize;
  final Widget? widget;

  double _calcTop(Rect cropZone) {
    switch (alignment) {
      case EdgeAlignment.topLeft:
        return cropZone.top - (dotSize / 2);
      case EdgeAlignment.bottomLeft:
        return cropZone.top + cropZone.height - (dotSize / 2);
      case EdgeAlignment.topRight:
        return cropZone.top - (dotSize / 2);
      case EdgeAlignment.bottomRight:
        return cropZone.top + cropZone.height - (dotSize / 2);
      default:
        return cropZone.top - (dotSize / 2);
    }
  }

  double _calcLeft(Rect cropZone) {
    switch (alignment) {
      case EdgeAlignment.topLeft:
        return cropZone.left - (dotSize / 2);
      case EdgeAlignment.bottomLeft:
        return cropZone.left - (dotSize / 2);
      case EdgeAlignment.topRight:
        return cropZone.left + cropZone.width - (dotSize / 2);
      case EdgeAlignment.bottomRight:
        return cropZone.left + cropZone.width - (dotSize / 2);
      default:
        return cropZone.left - (dotSize / 2);
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
            child: widget != null
                ? Container(
                    color: Colors.transparent,
                    width: dotSize,
                    height: dotSize,
                    child: widget,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(dotSize),
                    ),
                    width: dotSize,
                    height: dotSize,
                  ),
          ),
        );
      },
    );
  }
}
