
import 'package:flutter/material.dart';

class Mensagem extends StatelessWidget {
  final String mensagem;

  Mensagem({this.mensagem, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      mensagem,
      style: TextStyle(
        color: Colors.amber,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    ));
  }
}
