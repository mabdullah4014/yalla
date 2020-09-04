import 'dart:async';
import 'dart:io';

import 'package:arbi/generated/l10n.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ImagePickerExamplePage extends StatefulWidget {
  ImagePickerExamplePage({this.imageTitle, this.callback});

  final String imageTitle;
  final Function(PickedFile) callback;

  @override
  _ImagePickerExamplePageState createState() => _ImagePickerExamplePageState();
}

class _ImagePickerExamplePageState extends StateMVC<ImagePickerExamplePage> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80,
      );
      setState(() {
        _imageFile = pickedFile;
        widget.callback(_imageFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
        widget.callback(null);
      });
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return InkWell(
          onLongPress: () {
            AppUtils.yesNoDialog(context, S.of(context).delete,
                S.of(context).delete_image_message, () {
              Navigator.of(context).pop();
              setState(() {
                _imageFile = null;
                widget.callback(null);
              });
            });
          },
          child: Image.file(File(_imageFile.path),
              width: 70, height: 70, fit: BoxFit.cover));
    } else if (_pickImageError != null) {
      return Text(
        'Error: $_pickImageError',
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'Image not picked',
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
            color: Colors.grey.shade600,
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: 60,
                  height: 70,
                  child: _imageFile != null ? _previewImage() : _addButton(),
                ))),
        SizedBox(height: 2),
        Text(
          widget.imageTitle,
          style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
        )
      ],
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _addButton() {
    return IconButton(
        icon: Icon(Icons.add, size: 30, color: Theme.of(context).primaryColor),
        onPressed: () {
          _onImageButtonPressed(ImageSource.camera, context: context);
        });
  }
}
