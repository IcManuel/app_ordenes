import 'package:app_ordenes/domains/blocs/crear_cuenta_bloc.dart';
import 'package:app_ordenes/models/caracteristica_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:flutter/material.dart';

class CreacionPasoDos extends StatelessWidget {
  const CreacionPasoDos({
    Key? key,
    required this.size,
    required this.crearCuentaBloc,
  }) : super(key: key);

  final Size size;
  final CrearCuentaBloc crearCuentaBloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: size.width * .6,
            child: BotonPrincipal(
              onPressed: () {
                crearCuentaBloc.nuevaCaracteristica(context);
              },
              label: "AGREGAR NUEVA",
              size: size,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: size.height * .4,
            child: Container(
                width: size.width * .85,
                decoration: BoxDecoration(
                  border: Border.all(color: colorPrincipal.shade500),
                ),
                child: ListView.builder(
                  itemCount: crearCuentaBloc.caracteristicas.length,
                  itemBuilder: (BuildContext context, int index) {
                    Caracteristica mod = crearCuentaBloc.caracteristicas[index];
                    return ListTile(
                      title: Text(mod.carNombre),
                      leading: IconButton(
                        onPressed: () {
                          crearCuentaBloc.modificarCaracteristica(
                              context, mod, index);
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          crearCuentaBloc.borrarCaracteristica(index);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      //subtitle: Text(mod.marNombre),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
