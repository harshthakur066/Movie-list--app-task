import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function _onSelectImage;
  File? _image;

  ImageInput(this._onSelectImage, this._image);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  late File? _storedImage;
  final _picker = ImagePicker();

  Future<void> _takePicture() async {
    final imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget._onSelectImage(savedImage);
  }

  @override
  void initState() {
    _storedImage = widget._image;
  }

  Widget build(BuildContext context) {
    // print(widget._onSelectImage);
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
