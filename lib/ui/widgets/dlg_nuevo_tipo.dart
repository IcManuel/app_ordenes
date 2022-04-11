import 'package:app_ordenes/domains/blocs/nuevo_bloc.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogoNuevoTipo extends StatelessWidget {
  const DialogoNuevoTipo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nuevoBloc = Provider.of<NuevoBloc>(context);
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: size.height * .45,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              10,
            ),
            bottomLeft: Radius.circular(
              10,
            ),
            topRight: Radius.circular(
              10,
            ),
            bottomRight: Radius.circular(
              10,
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Crear tipo de producto'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nuevoBloc.ctrlCodigo,
                textCapitalization: TextCapitalization.characters,
                onChanged: (valor) {
                  nuevoBloc.codigo = valor.toUpperCase();
                },
                decoration: const InputDecoration(
                  hintText: 'Código',
                  labelText: 'Código',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nuevoBloc.ctrlNombre,
                textCapitalization: TextCapitalization.characters,
                onChanged: (valor) {
                  nuevoBloc.nombre = valor.toUpperCase();
                },
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03, vertical: size.height * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        nuevoBloc.crearTipo(context, size);
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
                          'GUARDAR',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
