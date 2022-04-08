import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogoCargando extends StatelessWidget {
  const DialogoCargando({
    Key? key,
    this.texto = "Cargando",
  }) : super(key: key);
  final String texto;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: size.height * .20,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.7),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(100, 20),
                topRight: Radius.elliptical(100, 20),
                bottomRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .2,
                height: size.height * .1,
                child: Lottie.asset('assets/lotties/loading_2.json'),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              Text(
                texto,
                style: TextStyle(
                  color: colorPrincipal,
                ),
              )
            ],
          ),
        ));
  }
}
