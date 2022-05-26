import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Size size;
  final bool? calcTamano;
  final bool habilitado;
  const BotonPrincipal({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.size,
    this.habilitado = true,
    this.calcTamano = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: calcTamano == true ? size.width * 0.03 : double.infinity,
          vertical: size.height * .01),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: colorPrincipal,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 3),
              blurRadius: 5,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              elevation: 10,
              primary: colorPrincipal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.02),
            child: Text(
              label,
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
