import 'dart:js_interop';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagina_web/global_resources.dart';
import 'ElementoTraducaoTeste2.dart';

Uint8List? imagemBase;
double? currentWidth;
double? currentHeight;
List<ElementoTeste2> listaElementos = [];
List<Widget> camadas = [];
//List<int> _items = List<int>.generate(0, (int index) => index);

List<Widget> pilhaCamadas() {
  List<Widget> camadas = [];

  for (ElementoTeste2 elemento in listaElementos) {
    camadas.add(elemento.gerar());
  }

  return camadas;
}

class EditorAlpha extends StatefulWidget {
  const EditorAlpha({super.key});

  @override
  State<EditorAlpha> createState() => _EditorAlphaState();
}

abrirSelecaoImagem(Function atualizarTela) async {
  final ImagePicker picker = ImagePicker();

  XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

  if (imagem == null) {
    Resources.logger.e("Erro: a imagem está nula!");
    return;
  }

  Uint8List bytesImagem = await imagem.readAsBytes();

  imagemBase = bytesImagem;

  atualizarTela();
}

Widget dialogoAlerta(BuildContext context, Function atualizarTela) {
  return AlertDialog(
    title: const Text("Boas vindas!", textAlign: TextAlign.center),
    titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    content: const Text(
        "Atenção! Este é um projeto que está em andamento e portanto, pode apresentar instabilidades e erros. O projeto possui código aberto para colaboração, e está disponível em https://github.com/JSanchesDovichi/Patchouli-s-Library\n\nPara iniciar o editor de template, escolha uma imagem do seu computador:",
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
                child: const Text("Voltar")),
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
                child: const Text("Escolher imagem")),
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

enum OpcoesCores { corFonte, corFundo }

Widget abrirColorPicker(OpcoesCores opcaoCor, textoTitulo, BuildContext context,
    int index, Function atualizarTela) {
  /*
  Color dialogSelectColor = listaElementos[index].corFonte.isDefinedAndNotNull
      ? listaElementos[index].corFonte!
      : Colors.black;
      */

  Color? dialogSelectColor;

//TODO: CONSERTAR?
  dialogSelectColor = Colors.black;
/*
  switch (opcaoCor) {
    case OpcoesCores.corFonte:
      {
        dialogSelectColor = listaElementos[index].corFonte.isDefinedAndNotNull
            ? listaElementos[index].corFonte!
            : Colors.black;
      }
      break;

    case OpcoesCores.corFundo:
      {
        dialogSelectColor = listaElementos[index].corFundo.isDefinedAndNotNull
            ? listaElementos[index].corFundo!
            : Colors.black;
      }
      break;
  }
  */

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
            case OpcoesCores.corFonte:
              {
                listaElementos[index].corFonte = newColor;
              }
              break;

            case OpcoesCores.corFundo:
              {
                listaElementos[index].corFundo = newColor;
              }
              break;
          }

          gerarCamadas(atualizarTela, context);

          atualizarTela();
        }),
  );
}

/*
const List<String> fontesDisponiveis = <String>[
  'Roboto',
  'Segoe UI',
  '.SF UI Display'
];
*/

gerarCamadas(Function atualizarTela, BuildContext context) {
  //List<Widget> lista = [];

  camadas.clear();

  //for (ElementoTeste2 elemento in listaElementos) {
  for (int i = 0; i < listaElementos.length; i++) {
    //String dropdownValue = listaElementos[i].fontFamily;

    //Color dialogSelectColor = Colors.black;

    Widget tile = ExpansionTile(
      //collapsedBackgroundColor: Colors.deepPurpleAccent,
      //key: Key('$index'),
      key: Key(listaElementos[i].editorKey.toString()),
      title: Text(listaElementos[i].texto == "''"
          ? i.toString()
          : listaElementos[i].texto),

      children: [
        const Text("Texto: "),
        TextFormField(
          textAlign: TextAlign.center,
          initialValue: listaElementos[i].texto,
          onChanged: (value) {
            //print(value);

            listaElementos[i].texto = value;

            gerarCamadas(atualizarTela, context);

            atualizarTela();
          },
        ),
        const Divider(),
        const Text("Posicionamento: "),
        const Text("Distância do topo: "),
        TextFormField(
          textAlign: TextAlign.center,
          initialValue: listaElementos[i].posTop.toString(),
          onChanged: (value) {
            //listaElementos[index].texto = value;
            listaElementos[i].posTop = double.tryParse(value)!;

            gerarCamadas(atualizarTela, context);

            atualizarTela();

            /*
            //print(value);

            listaElementos[index].texto = value;

            atualizarTela();
            */
          },
        ),
        const Divider(),
        const Text("Distância da esquerda: "),
        TextFormField(
          textAlign: TextAlign.center,
          initialValue: listaElementos[i].posLeft.toString(),
          onChanged: (value) {
            listaElementos[i].posLeft = double.tryParse(value)!;

            gerarCamadas(atualizarTela, context);

            atualizarTela();

            /*
            //print(value);

            listaElementos[index].texto = value;

            atualizarTela();
            */
          },
        ),
        const Divider(),
        const Text("Tamanho da fonte: "),
        TextFormField(
          textAlign: TextAlign.center,
          initialValue: listaElementos[i].fontSize.toString(),
          onChanged: (value) {
            listaElementos[i].fontSize = double.tryParse(value)!;

            gerarCamadas(atualizarTela, context);

            atualizarTela();
          },
        ),
        const Divider(),
        abrirColorPicker(
            OpcoesCores.corFonte, 'Cor da fonte: ', context, i, atualizarTela),
        const Divider(),
        abrirColorPicker(
            OpcoesCores.corFundo, 'Cor de fundo: ', context, i, atualizarTela),
        /*
        Divider(),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.

            dropdownValue = value!;

            atualizarTela();
          },
          items:
              fontesDisponiveis2.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontFamily: value)),
            );
          }).toList(),
        )
        */
      ],
    );
    /*
    Widget tile = ListTile(
      key: Key('$index'),
      title: Text(listaElementos[index].texto),
    );
    */

    //lista.add(tile);
    camadas.add(tile);
  }

  /*
  for (int index = 0; index < listaElementos.length; index++) {
    //Color dialogSelectColor = Colors.black;

    Widget tile = ExpansionTile(
      //collapsedBackgroundColor: Colors.deepPurpleAccent,
      //key: Key('$index'),
      key: Key(listaElementos[index].editorKey.toString()),
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
  */

  //return lista.reversed.toList();
}

