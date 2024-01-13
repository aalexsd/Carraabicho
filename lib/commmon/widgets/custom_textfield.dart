// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onSaved;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? enabled;
  final bool? valida;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatter,
    this.onSaved,
    this.enabled = true,
    this.valida = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
      child: TextFormField(
        enabled: enabled!,
        inputFormatters: inputFormatter,
        onSaved: (value) {
          onSaved!();
        },
        obscureText: obscureText!,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          suffixIcon: suffixIcon,
        ),
        validator: (value) {
          if(valida == false){
            return null;
          }
          if (value == null || value.isEmpty) {
            return '$hintText é um campo obrigatório';
          }
          return null;
        },
      ),
    );
  }
}
