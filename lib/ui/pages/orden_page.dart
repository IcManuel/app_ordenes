import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/blocs/visual_bloc.dart';
import 'package:app_ordenes/ui/pages/detalles_page.dart';
import 'package:app_ordenes/ui/pages/general_page.dart';
import 'package:app_ordenes/ui/pages/resumen_page.dart';
import 'package:app_ordenes/ui/pages/vehiculo_page.dart';
import 'package:app_ordenes/ui/pages/visual_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdenPage extends StatelessWidget {
  const OrdenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordenBloc = Provider.of<OrdenBloc>(context);
    final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
    final visual = Provider.of<VisualBloc>(context, listen: false);
    final fotosBloc = Provider.of<FotosBloc>(context, listen: false);
    final detallesBloc = Provider.of<DetallesBloc>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (detallesBloc.indexTab == 3) {
          if (detallesBloc.mostrarFormulario) {
            detallesBloc.mostrarFormulario = false;
            return false;
          } else {
            detallesBloc.confimarSalir(context, vehiculoBloc, detallesBloc,
                visual, fotosBloc, ordenBloc);
            return false;
          }
        } else {
          detallesBloc.confimarSalir(context, vehiculoBloc, detallesBloc,
              visual, fotosBloc, ordenBloc);
          return false;
        }
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Orden' +
                (ordenBloc.modificar == true
                    ? ' #' + ordenBloc.numeroOrden.toString()
                    : '')),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                if (detallesBloc.indexTab == 3) {
                  if (detallesBloc.mostrarFormulario) {
                    detallesBloc.mostrarFormulario = false;
                  } else {
                    detallesBloc.confimarSalir(context, vehiculoBloc,
                        detallesBloc, visual, fotosBloc, ordenBloc);
                  }
                } else {
                  detallesBloc.confimarSalir(context, vehiculoBloc,
                      detallesBloc, visual, fotosBloc, ordenBloc);
                }
              },
            ),
            bottom: TabBar(
              onTap: (ifx) {
                detallesBloc.indexTab = ifx;
              },
              tabs: [
                const Tab(
                  icon: Icon(Icons.supervised_user_circle),
                  text: 'General',
                ),
                Tab(
                  icon: const Icon(Icons.car_repair),
                  text: vehiculoBloc.palabraClave.toLowerCase(),
                ),
                const Tab(
                  icon: Icon(Icons.remove_red_eye),
                  text: 'Visual',
                ),
                const Tab(
                  icon: Icon(Icons.note_add),
                  text: 'Detalles',
                ),
                const Tab(
                  icon: Icon(Icons.list),
                  text: 'Resumen',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              GeneralPage(),
              VehiculoPage(),
              VisualPage(),
              DetallesPage(),
              ResumenPage(),
            ],
          ),
        ),
      ),
    );
  }
}
