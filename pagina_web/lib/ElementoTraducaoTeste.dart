import 'package:flutter/material.dart';

class ElementoTeste {
  double posTop;
  double posLeft;
  String texto;
  //Widget child;

  ElementoTeste(this.texto, this.posTop, this.posLeft);

  Widget gerar() {
    return Positioned(
      top: this.posTop,
      left: this.posLeft,
      child: Material(child: Text(this.texto)),
    );
  }
}
