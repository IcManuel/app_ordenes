import 'package:flutter/material.dart';

class InputCheck extends StatelessWidget {
  const InputCheck({
    Key? key,
    required this.size,
    this.value,
    required this.onBool,
    required this.label,
  }) : super(key: key);

  final Size size;
  final bool? value;
  final Function(bool?) onBool;
  final String label;

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
            width: size.width * .3,
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
            width: size.width * .1,
            child: SizedBox(
              height: size.height * .015,
              child: Checkbox(
                value: value,
                onChanged: onBool,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
