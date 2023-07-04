import 'dart:js_interop';

import 'package:flutter/material.dart';

class ElementoTeste {
  double posTop;
  double posLeft;
  String texto;
  double fontSize = 14;
  Color? corFonte;
  Color? corFundo;
  //Widget child;

  ElementoTeste(this.texto, this.posTop, this.posLeft);

  Widget gerar() {
    return Positioned(
      top: posTop,
      left: posLeft,
      child:
          //Material(child:
          Text(
        texto,
        style: TextStyle(
            fontSize: fontSize.isDefinedAndNotNull ? fontSize : 14,
            color: corFonte.isDefinedAndNotNull ? corFonte : Colors.black,
            backgroundColor:
                corFonte.isDefinedAndNotNull ? corFundo : Colors.white),
        //)
      ),
    );
  }
}
