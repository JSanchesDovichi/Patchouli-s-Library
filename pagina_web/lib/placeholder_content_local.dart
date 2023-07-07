import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlaceholderContentPageLocal extends StatefulWidget {
  const PlaceholderContentPageLocal({super.key});

  @override
  State<PlaceholderContentPageLocal> createState() =>
      _PlaceholderContentPageLocalState();
}

class _PlaceholderContentPageLocalState
    extends State<PlaceholderContentPageLocal> {
  List<DropdownMenuItem<String>> linguasDisponiveis = [
    const DropdownMenuItem(
      value: "portugues",
      child: Text("portugues"),
    ),
    const DropdownMenuItem(value: "ingles", child: Text("ingles")),
  ];

  String linguaSelecionada = "portugues";

  bool templateEnabled = true;
  bool lingua = false;

  List _items = [];

// Fetch content from the json file
  Future<void> readJson() async {
    String response;

    response = await rootBundle.loadString('traducao_$linguaSelecionada.json');

    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  List<Widget> aplicarDialogos() {
    List<Widget> listaDialogos = [];

    for (var dialogue in _items) {
      //print(dialogue["position"]);
      //listaDialogos.add(Text(dialogue["dialogue"]));

      double positionTop = dialogue["position"]["top"];
      double positionLeft = dialogue["position"]["left"];

      Widget dialogo = Positioned(
          top: positionTop,
          left: positionLeft,
          child: Text(dialogue["dialogue"]));

      listaDialogos.add(dialogo);
    }

    return listaDialogos;
  }

  @override
  Widget build(BuildContext context) {
    readJson();

    return Scaffold(
        body: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Debug page!"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ativar template e tradução: "),
                      Switch(
                        value: templateEnabled,
                        onChanged: (bool newValue) {
                          setState(() {
                            templateEnabled = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  templateEnabled
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Alterar língua da tradução: "),
                            DropdownButton(
                                value: linguaSelecionada,
                                items: linguasDisponiveis,
                                onChanged: (newValue) {
                                  setState(() {
                                    linguaSelecionada = newValue!;
                                  });
                                })
                            /*
                            Switch(
                              value: lingua,
                              onChanged: (bool newValue) {
                                setState(() {
                                  lingua = newValue;
                                });
                              },
                            ),
                            */
                          ],
                        )
                      : const Column(),
                  templateEnabled
                      ? Stack(
                          children: [
                            Image.network(
                                'http://localhost:3000/placeholder_page.jpg'),
                            Image.network(
                                'http://localhost:3000/placeholder_page_template.png'),

                            ///...traducaoPortugues
                            //...lingua ? traducaoIngles : traducaoPortugues

                            ...aplicarDialogos()
                          ],
                        )
                      : Stack(
                          children: [
                            Image.network(
                                'http://localhost:3000/placeholder_page.jpg'),
                          ],
                        ),
                ],
              ),
            )));
  }
}
