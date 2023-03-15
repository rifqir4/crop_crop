import 'dart:io';
import 'dart:typed_data';

import 'package:crop_crop/crop_crop.dart';
import 'package:flutter/material.dart';

class CropPage extends StatelessWidget {
  const CropPage({
    Key? key,
    required this.imgBytes,
    required this.imgFile,
  }) : super(key: key);

  final Uint8List imgBytes;
  final File imgFile;

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
              imgFile: imgFile,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Done"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
