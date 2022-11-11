import 'dart:io';

import 'package:final_version/ui/screens/display_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickerImage extends StatefulWidget {
  const PickerImage({super.key});

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> {

  // Define an asynchronous method
  Future pickImage(ImageSource source) async {
    try {
      // Get the image picked (for the camera source or galery source)
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // Store temporary the path of the image picked
      final imageFinal = File(image.path);
      // Save the temporary image and send the image to another page
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisplayImage(image: imageFinal)));
      });
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 100, right: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                ),
                onPressed: () => pickImage(ImageSource.camera),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.camera_alt),
                    SizedBox(width: 10),
                    Text('Camera'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 100, right: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                ),
                onPressed: () => pickImage(ImageSource.gallery),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.image),
                    SizedBox(width: 10),
                    Text('Gallery'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
