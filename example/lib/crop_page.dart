import 'dart:io';
import 'dart:typed_data';

import 'package:crop_crop/crop_crop.dart';
import 'package:flutter/material.dart';

class CropPage extends StatefulWidget {
  const CropPage({
    Key? key,
    required this.imgBytes,
    required this.imgFile,
  }) : super(key: key);

  final Uint8List imgBytes;
  final File imgFile;

  @override
  State<CropPage> createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  final CropController _controller = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Crop(
              controller: _controller,
              imgFile: widget.imgFile,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final cropped = _controller.crop();
                  Navigator.pop(context, cropped);
                },
                child: const Text("Crop"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
