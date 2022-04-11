import 'package:app_ordenes/domains/blocs/perfil_bloc.dart';
import 'package:app_ordenes/ui/widgets/input_check.dart';
import 'package:app_ordenes/ui/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final perfilBloc = Provider.of<PerfilBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Perfil'),
            SizedBox(
              width: 10,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              perfilBloc.guardarCambios(context, size);
            },
            icon: const Icon(
              Icons.save,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        reverse: false,
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              ItemInput(
                size: size,
                label: 'Nombres',
                formato: TextInputType.text,
                inicialValue: perfilBloc.usuFinal.usuNombres,
                onText: (e) {
                  perfilBloc.nombres = e;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ItemInput(
                size: size,
                formato: TextInputType.text,
                label: 'Apellidos',
                inicialValue: perfilBloc.usuFinal.usuApellidos,
                onText: (e) {
                  perfilBloc.apellidos = e;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ItemInput(
                size: size,
                formato: TextInputType.text,
                label: 'Correo',
                inicialValue: perfilBloc.usuFinal.usuCorreo,
                onText: (e) {
                  perfilBloc.correo = e;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InputCheck(
                size: size,
                label: 'Cambiar clave',
                value: perfilBloc.cambioClave,
                onBool: (bool? e) {
                  perfilBloc.cambioClave = e;
                },
              ),
              SizedBox(
                height: perfilBloc.cambioClave == true ? 20 : 0,
              ),
              perfilBloc.cambioClave == true
                  ? ItemInput(
                      size: size,
                      formato: TextInputType.text,
                      label: 'Clave actual',
                      textoOScuro: true,
                      inicialValue: perfilBloc.claveAntigua,
                      onText: (e) {
                        perfilBloc.claveAntigua = e;
                      },
                    )
                  : const SizedBox(),
              SizedBox(
                height: perfilBloc.cambioClave == true ? 20 : 0,
              ),
              perfilBloc.cambioClave == true
                  ? ItemInput(
                      size: size,
                      formato: TextInputType.text,
                      label: 'Clave nueva',
                      textoOScuro: true,
                      inicialValue: perfilBloc.claveNueva,
                      onText: (e) {
                        perfilBloc.claveNueva = e;
                      },
                    )
                  : const SizedBox(),
              SizedBox(
                height: perfilBloc.cambioClave == true ? 20 : 0,
              ),
              perfilBloc.cambioClave == true
                  ? ItemInput(
                      size: size,
                      formato: TextInputType.text,
                      label: 'Conf. clave',
                      textoOScuro: true,
                      inicialValue: perfilBloc.confClave,
                      onText: (e) {
                        perfilBloc.confClave = e;
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
