import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaUsuario extends StatelessWidget {
  const AyudaUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listaBloc = Provider.of<ListaOrdenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecccionar usuario'),
      ),
      body: listaBloc.cargandoUsuarios == false
          ? ListView.builder(
              itemCount: listaBloc.usuarios.length,
              itemBuilder: (BuildContext context, int index) {
                Usuario mod = listaBloc.usuarios[index];
                return ListTile(
                  title: Text(mod.usuNombres + " " + mod.usuApellidos),
                  //subtitle: Text(mod.marNombre),
                  onTap: () {
                    listaBloc.seleccionarUsuario(mod);
                    Navigator.pop(context);
                  },
                );
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
    );
  }
}
