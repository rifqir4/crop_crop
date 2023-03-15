part of crop_crop;

class CropPointer extends StatelessWidget {
  const CropPointer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CropController>(
      builder: (_, controller, __) {
        final rect = controller.zoneRect;
        return Positioned(
          top: rect.top,
          left: rect.left,
          child: GestureDetector(
            onPanUpdate: (details) {
              controller.updatePoisiton(details);
            },
            child: Container(
              width: rect.width,
              height: rect.height,
              color: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
