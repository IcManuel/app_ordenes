import 'dart:io';

import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/ui/widgets/camera_entrega_widget.dart';
import 'package:app_ordenes/ui/widgets/camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void seleccionMultipleGallery(context, int tipo) async {
  final ImagePicker _picker = ImagePicker();
  try {
    final pickedFileList = await _picker.pickMultiImage(
      imageQuality: 25,
    );
    final bloc = Provider.of<FotosBloc>(context, listen: false);
    bloc.anadirFotos(pickedFileList!, tipo);
    print(pickedFileList);
  } catch (e) {
    print(e);
  }
}

Widget previewImages(_imageFileList, _pickImageError) {
  if (_imageFileList != null) {
    return Semantics(
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (context, index) {
            // Why network for web?
            // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: Image.file(File(_imageFileList![index].path)),
            );
          },
          itemCount: _imageFileList!.length,
        ),
        label: 'image_picker_example_picked_images');
  } else if (_pickImageError != null) {
    return Text(
      'Pick image error: $_pickImageError',
      textAlign: TextAlign.center,
    );
  } else {
    return const Text(
      'You have not yet picked an image.',
      textAlign: TextAlign.center,
    );
  }
}

void showPicker(context, int tipo) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Libería'),
                onTap: () {
                  Navigator.of(context).pop();
                  seleccionMultipleGallery(context, tipo);
                }),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Cámara'),
              onTap: () {
                //_imgFromCamera();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => tipo == 1
                        ? const CapturarFotoWidg()
                        : const CapturarEntregaFotoWidg(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
