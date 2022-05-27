import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AyudaCliente extends StatelessWidget {
  const AyudaCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordenbloc = Provider.of<OrdenBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cliente'),
        actions: [
          ElevatedButton(
            onPressed: () {
              ordenbloc.guardarNuevo(context, size);
            },
            child: Text(
              'Guardar',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          SizedBox(
            height: (Preferencias().usuario!.validarCedula ?? false) ? 15 : 1,
          ),
          (Preferencias().usuario!.validarCedula ?? false)
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      right: size.width * .3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tipo identificacion',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        DropdownButton<String>(
                          value: ordenbloc.tipoIdentificacion,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: colorPrincipal,
                          ),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: colorPrincipal,
                          ),
                          onChanged: (String? newValue) {
                            ordenbloc.tipoIdentificacion = newValue!;
                          },
                          items: <String>[
                            'CEDULA',
                            'RUC',
                            'PASAPORTE',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 15,
          ),
          TextField(
            onChanged: (valor) {
              ordenbloc.nuevo.cliIdentificacion = valor;
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              labelText: 'Identificación',
              hintText: 'Identificación',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (valor) {
              ordenbloc.nuevo.cliNombres = valor;
            },
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'Nombres',
              hintText: 'Nombres',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: (valor) {
              ordenbloc.nuevo.cliCelular = valor;
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
            keyboardType: TextInputType.emailAddress,
            onChanged: (valor) {
              ordenbloc.nuevo.cliCorreo = valor;
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
            textCapitalization: TextCapitalization.characters,
            maxLines: 2,
            onChanged: (valor) {
              ordenbloc.nuevo.cliDireccion = valor;
            },
            decoration: const InputDecoration(
              hintText: 'Dirección',
              labelText: 'Dirección',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
