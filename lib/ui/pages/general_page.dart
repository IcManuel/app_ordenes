import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordenbloc = Provider.of<OrdenBloc>(context);
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    Preferencias pref = Preferencias();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (valor) {
                    if (valor != ayudaBloc.filtro) {
                      ayudaBloc.habNombre = true;
                      ayudaBloc.habIdent = false;
                      ordenbloc.cambioIdentificacion(
                        context,
                        valor,
                        2,
                      );
                      ordenbloc.tipoFiltro = 2;
                      ayudaBloc.mostrarLista = true;
                      ayudaBloc.filtro = valor;
                      if (!ayudaBloc.escribiendo) {
                        ayudaBloc.escribiendo = true;
                        Future.delayed(const Duration(
                          seconds: 2,
                        )).whenComplete(() async {
                          ayudaBloc.escribiendo = false;
                          if (!ayudaBloc.consultando) {
                            ayudaBloc.cargarLista(pref, 2, context);
                          }
                        });
                      }
                    }
                  },
                  enabled: ordenbloc.modificar ? false : ayudaBloc.habNombre,
                  controller: ordenbloc.ctrlNombres,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: 'Nombres',
                    hintText: 'Nombres',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (!ordenbloc.modificar) {
                    ordenbloc.nuevoCliente(context);
                  }
                },
                icon: Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 40,
                  color: !ordenbloc.modificar ? Colors.green : Colors.grey,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (valor) {
              if (valor != ayudaBloc.filtro) {
                ayudaBloc.habNombre = false;
                ayudaBloc.habIdent = true;
                ordenbloc.cambioIdentificacion(
                  context,
                  valor,
                  1,
                );
                ordenbloc.tipoFiltro = 1;
                ayudaBloc.mostrarLista = true;
                ayudaBloc.filtro = valor;
                if (!ayudaBloc.escribiendo) {
                  ayudaBloc.escribiendo = true;
                  Future.delayed(const Duration(
                    seconds: 2,
                  )).whenComplete(() async {
                    ayudaBloc.escribiendo = false;
                    if (!ayudaBloc.consultando) {
                      ayudaBloc.cargarLista(pref, 1, context);
                    }
                  });
                }
              }
            },
            enabled: ordenbloc.modificar ? false : ayudaBloc.habIdent,
            controller: ordenbloc.ctrlIdentificacion,
            decoration: const InputDecoration(
              labelText: 'Identificación',
              hintText: 'Identificación',
              border: OutlineInputBorder(),
            ),
          ),
          ayudaBloc.mostrarLista
              ? ayudaBloc.escribiendo
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
                          child: ListView.builder(
                            itemCount: ayudaBloc.clientes.length,
                            itemBuilder: (BuildContext context, int index) {
                              Cliente pro = ayudaBloc.clientes[index];
                              return InkWell(
                                onTap: () {
                                  ordenbloc.seleccionar(context, pro);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(0, 83, 79, 1),
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
                                            fontSize: ordenbloc.tipoFiltro == 1
                                                ? 18
                                                : 14,
                                            fontWeight:
                                                ordenbloc.tipoFiltro == 1
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          pro.cliNombres!,
                                          style: TextStyle(
                                            fontSize: ordenbloc.tipoFiltro == 1
                                                ? 14
                                                : 18,
                                            fontWeight:
                                                ordenbloc.tipoFiltro == 2
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
                          ),
                        )
              : SizedBox(
                  height: 1,
                ),
          ayudaBloc.mostrarLista
              ? Container()
              : Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: ordenbloc.ctrlTelefono,
                        enabled: false,
                        textCapitalization: TextCapitalization.characters,
                        onChanged: (valor) {
                          ordenbloc.telefono = valor.toUpperCase();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Telfs',
                          labelText: 'Telfs',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: ordenbloc.ctrlCorreo,
                        enabled: false,
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (valor) {
                          ordenbloc.correo = valor.toUpperCase();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Correo ',
                          labelText: 'Correo ',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: ordenbloc.ctrlDireccion,
                        enabled: false,
                        textCapitalization: TextCapitalization.characters,
                        maxLines: 2,
                        onChanged: (valor) {
                          ordenbloc.direccion = valor.toUpperCase();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Dirección',
                          labelText: 'Dirección',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: ordenbloc.ctrlObs,
                        textCapitalization: TextCapitalization.characters,
                        maxLines: 4,
                        onChanged: (valor) {
                          ordenbloc.observaciones = valor.toUpperCase();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Observaciones cliente para reparación',
                          labelText: 'Observaciones cliente para reparación',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
