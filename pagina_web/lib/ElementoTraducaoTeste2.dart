import 'dart:js_interop';

import 'package:flutter/material.dart';

class ElementoTeste2 {
  int editorKey;
  double posTop;
  double posLeft;
  String texto;
  double fontSize = 14;
  String fontFamily = 'Roboto';
  Color? corFonte;
  Color? corFundo;

  ElementoTeste2(this.editorKey, this.texto, this.posTop, this.posLeft);

  Widget gerarElementoGrafico() {
    return Positioned(
      top: posTop,
      left: posLeft,
      child:
          //Material(child:
          Text(
        texto,
        style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            //fontSize: fontSize!.isDefinedAndNotNull ? fontSize : 14,
            //color: corFonte.isDefinedAndNotNull ? corFonte : Colors.black,
            color: corFonte,
            //backgroundColor: corFonte.isDefinedAndNotNull ? corFundo : Colors.white),
            backgroundColor: corFundo),
        //)
      ),
    );
  }

  Widget gerar() {
    return Positioned(
      top: posTop,
      left: posLeft,
      child:
          //Material(child:
          Text(
        texto,
        style: TextStyle(
            /*
            fontSize: fontSize.isDefinedAndNotNull ? fontSize : 14,
            color: corFonte.isDefinedAndNotNull ? corFonte : Colors.black,
            backgroundColor: corFonte.isDefinedAndNotNull ? corFundo : Colors.white),
            */
            fontSize: fontSize,
            color: corFonte,
            backgroundColor: corFundo),
        //)
      ),
    );
  }
}
