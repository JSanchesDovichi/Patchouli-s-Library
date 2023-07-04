import 'dart:js_interop';

import 'package:flex_color_picker/flex_color_picker.dart';
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

abrirSelecaoImagem(Function atualizarTela) async {
  final ImagePicker picker = ImagePicker();

  XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

  if (imagem.isNull) {
    Resources.logger.e("Erro: a imagem está nula!");
    return;
  }

  Uint8List bytesImagem = await imagem!.readAsBytes();

  imagemBase = bytesImagem;

  atualizarTela();
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
                  abrirSelecaoImagem(atualizarTela);
                },
                /*
                () async 
                {
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
                */
                child: Text("Escolher imagem")),
          ],
        ),
      )
    ],
  );
}

const Color guidePrimary = Color(0xFF6200EE);
const Color guidePrimaryVariant = Color(0xFF3700B3);
const Color guideSecondary = Color(0xFF03DAC6);
const Color guideSecondaryVariant = Color(0xFF018786);
const Color guideError = Color(0xFFB00020);
const Color guideErrorDark = Color(0xFFCF6679);
const Color blueBlues = Color(0xFF174378);

final Map<ColorSwatch<Object>, String> colorsNameMap =
    <ColorSwatch<Object>, String>{
  ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
  ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
  ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
  ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
  ColorTools.createPrimarySwatch(guideError): 'Guide Error',
  ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
  ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
};

enum opcoesCores { COR_FONTE, COR_FUNDO }

Widget abrirColorPicker(opcoesCores opcaoCor, textoTitulo, BuildContext context,
    int index, Function atualizarTela) {
  /*
  Color dialogSelectColor = listaElementos[index].corFonte.isDefinedAndNotNull
      ? listaElementos[index].corFonte!
      : Colors.black;
      */

  Color? dialogSelectColor;

  switch (opcaoCor) {
    case opcoesCores.COR_FONTE:
      {
        dialogSelectColor = listaElementos[index].corFonte.isDefinedAndNotNull
            ? listaElementos[index].corFonte!
            : Colors.black;
      }
      break;

    case opcoesCores.COR_FUNDO:
      {
        dialogSelectColor = listaElementos[index].corFundo.isDefinedAndNotNull
            ? listaElementos[index].corFundo!
            : Colors.black;
      }
      break;
  }

  return ListTile(
    //title: const Text('Click to select a new color from a dialog'),
    title: Text(textoTitulo),
    subtitle: Text(
      '${ColorTools.materialNameAndCode(dialogSelectColor, colorSwatchNameMap: colorsNameMap)} '
      'aka ${ColorTools.nameThatColor(dialogSelectColor)}',
    ),
    trailing: ColorIndicator(
        width: 40,
        height: 40,
        borderRadius: 0,
        color: dialogSelectColor,
        elevation: 1,
        onSelectFocus: false,
        onSelect: () async {
          // Wait for the dialog to return color selection result.
          final Color newColor = await showColorPickerDialog(
            // The dialog needs a context, we pass it in.
            context,
            // We use the dialogSelectColor, as its starting color.
            dialogSelectColor!,
            title: Text('ColorPicker',
                style: Theme.of(context).textTheme.titleLarge),
            width: 40,
            height: 40,
            spacing: 0,
            runSpacing: 0,
            borderRadius: 0,
            wheelDiameter: 165,
            enableOpacity: true,
            showColorCode: true,
            colorCodeHasColor: true,
            pickersEnabled: <ColorPickerType, bool>{
              ColorPickerType.wheel: true,
            },
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              copyButton: true,
              pasteButton: true,
              longPressMenu: true,
            ),
            actionButtons: const ColorPickerActionButtons(
              okButton: true,
              closeButton: true,
              dialogActionButtons: false,
            ),
            constraints: const BoxConstraints(
                minHeight: 480, minWidth: 320, maxWidth: 320),
          );
          // We update the dialogSelectColor, to the returned result
          // color. If the dialog was dismissed it actually returns
          // the color we started with. The extra update for that
          // below does not really matter, but if you want you can
          // check if they are equal and skip the update below.

          //listaElementos[index].corFonte = newColor;
          switch (opcaoCor) {
            case opcoesCores.COR_FONTE:
              {
                listaElementos[index].corFonte = newColor;
              }
              break;

            case opcoesCores.COR_FUNDO:
              {
                listaElementos[index].corFundo = newColor;
              }
              break;
          }

          atualizarTela();
        }),
  );
}

