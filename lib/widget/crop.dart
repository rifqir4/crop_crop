part of crop_crop;

class Crop extends StatelessWidget {
  const Crop({
    Key? key,
    required this.imgFile,
    this.sampleFile,
    this.controller,
    this.dotSize = 25,
    this.dot,
    this.onLoadComplete,
  }) : super(key: key);

  final File imgFile;
  final File? sampleFile;
  final CropController? controller;
  final double dotSize;
  final Widget? dot;
  final VoidCallback? onLoadComplete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        final maxSize = cons.biggest;

        return ChangeNotifierProvider(
          create: (_) => controller ?? CropController(),
          child: _CropWidget(
            layoutSize: maxSize,
            imgFile: imgFile,
            sampleFile: sampleFile,
            dot: dot,
            dotSize: dotSize,
            onLoadComplete: onLoadComplete,
          ),
        );
      },
    );
  }
}

class _CropWidget extends StatefulWidget {
  const _CropWidget({
    Key? key,
    required this.layoutSize,
    required this.imgFile,
    this.sampleFile,
    required this.dotSize,
    this.dot,
    this.onLoadComplete,
  }) : super(key: key);

  final Size layoutSize;
  final File imgFile;
  final File? sampleFile;
  final double dotSize;
  final Widget? dot;
  final VoidCallback? onLoadComplete;

  @override
  State<_CropWidget> createState() => __CropWidgetState();
}

class __CropWidgetState extends State<_CropWidget> {
  bool isPrepared = false;
  late File showedImage;

  @override
  void initState() {
    super.initState();

    showedImage = widget.sampleFile ?? widget.imgFile;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final bytes = await widget.imgFile.readAsBytes();
      final decode = await decodeImageFromList(bytes);
      debugPrint("BEFORE DECODE: ${decode.width} | ${decode.height}");
      double imageWidth = decode.width.toDouble();
      double imageHeight = decode.height.toDouble();
      decode.dispose();

      debugPrint("BEFORE: $imageWidth | $imageHeight");
      debugPrint("BEFORE: ${bytes.lengthInBytes / 1024}KB");

      final picture = Picture(
        file: widget.imgFile,
        size: Size(imageWidth, imageHeight),
      );
      if (!mounted) return;
      context.read<CropController>().preparingImage(picture, widget.layoutSize);
      setState(() {
        isPrepared = true;
        widget.onLoadComplete?.call();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isPrepared) {
      return const Center(child: Text("PREPARING CROP"));
    }
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.file(
            showedImage,
            fit: BoxFit.contain,
          ),
        ),
        const CropZone(),
        const CropPointer(),
        CropDot(
          dotSize: widget.dotSize,
          widget: widget.dot,
          alignment: EdgeAlignment.topLeft,
        ),
        CropDot(
          dotSize: widget.dotSize,
          widget: widget.dot,
          alignment: EdgeAlignment.bottomLeft,
        ),
        CropDot(
          dotSize: widget.dotSize,
          widget: widget.dot,
          alignment: EdgeAlignment.topRight,
        ),
        CropDot(
          dotSize: widget.dotSize,
          widget: widget.dot,
          alignment: EdgeAlignment.bottomRight,
        ),
      ],
    );
  }
}
