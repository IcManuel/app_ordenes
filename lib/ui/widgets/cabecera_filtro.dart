import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:flutter/material.dart';

class CabeceraFiltro extends StatelessWidget {
  const CabeceraFiltro({
    Key? key,
    required this.size,
    required this.listaBloc,
  }) : super(key: key);

  final Size size;
  final ListaOrdenBloc listaBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.42,
      width: double.infinity,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController(
                          text: listaBloc.fechaI
                              .toIso8601String()
                              .substring(0, 10)),
                      decoration: const InputDecoration(
                        labelText: 'Fecha Inicio',
                        hintText: 'Fecha Inicio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: listaBloc.fechaI,
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 10))
                          .then((date) {
                        if (date != null) listaBloc.fechaI = date;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    child: TextField(
                      readOnly: true,
                      enabled: false,
                      controller: TextEditingController(
                          text: listaBloc.fechaF
                              .toIso8601String()
                              .substring(0, 10)),
                      decoration: const InputDecoration(
                        labelText: 'Fecha Fin',
                        hintText: 'Fecha Fin',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    onTap: () {
                      print('entra');
                      showDatePicker(
                              context: context,
                              initialDate: listaBloc.fechaF,
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 10))
                          .then((date) {
                        if (date != null) listaBloc.fechaF = date;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Radio(
                value: 4,
                groupValue: listaBloc.estado,
                onChanged: (value) {
                  listaBloc.estado = (value as int);
                },
              ),
              const Text(
                'Preguardadas',
                style: TextStyle(fontSize: 14.0),
              ),
              Radio(
                value: 2,
                groupValue: listaBloc.estado,
                onChanged: (value) {
                  listaBloc.estado = (value as int);
                },
              ),
              const Text(
                'Guardadas',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Radio(
                value: -1,
                groupValue: listaBloc.estado,
                onChanged: (value) {
                  listaBloc.estado = (value as int);
                },
              ),
              const Text(
                'Todas',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (valor) {
                    listaBloc.cliente = valor.toUpperCase();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Identificación/Nombres',
                    labelText: 'Identificación/Nombres',
                    border: OutlineInputBorder(),
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
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (valor) {
                    listaBloc.placa = valor.toUpperCase();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Placa',
                    labelText: 'Placa',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              BotonPrincipal(
                onPressed: () {
                  listaBloc.filtrar(context, size, false);
                },
                label: 'Filtrar',
                size: size,
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(-1, -1),
            spreadRadius: 3,
            blurRadius: 3,
            color: Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
