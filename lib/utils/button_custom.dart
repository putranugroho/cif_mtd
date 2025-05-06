import 'package:flutter/material.dart';

import 'colors.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;

  const ButtonIcon({Key? key, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorPrimary,
                colorSecondary,
              ])),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class ButtonPrimary extends StatelessWidget {
  final String? name;
  final IconData? icon;
  final Function onTap;
  const ButtonPrimary({super.key, this.name, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorPrimary,
          border: Border.all(
            width: 2,
            color: colorPrimary,
          ),
        ),
        child: Text(
          "$name",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ButtonDanger extends StatelessWidget {
  final String? name;
  final Function onTap;
  const ButtonDanger({Key? key, this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 2,
              color: Colors.red,
            ),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red[900] ?? Colors.transparent,
                  Colors.red,
                ])),
        child: Text(
          "$name",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  final String? name;
  final Function onTap;
  const ButtonSecondary({Key? key, this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[800],
          border: Border.all(
            width: 2,
            color: Colors.grey[800] ?? Colors.transparent,
          ),
        ),
        child: Text(
          "$name",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
