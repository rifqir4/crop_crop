part of crop_crop;

class Crop extends StatelessWidget {
  const Crop({
    Key? key,
    required this.imgFile,
    this.sampleFile,
    this.controller,
  }) : super(key: key);

  final File imgFile;
  final File? sampleFile;
  final CropController? controller;

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
  }) : super(key: key);

  final Size layoutSize;
  final File imgFile;
  final File? sampleFile;

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
      final prop = await FlutterNativeImage.getImageProperties(
        widget.imgFile.path,
      );
      final bytes = await widget.imgFile.readAsBytes();

      debugPrint("BEFORE: ${prop.width} | ${prop.height}");
      debugPrint("BEFORE: ${bytes.lengthInBytes / 1024}KB");

      final picture = Picture(
        file: widget.imgFile,
        size: Size(prop.width?.toDouble() ?? 0, prop.height?.toDouble() ?? 0),
      );
      if (!mounted) return;
      context.read<CropController>().preparingImage(picture, widget.layoutSize);
      setState(() {
        isPrepared = true;
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
        const CropDot(alignment: EdgeAlignment.topLeft),
        const CropDot(alignment: EdgeAlignment.bottomLeft),
        const CropDot(alignment: EdgeAlignment.topRight),
        const CropDot(alignment: EdgeAlignment.bottomRight),
        Positioned(
          bottom: 0,
          child: ElevatedButton(
            child: const Text("Crop"),
            onPressed: () async {
              final cropped = await context.read<CropController>().crop();

              final prop =
                  await FlutterNativeImage.getImageProperties(cropped.path);
              final bytes = await cropped.readAsBytes();

              debugPrint("CROPPED: ${prop.width} | ${prop.height}");
              debugPrint("CROPPED: ${bytes.lengthInBytes / 1024}KB");

              setState(() {
                showedImage = cropped;
              });
            },
          ),
        ),
      ],
    );
  }
}
