import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlaceholderContentPage extends StatefulWidget {
  const PlaceholderContentPage({super.key});

  @override
  State<PlaceholderContentPage> createState() => _PlaceholderContentPageState();
}

/*
Future<Map<String, dynamic>> traducaoIngles() async {
  final String response = await rootBundle.loadString('traducao_ingles.json');
  final Map<String, dynamic> data = await json.decode(response);

  return data;
  /*
    setState(() {
      _items = data["items"];
    });
    */
}

Future<Map<String, dynamic>> traducaoPortugues() async {
  final String response =
      await rootBundle.loadString('traducao_portugues.json');
  final Map<String, dynamic> data = await json.decode(response);

  return data;
  /*
    setState(() {
      _items = data["items"];
    });
    */
}

Widget criarTraducao() {
  return FutureBuilder(
    future: traducaoPortugues(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text("Erro!");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        //return snapshot.data
        if (snapshot.hasData) {
          print(snapshot.data!.values);
        }
      }

      return LinearProgressIndicator();
    },
  );
}
*/

List<Widget> traducaoIngles = [
  Positioned(
    top: 990,
    left: 500,
    child: Text("Without any\nfriends, he\n set sail on\n a little boat."),
  ),
  Positioned(
    top: 675,
    left: 50,
    child: Text("The\nking\nof\npirates!!!!"),
  ),
  Positioned(
    top: 400,
    left: 575,
    child: Text("I'll\nbecome"),
  ),
  Positioned(
    top: 150,
    left: 50,
    child: Text("Alright,\nlet's go!!!"),
  ),
  Positioned(
    top: 975,
    left: 75,
    child: Text("A long\njourney\nhas begun!!!"),
  ),
];

List<Widget> traducaoPortugues = [
  Positioned(
    top: 150,
    left: 50,
    child: Text("Beleza,\nvamos nessa!!"),
  ),
  Positioned(
    top: 400,
    left: 575,
    child: Text("Eu \nvou..."),
  ),
  Positioned(
    top: 675,
    left: 50,
    child: Text("Ser o rei\ndos piratas!!"),
  ),
  Positioned(
    top: 975,
    left: 75,
    child: Text("Uma longa\njornada começou!"),
  ),
  Positioned(
    top: 990,
    left: 500,
    child: Text("Sozinho ele veleja!"),
  ),
];

class _PlaceholderContentPageState extends State<PlaceholderContentPage> {
  bool templateEnabled = true;
  bool lingua = false;

  List _items = [];

// Fetch content from the json file
  Future<void> readJson() async {
    String response;

    if (lingua) {
      response = await rootBundle.loadString('traducao_portugues.json');
    } else {
      response = await rootBundle.loadString('traducao_ingles.json');
    }

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
                            Switch(
                              value: lingua,
                              onChanged: (bool newValue) {
                                setState(() {
                                  lingua = newValue;
                                });
                              },
                            ),
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
