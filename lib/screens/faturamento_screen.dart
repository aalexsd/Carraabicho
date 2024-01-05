import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FaturamentoScreen extends StatefulWidget {
  const FaturamentoScreen({super.key});

  @override
  State<FaturamentoScreen> createState() => _FaturamentoScreenState();
}

class _FaturamentoScreenState extends State<FaturamentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faturamento"),
        elevation: 1,
      ),
    );
  }
}