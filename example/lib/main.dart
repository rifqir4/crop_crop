import 'dart:io';

import 'package:example/crop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: image != null
                ? Image.file(image!)
                : const Center(
                    child: Text("No Image Selected"),
                  ),
          ),
          ElevatedButton(
            child: const Text("Pick Image"),
            onPressed: () async {
              final XFile? picked = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                // maxWidth: 1000,
              );

              // final XFile? picked = await ImagePicker().pickImage(
              //   source: ImageSource.camera,
              //   // maxWidth: 1000,
              // );
              if (picked != null) {
                File rotatedImage = await FlutterExifRotation.rotateImage(
                  path: picked.path,
                );
                final bytes = await rotatedImage.readAsBytes();
                if (!mounted) return;
                final cropped = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CropPage(
                      imgBytes: bytes,
                      imgFile: File(rotatedImage.path),
                    ),
                  ),
                );

                if (cropped is File) {
                  setState(() {
                    image = cropped;
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
