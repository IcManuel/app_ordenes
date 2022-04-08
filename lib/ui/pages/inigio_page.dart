import 'package:app_ordenes/domains/blocs/perfil_bloc.dart';
import 'package:app_ordenes/ui/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final perfilBloc = Provider.of<PerfilBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Menú'),
            SizedBox(
              width: 10,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              perfilBloc.cerrarSesion(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MenuItem(
              onPressed: () {
                Navigator.pushNamed(context, 'orden');
              },
              title: 'Nueva Orden',
              subtitle: 'Cree una nueva orden',
              icon: Icons.chevron_right,
            ),
            const SizedBox(
              height: 10,
            ),
            MenuItem(
              onPressed: () {},
              title: 'Listado de órdenes',
              subtitle: 'Ver/modificar órdenes creadas',
              icon: Icons.chevron_right,
            ),
            const Expanded(
              child: SizedBox(
                height: 130,
              ),
            ),
            MenuItem(
              onPressed: () {
                perfilBloc.encerarDatos();
                Navigator.pushNamed(context, 'perfil');
              },
              title: 'Perfil',
              subtitle: 'Modificar datos de perfil',
              icon: Icons.emoji_people_sharp,
              closeSession: true,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
