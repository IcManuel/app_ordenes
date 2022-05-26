import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool closeSession;
  const MenuItem(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.closeSession = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: closeSession ? Colors.grey : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
        ],
      ),
      width: size.width * .8,
      height: size.height * .1,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(subtitle,
            style: TextStyle(color: Colors.white.withOpacity(.8))),
        onTap: onPressed,
        trailing: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
