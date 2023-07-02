import 'dart:convert';
import 'dart:html';

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
  List<DropdownMenuItem<String>> linguas_disponiveis = [
    DropdownMenuItem(
      child: Text("portugues"),
      value: "portugues",
    ),
    DropdownMenuItem(child: Text("ingles"), value: "ingles"),
  ];

  String lingua_selecionada = "portugues";

  bool templateEnabled = true;
  bool lingua = false;

  List _items = [];

// Fetch content from the json file
  Future<void> readJson() async {
    String response;

    response = await rootBundle.loadString('traducao_$lingua_selecionada.json');

    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  List<Widget> aplicarDialogos() {
    List<Widget> listaDialogos = [];

    _items.forEach((dialogue) {
      //print(dialogue["position"]);
      //listaDialogos.add(Text(dialogue["dialogue"]));

      double position_top = dialogue["position"]["top"];
      double position_left = dialogue["position"]["left"];

      Widget dialogo = Positioned(
          top: position_top,
          left: position_left,
          child: Text(dialogue["dialogue"]));

      listaDialogos.add(dialogo);
    });

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
                  Text("Debug page!"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Ativar template e tradução: "),
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
                            Text("Alterar língua da tradução: "),
                            DropdownButton(
                                value: lingua_selecionada,
                                items: linguas_disponiveis,
                                onChanged: (newValue) {
                                  setState(() {
                                    lingua_selecionada = newValue!;
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
                      : Column(),
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
