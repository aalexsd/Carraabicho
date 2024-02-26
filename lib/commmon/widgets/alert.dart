import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<void> showAlertDialog1ok(BuildContext context, String mensagem,
    {int nPop = 1, int tipo = 0}) async {
  // configura o button
  Widget okButton = CupertinoDialogAction(
    child: Text("OK"),
    onPressed: () {
      int x;
      for (x = 0; x < nPop; x++) Navigator.of(context).pop();
    },
  );
  
  // configura o  AlertDialog
  Widget alerta = tipo == 0
      ? CupertinoAlertDialog(
          title: Text('Atenção'),
          content: Text(mensagem),
          actions: [okButton],
        )
      : CupertinoAlertDialog(
          title: Text('Sucesso'),
          content: Text(mensagem),
          actions: [okButton],
        );

  // exibe o dialog
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  } else {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
