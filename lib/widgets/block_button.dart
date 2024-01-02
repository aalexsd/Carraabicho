import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  final buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    padding: const EdgeInsets.all(12),
    backgroundColor: Colors.black,
  );

  BlockButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: buttonStyle, onPressed: onPressed, child: child)),
    );
  }
}
