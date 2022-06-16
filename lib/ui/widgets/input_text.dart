import 'package:flutter/material.dart';

class ItemInput extends StatelessWidget {
  const ItemInput({
    Key? key,
    required this.size,
    required this.label,
    required this.inicialValue,
    required this.onText,
    required this.formato,
    this.textoOScuro = false,
  }) : super(key: key);

  final Size size;
  final String label;
  final String inicialValue;
  final Function(String) onText;
  final TextInputType formato;
  final bool textoOScuro;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          SizedBox(
            width: size.width * .25,
            child: Text(
              label,
              style: TextStyle(
                fontSize: size.height * 0.015,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          SizedBox(
            width: size.width * .6,
            child: SizedBox(
              height: size.height * .025,
              child: TextFormField(
                keyboardType: formato,
                obscureText: textoOScuro,
                textCapitalization: TextCapitalization.characters,
                initialValue: inicialValue,
                onChanged: (e) {
                  onText(e);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
