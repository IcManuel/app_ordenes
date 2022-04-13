import 'dart:io';

import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class VerImagenPage extends StatelessWidget {
  const VerImagenPage({
    Key? key,
    required this.index,
    required this.tipo,
  }) : super(key: key);
  final int index;
  final int tipo;
  @override
  Widget build(BuildContext context) {
    final fotoBloc = Provider.of<FotosBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver imagen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: () {
                fotoBloc.eliminarFoto(index, tipo);
                Navigator.pop(context);
              },
              child: const Icon(Icons.delete),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: () {
                fotoBloc.setearNombre(index, fotoBloc.fotoSelect.nombre, tipo);
                Navigator.pop(context);
              },
              child: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PhotoView(
              imageProvider: FileImage(
                File(fotoBloc.fotoSelect.imagen.path),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.height * .01),
            child: TextFormField(
              maxLines: 3,
              initialValue: fotoBloc.fotoSelect.nombre,
              onChanged: (e) {
                fotoBloc.fotoSelect.nombre = e;
              },
              decoration: const InputDecoration(
                hintText: 'Ingresar observaciones',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
