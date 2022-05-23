import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
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
        TextField(
          controller: ordenBloc.ctrlObsUsu,
          textCapitalization: TextCapitalization.characters,
          maxLines: 4,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                  child: Text(
                    'FOTOS INGRESO (' + fotosBloc.fotos.length.toString() + ')',
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
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
                  child: Text(
                    'FOTOS ENTREGA(' +
                        fotosBloc.fotosEntrega.length.toString() +
                        ')',
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: Colors.white,
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
        BotonPrincipal(
          onPressed: () {
            ordenBloc.guardarProforma(context, size);
          },
          label: 'GRABAR',
          size: size,
        ),
      ],
    );
  }
}
