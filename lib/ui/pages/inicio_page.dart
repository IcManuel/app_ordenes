import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/blocs/perfil_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/blocs/visual_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/ui/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final perfilBloc = Provider.of<PerfilBloc>(context);
    final size = MediaQuery.of(context).size;
    final visualBloc = Provider.of<VisualBloc>(context);
    final vehiculoBloc = Provider.of<VehiculoBloc>(context);
    final ordenBloc = Provider.of<OrdenBloc>(context);
    final detallesBloc = Provider.of<DetallesBloc>(context);
    final listaOrdenBloc = Provider.of<ListaOrdenBloc>(context);
    Preferencias pref = Preferencias();
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
              onPressed: () async {
                Navigator.pushNamed(context, 'orden');
                ordenBloc.habilitarGrabar = false;
                ordenBloc.modificar = false;
                detallesBloc.indexTab = 0;
                ordenBloc.idOrden = -1;
                await vehiculoBloc
                    .cargarCaracteristicas(perfilBloc.usuFinal.eprId);
                await visualBloc.cargarVisuales(perfilBloc.usuFinal.eprId);
                if (pref.usuario!.vehPorDefecto != null &&
                    pref.usuario!.vehPorDefecto!.trim().length > 0) {
                  vehiculoBloc.placa = pref.usuario!.vehPorDefecto ?? '';
                  await vehiculoBloc.buscarVehiculo(context, size, false);
                }
                ordenBloc.habilitarGrabar = true;
              },
              title: 'Nueva Orden',
              subtitle: 'Cree una nueva orden',
              icon: Icons.chevron_right,
            ),
            const SizedBox(
              height: 10,
            ),
            MenuItem(
              onPressed: () {
                listaOrdenBloc.filtrar(context, size, true);
                Navigator.pushNamed(context, 'lista_ordenes');
              },
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
