import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/utils/imagen_selector.dart';
import 'package:app_ordenes/ui/widgets/ver_imagen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class FotosIngreso extends StatelessWidget {
  const FotosIngreso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fotoBloc = Provider.of<FotosBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Fotos de ingreso')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Seleccionar'),
              onPressed: () {
                showPicker(context, 1);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                height: size.height * .7,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: fotoBloc.fotos.length,
                  itemBuilder: (context, index) {
                    final foto = fotoBloc.fotos[index];
                    return InkWell(
                      onTap: () {
                        fotoBloc.fotoSelect = foto;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VerImagenPage(
                              index: fotoBloc.fotos.indexOf(foto),
                              tipo: 1,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.file(
                                  File(foto.imagen.path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                foto.nombre,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
