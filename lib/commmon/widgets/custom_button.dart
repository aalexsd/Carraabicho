// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:Carrrabicho/constants/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomButtom extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const CustomButtom({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: child,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
