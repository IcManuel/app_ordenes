import 'package:image_picker/image_picker.dart';

class FotoModel {
  FotoModel({
    required this.imagen,
    required this.nombre,
  });
  XFile imagen;
  String nombre = "";
}
