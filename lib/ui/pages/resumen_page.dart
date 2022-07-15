import 'dart:io';

import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResumenPage extends StatelessWidget {
  const ResumenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detallesBloc = Provider.of<DetallesBloc>(context);
    final ordenBloc = Provider.of<OrdenBloc>(context);
    final fotosBloc = Provider.of<FotosBloc>(context);
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: colorPrincipal,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'fotos_ingreso');
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: colorPrincipal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_library,
                          size: size.height * 0.02,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'INGRESO (' + fotosBloc.fotos.length.toString() + ')',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 3),
                        blurRadius: 5),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'fotos_entrega');
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_library,
                          size: size.height * 0.02,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ENTREGA(' +
                              fotosBloc.fotosEntrega.length.toString() +
                              ')',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: ordenBloc.ctrlObsUsu,
          textCapitalization: TextCapitalization.characters,
          maxLines: 3,
          onChanged: (valor) {
            ordenBloc.observacionesUsu = valor.toUpperCase();
          },
          decoration: const InputDecoration(
            hintText: 'Observaciones',
            labelText: 'Observaciones',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: detallesBloc.ctrlTotalFinal,
          keyboardType: TextInputType.number,
          readOnly: true,
          decoration: const InputDecoration(
            hintText: 'Total',
            labelText: 'Total',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text('Tipo'),
            Radio(
              value: 1,
              groupValue: ordenBloc.tipo,
              onChanged: (value) {
                ordenBloc.tipo = (value as int);
              },
            ),
            const Text(
              'Guardar',
              style: TextStyle(fontSize: 16.0),
            ),
            Radio(
              value: 2,
              groupValue: ordenBloc.tipo,
              onChanged: (value) {
                ordenBloc.tipo = (value as int);
              },
            ),
            const Text(
              'Pre-guardar',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ordenBloc.tipo == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'firmar');
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 20,
                          primary: ordenBloc.controller.isEmpty
                              ? Colors.grey
                              : Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'FIRMAR',
                              style: TextStyle(
                                fontSize: size.height * 0.018,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: size.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ordenBloc.firma.imagen.path.isNotEmpty
                      ? Image.file(
                          File(ordenBloc.firma.imagen.path),
                          fit: BoxFit.fill,
                          width: 50,
                          height: 50,
                        )
                      : Container()
                ],
              )
            : Container(),
        BotonPrincipal(
          onPressed: () {
            ordenBloc.guardarProforma(context, size);
          },
          label: 'GUARDAR',
          size: size,
        ),
      ],
    );
  }
}
