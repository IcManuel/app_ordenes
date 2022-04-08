import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogoGeneral extends StatelessWidget {
  const DialogoGeneral({
    Key? key,
    required this.size,
    required this.lottie,
    required this.titulo,
    this.texto,
    required this.textoBtn1,
    required this.mostrarBoton1,
    required this.mostrarBoton2,
    required this.accion1,
    this.textoBtn2 = "",
    required this.accion2,
  }) : super(key: key);

  final Size size;
  final String lottie;
  final String titulo;
  final String? texto;
  final String textoBtn1;
  final String textoBtn2;
  final bool mostrarBoton1;
  final bool mostrarBoton2;
  final VoidCallback accion1;
  final VoidCallback accion2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: size.height * .20,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              100,
            ),
            bottomLeft: Radius.circular(
              100,
            ),
            topRight: Radius.circular(
              10,
            ),
            bottomRight: Radius.circular(
              10,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02),
          child: Row(
            children: [
              Container(
                width: size.height * .12,
                height: size.height * .12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Lottie.asset(
                  lottie,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      titulo,
                      style: TextStyle(
                        fontSize: size.height * .03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .008,
                    ),
                    SizedBox(
                      width: size.width * .4,
                      child: Text(
                        texto!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: size.height * .015,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mostrarBoton2
                            ? ElevatedButton(
                                onPressed: () {
                                  accion2();
                                },
                                child: Text(textoBtn2,
                                    style: TextStyle(
                                      color: colorPrincipal,
                                    )),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        mostrarBoton1
                            ? ElevatedButton(
                                onPressed: () {
                                  accion1();
                                },
                                child: Text(
                                  textoBtn1,
                                  style: TextStyle(
                                    color: colorPrincipal,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
