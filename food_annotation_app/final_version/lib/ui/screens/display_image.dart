import 'dart:io';

import 'package:final_version/image_painter.dart';
import 'package:flutter/material.dart';


class DisplayImage extends StatefulWidget {
  DisplayImage({Key? key, required this.image}) : super(key: key);

  File? image;

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  // The key of the image painter
  final _imageKey = GlobalKey<ImagePainterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text("Image Annotation"),
      ),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: ImagePainter.file(widget.image!, key: _imageKey),
      ),
    );
  }
}
