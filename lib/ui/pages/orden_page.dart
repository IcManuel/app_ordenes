import 'package:app_ordenes/ui/pages/detalles_page.dart';
import 'package:app_ordenes/ui/pages/general_page.dart';
import 'package:app_ordenes/ui/pages/vehiculo_page.dart';
import 'package:app_ordenes/ui/pages/visual_page.dart';
import 'package:flutter/material.dart';

class OrdenPage extends StatelessWidget {
  const OrdenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orden'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.supervised_user_circle),
                text: 'General',
              ),
              Tab(
                icon: Icon(Icons.car_repair),
                text: 'Vehiculo',
              ),
              Tab(
                icon: Icon(Icons.remove_red_eye),
                text: 'Visual',
              ),
              Tab(
                icon: Icon(Icons.note_add),
                text: 'Detalles',
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
          ],
        ),
      ),
    );
  }
}