List<Widget> gerarCamadas(Function atualizarTela, BuildContext context) {
  List<Widget> lista = [];

  for (int index = 0; index < listaElementos.length; index++) {
    //Color dialogSelectColor = Colors.black;

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
        Text("Distância do topo: "),
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
        Divider(),
        Text("Distância da esquerda: "),
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
        Divider(),
        Text("Tamanho da fonte: "),
        TextFormField(
          initialValue: listaElementos[index].fontSize.toString(),
          onChanged: (value) {
            listaElementos[index].fontSize = double.tryParse(value)!;

            atualizarTela();
          },
        ),
        Divider(),
        abrirColorPicker(opcoesCores.COR_FONTE, 'Cor da fonte: ', context,
            index, atualizarTela),
        Divider(),
        abrirColorPicker(opcoesCores.COR_FUNDO, 'Cor de fundo: ', context,
            index, atualizarTela)
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
  bool estadoMenuEscondido = true;

  TransformationController _transformationController =
      TransformationController();
  double zoom = 1.0;
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
            //fixTextFieldOutlineLabel: true,
            fontFamily: 'Roboto',
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
                Center(
                    child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  //boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 0.1,
                  maxScale: 5.0,
                  transformationController: _transformationController,
                  onInteractionEnd: (details) {
                    // Details.scale can give values below 0.5 or above 2.0 and resets to 1
                    // Use the Controller Matrix4 to get the correct scale.
                    double correctScaleValue =
                        _transformationController.value.getMaxScaleOnAxis();

                    zoom = correctScaleValue;

                    atualizarTela();
                  },
                  child: Stack(
                    children: [
                      Image.memory(imagemBase!,
                          //height: MediaQuery.sizeOf(context).height,
                          //width: MediaQuery.sizeOf(context).longestSide,
                          fit: BoxFit.cover),
                      if (listaElementos.isDefinedAndNotNull) ...pilhaCamadas()
                    ],
                  ),
                )),
              if (imagemBase.isDefinedAndNotNull) ...[
                Padding(
                    //padding: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(children: [
                      estadoMenuEscondido == true
                          ? IconButton(
                              onPressed: () {
                                estadoMenuEscondido = !estadoMenuEscondido;

                                atualizarTela();
                              },
                              icon: Icon(Icons.arrow_circle_left_rounded))
                          : IconButton(
                              onPressed: () {
                                estadoMenuEscondido = !estadoMenuEscondido;

                                atualizarTela();
                              },
                              icon: Icon(Icons.arrow_circle_right_rounded)),
                      estadoMenuEscondido
                          ? SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: SingleChildScrollView(
                                  child: Card(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: FilledButton(
                                            onPressed: () async {
                                              abrirSelecaoImagem(atualizarTela);

                                              listaElementos = [];
                                            },
                                            child:
                                                Text("Escolher outra imagem")),
                                      ),
                                      Text("Zoom atual:\n${zoom}%"),
                                      ReorderableListView(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 2),
                                        shrinkWrap: true,
                                        header: Text(
                                          "Camadas",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'roboto',
                                              fontSize: 25),
                                        ),
                                        children: gerarCamadas(
                                            atualizarTela, context),
                                        //children: gerarCamadas(atualizarTela),
                                        onReorder:
                                            (int oldIndex, int newIndex) {
                                          if (oldIndex < newIndex) {
                                            newIndex -= 1;
                                          }

                                          ElementoTeste itemTrocado1 =
                                              listaElementos[oldIndex];

                                          listaElementos[oldIndex] =
                                              listaElementos[newIndex];
                                          listaElementos[newIndex] =
                                              itemTrocado1;

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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: FilledButton(
                                            onPressed: () {
                                              listaElementos.add(ElementoTeste(
                                                  "NOVO", 350, 350));

                                              atualizarTela();
                                            },
                                            child:
                                                Text("Criar elemento novo!")),
                                      )
                                    ]),
                              )),
                            )
                          : Text("Menu")
                    ]))
              ]
            ],
          ),
        ));
  }
}
