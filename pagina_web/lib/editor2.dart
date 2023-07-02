import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagina_web/global_resources.dart';
import 'ElementoTraducaoTeste.dart';

Uint8List? imagemBase;
List<ElementoTeste> listaElementos = [];
//List<Widget> camadas = [];
//List<int> _items = List<int>.generate(0, (int index) => index);

List<Widget> pilhaCamadas() {
  List<Widget> camadas = [];

  for (ElementoTeste elemento in listaElementos) {
    camadas.add(elemento.gerar());
  }

  return camadas;
}

class Editor2 extends StatefulWidget {
  const Editor2({super.key});

  @override
  State<Editor2> createState() => _Editor2State();
}

Widget dialogoAlerta(BuildContext context, Function atualizarTela) {
  return AlertDialog(
    title: Text("Boas vindas!", textAlign: TextAlign.center),
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    content: Text(
        "Para iniciar o editor de template, escolha uma imagem do seu computador:",
        textAlign: TextAlign.center),
    actions: [
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton(
                onPressed: () {
                  context.go('/DebugToolbox');
                },
                child: Text("Voltar")),
            FilledButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  XFile? imagem =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (imagem.isNull) {
                    Resources.logger.e("Erro: a imagem está nula!");
                    return;
                  }

                  Uint8List bytesImagem = await imagem!.readAsBytes();

                  imagemBase = bytesImagem;

                  atualizarTela();
                },
                child: Text("Escolher imagem")),
          ],
        ),
      )
    ],
  );
}

List<Widget> gerarCamadas(Function atualizarTela) {
  List<Widget> lista = [];

  for (int index = 0; index < listaElementos.length; index++) {
    Widget tile = ExpansionTile(
      //collapsedBackgroundColor: Colors.deepPurpleAccent,
      key: Key('$index'),
      title: Text(listaElementos[index].texto),
      children: [
        Text("Texto: "),
        TextFormField(
          initialValue: listaElementos[index].texto,
          onChanged: (value) {
            //print(value);

            listaElementos[index].texto = value;

            atualizarTela();
          },
        ),
        Divider(),
        Text("Posicionamento: "),
        TextFormField(
          initialValue: listaElementos[index].posTop.toString(),
          onChanged: (value) {
            //listaElementos[index].texto = value;
            listaElementos[index].posTop = double.tryParse(value)!;

            atualizarTela();

            /*
            //print(value);

            listaElementos[index].texto = value;

            atualizarTela();
            */
          },
        ),
        TextFormField(
          initialValue: listaElementos[index].posLeft.toString(),
          onChanged: (value) {
            listaElementos[index].posLeft = double.tryParse(value)!;

            atualizarTela();

            /*
            //print(value);

            listaElementos[index].texto = value;

            atualizarTela();
            */
          },
        ),
      ],
    );
    /*
    Widget tile = ListTile(
      key: Key('$index'),
      title: Text(listaElementos[index].texto),
    );
    */

    lista.add(tile);
  }

  return lista.reversed.toList();
}

class _Editor2State extends State<Editor2> {
  //List<Widget> testItems = List<Widget>.generate(50, (index) => Text("Hello $index"));

  //List<Widget> testItems = [];

  bool templateEnabled = true;
  bool lingua = false;

/*
  gerarBotaoAdicionarWidgets() {
    testItems.add(
      ListTile(
        key: Key(testItems.length.toString()),
        title: Text('Adicionar Widgets!'),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    atualizarTela() {
      //print("Existem ${pilhaEditor.length} elementos na pilha!");
      setState(() {});
    }

    //camadas = gerarCamadas(atualizarTela);

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    //dropdownWidgets();
    return MaterialApp(
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.purple.shade800),
            useMaterial3: true),
        home: Scaffold(
          body: Stack(
            children: [
              if (listaElementos.isEmpty && imagemBase.isNull)
                Center(
                  child: dialogoAlerta(context, atualizarTela),
                ),
              if (imagemBase.isDefinedAndNotNull)
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Image.memory(
                        imagemBase!,
                        //height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).longestSide,
                        fit: BoxFit.fitWidth,
                      ),
                      if (listaElementos.isDefinedAndNotNull) ...pilhaCamadas()
                    ],
                  ),
                ),
              if (imagemBase.isDefinedAndNotNull) ...[
                Padding(
                    //padding: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 5,
                      child: SingleChildScrollView(
                          child: Card(
                        child: Column(children: [
                          ReorderableListView(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            shrinkWrap: true,
                            header: Text(
                              "Camadas",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontFamily: 'roboto', fontSize: 25),
                            ),
                            children: gerarCamadas(atualizarTela),
                            //children: gerarCamadas(atualizarTela),
                            onReorder: (int oldIndex, int newIndex) {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }

                              ElementoTeste itemTrocado1 =
                                  listaElementos[oldIndex];

                              listaElementos[oldIndex] =
                                  listaElementos[newIndex];
                              listaElementos[newIndex] = itemTrocado1;

                              atualizarTela();

                              /*
                              setState(() {
                                /*
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                */

                                ElementoTeste itemTrocado1 =
                                    listaElementos[oldIndex];

                                listaElementos[oldIndex] =
                                    listaElementos[newIndex];
                                listaElementos[newIndex] = itemTrocado1;
                              });
                              */
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: FilledButton(
                                onPressed: () {
                                  listaElementos
                                      .add(ElementoTeste("NOVO", 350, 350));

                                  atualizarTela();
                                },
                                child: Text("Criar elemento novo!")),
                          )
                        ]),
                      )),
                    ))
              ]
            ],
          ),
        ));
  }
}