class _EditorAlphaState extends State<EditorAlpha> {
  bool estadoMenuEscondido = true;

  final TransformationController _transformationController =
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

    //final ColorScheme colorScheme = Theme.of(context).colorScheme;
    //final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    //final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

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
              //if (listaElementos.isEmpty && imagemBase.isNull)
              //TODO: Consertar

              if (listaElementos.isEmpty && imagemBase == null)
                Center(
                  child: dialogoAlerta(context, atualizarTela),
                ),

              //TODO: Consertar

              if (imagemBase != null)
                //if (imagemBase.isDefinedAndNotNull)
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
                      //TODO: Consertar
                      //if (listaElementos.isDefinedAndNotNull)
                      if (listaElementos.isNotEmpty) ...pilhaCamadas().reversed
                    ],
                  ),
                )),

              //TODO: Consertar
              if (imagemBase != null) ...[
                //if (imagemBase.isDefinedAndNotNull) ...[
                Padding(
                    //padding: EdgeInsets.zero,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(children: [
                      estadoMenuEscondido == true
                          ? IconButton(
                              onPressed: () {
                                estadoMenuEscondido = !estadoMenuEscondido;

                                atualizarTela();
                              },
                              icon: const Icon(Icons.arrow_circle_left_rounded))
                          : IconButton(
                              onPressed: () {
                                estadoMenuEscondido = !estadoMenuEscondido;

                                atualizarTela();
                              },
                              icon:
                                  const Icon(Icons.arrow_circle_right_rounded)),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: FilledButton(
                                            onPressed: () async {
                                              abrirSelecaoImagem(atualizarTela);

                                              listaElementos = [];
                                              camadas = [];
                                            },
                                            child: const Text(
                                                "Escolher outra imagem")),
                                      ),
                                      Text("Zoom atual:\n$zoom%"),
                                      ReorderableListView(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 2),
                                        shrinkWrap: true,
                                        header: const Text(
                                          "Camadas",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'roboto',
                                              fontSize: 25),
                                        ),
                                        children: camadas,
                                        //children: gerarCamadas(atualizarTela),
                                        onReorder:
                                            (int oldIndex, int newIndex) {
                                          setState(() {
                                            if (oldIndex < newIndex) {
                                              newIndex -= 1;
                                            }
                                            final ElementoTeste2 item =
                                                listaElementos
                                                    .removeAt(oldIndex);
                                            listaElementos.insert(
                                                newIndex, item);

                                            gerarCamadas(
                                                atualizarTela, context);
                                          });
                                        },
                                        /*
                                            (int oldIndex, int newIndex) {
                                          if (oldIndex < newIndex) {
                                            newIndex -= 1;
                                          }

                                          ElementoTeste2 itemTrocado1 =
                                              listaElementos[oldIndex];

                                          listaElementos[oldIndex] =
                                              listaElementos[newIndex];
                                          listaElementos[newIndex] =
                                              itemTrocado1;

                                          gerarCamadas(atualizarTela, context);

                                          atualizarTela();
                                          */

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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: FilledButton(
                                            onPressed: () {
                                              listaElementos.add(ElementoTeste2(
                                                  listaElementos.length,
                                                  "''",
                                                  350,
                                                  350));

                                              gerarCamadas(
                                                  atualizarTela, context);

                                              atualizarTela();
                                            },
                                            child: const Text(
                                                "Criar elemento novo!")),
                                      )
                                    ]),
                              )),
                            )
                          : const Text("Menu")
                    ]))
              ]
            ],
          ),
        ));
  }
}
