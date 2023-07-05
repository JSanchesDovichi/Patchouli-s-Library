/*
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'ElementoTraducaoTeste.dart';

class EditorResources {
  static final EditorResources _singleton = EditorResources._internal();

  //Function? atualizarTela;
  Uint8List? imagemBase;
  List<ElementoTeste> listaElementos = [];
  List<Widget> camadas = [];
  List<Widget> elementosGraficos = [];

  List<Widget> gerarCamadas() {
    //List<Widget> lista = [];
    camadas.clear();

    for (ElementoTeste elemento in listaElementos) {
      camadas.add(elemento.gerarCamada());
    }

    return camadas;

    /*
    print("Retornando {$lista.length} camadas!");
    return lista;
    */
  }
  //List<Widget> gerarElementosGraficos() {}

  factory EditorResources() {
    return _singleton;
  }

  EditorResources._internal();
}
*/
