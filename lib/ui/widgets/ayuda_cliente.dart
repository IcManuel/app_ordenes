import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaCliente extends StatelessWidget {
  const AyudaCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferencias pref = Preferencias();
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    final ordenBloc = Provider.of<OrdenBloc>(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ayudaBloc.ctrlFiltro,
              textCapitalization: TextCapitalization.characters,
              onChanged: (valor) {
                ayudaBloc.filtro = valor;
                if (!ayudaBloc.escribiendo) {
                  ayudaBloc.escribiendo = true;
                  Future.delayed(const Duration(seconds: 3))
                      .whenComplete(() async {
                    ayudaBloc.escribiendo = false;
                    if (!ayudaBloc.consultando) {
                      ayudaBloc.cargarLista(pref, arguments['tipo']);
                    }
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Buscar por ' +
                    (arguments['tipo'] == 1 ? ' identificación ' : 'nombre '),
                labelText: 'Buscar por ' +
                    (arguments['tipo'] == 1 ? ' identificación ' : 'nombre '),
                border: const OutlineInputBorder(),
              ),
            ),
            ayudaBloc.escribiendo
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  )
                : ayudaBloc.consultando
                    ? const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : Expanded(
                        child: ayudaBloc.clientes.isNotEmpty
                            ? ListView.builder(
                                itemCount: ayudaBloc.clientes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Cliente pro = ayudaBloc.clientes[index];
                                  return InkWell(
                                    onTap: () {
                                      ordenBloc.seleccionar(context, pro);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  Color.fromRGBO(0, 83, 79, 1),
                                              width: 0.2),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pro.cliIdentificacion,
                                              style: TextStyle(
                                                fontSize: arguments['tipo'] == 1
                                                    ? 18
                                                    : 14,
                                                fontWeight:
                                                    arguments['tipo'] == 1
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              pro.cliNombres!,
                                              style: TextStyle(
                                                fontSize: arguments['tipo'] == 1
                                                    ? 14
                                                    : 18,
                                                fontWeight:
                                                    arguments['tipo'] == 2
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              pro.cliCelular!,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                            Text(
                                              pro.cliDireccion!,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Text(
                                'No se ha encontrado información... ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                      ),
          ],
        ),
      ),
    );
  }
}
