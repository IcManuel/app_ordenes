import 'dart:io';

import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PdfImpresion extends StatelessWidget {
  const PdfImpresion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blocProforma = Provider.of<OrdenBloc>(context, listen: true);
    final listaOrdenBloc = Provider.of<ListaOrdenBloc>(context, listen: true);
    final pdfController = PdfController(
      document:
          PdfDocument.openData(File(blocProforma.pdfArchivo).readAsBytesSync()),
    );

    return WillPopScope(
      onWillPop: () async {
        listaOrdenBloc.filtrar(context, size, true);
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Impresión'),
          ),
          body: Column(
            children: [
              Expanded(
                  child: PdfView(
                controller: pdfController,
              )),
              BotonPrincipal(
                label: 'Descargar PDF',
                onPressed: () async {
                  /**final Directory? extDir = await getExternalStorageDirectory();
                  String dirPath = '${extDir!.path}Download';
                  dirPath = dirPath.replaceAll(
                      "Android/data/ec.vite.app_ordenes/files", "");
                  File pdf = File(blocProforma.pdfArchivo);
                  pdf.copy('$dirPath/${blocProforma.pdfNombre}');
                  Navigator.pop(context);
                  Navigator.pop(context);
                  **/
                  await OpenFile.open(blocProforma.pdfArchivo);
                },
                size: size,
              )
            ],
          )),
    );
  }
}
