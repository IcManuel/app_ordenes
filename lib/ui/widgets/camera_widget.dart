import 'dart:io';

import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/utils/imagen_selector.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CapturarFotoWidg extends StatefulWidget {
  const CapturarFotoWidg({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _CapturarFotoWidgetState createState() {
    return _CapturarFotoWidgetState();
  }
}

class _CapturarFotoWidgetState extends State {
  CameraController? controller;
  List? cameras;
  List<XFile> photos = [];
  late int selectedCameraIdx;
  late String imagePath;
  bool flash = false;
  bool tomando = false;

  @override
  void initState() {
    tomando = false;
    flash = false;
    super.initState();
    photos = [];
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras!.isNotEmpty) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras![selectedCameraIdx], 1).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  Future _initCameraController(
      CameraDescription cameraDescription, int tipo) async {
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
      controller!.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            onPressed: () async {
              await controller!
                  .setFlashMode(flash ? FlashMode.off : FlashMode.torch);
              flash = !flash;
              setState(() {});
            },
            icon: Icon(
              flash ? Icons.light_mode_rounded : Icons.light_mode_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              height: size.height,
              child: _cameraPreviewWidget(),
            ),
            _cameraTogglesRowWidget(context, 1),
            _captureControlRowWidget(context, 1),
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Container(
                height: 75,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photos.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: Image.file(
                                File(photos[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: -15,
                              right: -15,
                              child: IconButton(
                                  onPressed: () {
                                    photos.remove(photos[index]);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 18,
                                  )),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 130,
              child: GestureDetector(
                onTap: () {
                  if (photos.isNotEmpty) {
                    final bloc = Provider.of<FotosBloc>(context, listen: false);
                    bloc.anadirFotos(photos, 1);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: photos.isNotEmpty
                        ? colorPrincipal
                        : Colors.grey.shade400,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 5,
                        child: Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          photos.length.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Display Camera preview.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Cargando...',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: CameraPreview(controller!),
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _captureControlRowWidget(
    context,
    int tipo,
  ) {
    return GestureDetector(
      onTap: () {
        _onCapturePressed(
          context,
          tipo,
        );
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget(BuildContext context, int tipo) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: colorPrincipal.withOpacity(.3),
        ),
        child: IconButton(
          onPressed: () {
            //Navigator.of(context).pop();
            seleccionMultipleGallery(context, tipo, true);
          },
          icon: Icon(
            Icons.image,
            size: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _onCapturePressed(context, int tipo) async {
    try {
      if (!tomando) {
        tomando = true;
        XFile dato = await controller!.takePicture();
        photos.insert(0, dato);
        print(photos.length);
        setState(() {});
        tomando = false;
      }
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }
}
