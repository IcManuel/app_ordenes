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
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: closeSession ? Colors.grey : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10)),
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
