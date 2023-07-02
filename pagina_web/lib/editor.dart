/*
import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';

//import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagina_web/global_resources.dart';
import 'ElementoTraducaoTeste.dart';

//Widget? imagemBase;
Uint8List? imagemBase;
//List<Widget> pilhaEditor = [];
List<ElementoTeste> listaElementos = [];
//List<DropdownMenuItem<String>> menuItems = [];
/*
Widget dropdownmenu = Material(
  child: DropdownMenu(
    dropdownMenuEntries: menuItems,
  ),
);
*/
//String? widgetSelecionado;
//ElementoTeste WidgetTeste = ElementoTeste("Hello World!");

List<Widget> gerarCardsElementos(Function atualizarTela) {
  List<Widget> listaWidgets = [Text('test1'), Text('test2')];

  return [
    ReorderableListView(
        children: <Widget>[
          for (int index = 0; index < listaWidgets.length; index += 1)
            ListTile(
              key: Key('$index'),
              //tileColor: listaWidgets[index].isOdd ? oddItemColor : evenItemColor,
              title: Text('Item ${listaWidgets[index]}'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          atualizarTela(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final Widget item = listaWidgets.removeAt(oldIndex);
            listaWidgets.insert(newIndex, item);
          });
        }),
    FilledButton(onPressed: null, child: Text("Criar elementos novo!"))
  ];
}

/*
List<Widget> gerarCardsElementos() {
  List<Widget> lista = [];

  for (ElementoTeste elemento in listaElementos) {
    lista.add(Material(
        child: Card(
            child: Column(
      children: [
        Text(elemento.texto),
        FilledButton(
            onPressed: () {
              print("APERTOU O BOTÃO!");
            },
            child: Text("FAZER ALGUMA COISA!"))
      ],
    ))));
  }

  return lista;
}
*/

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

                  /*
                  Image daMemoria = Image.memory(
                    bytesImagem,
                    fit: BoxFit.contain,
                  );
                  */

                  imagemBase = bytesImagem;

                  //pilhaEditor.add(Image.memory(bytesImagem));

                  atualizarTela();
                },
                child: Text("Escolher imagem")),
          ],
        ),
      )
    ],
  );
}

/*
void dropdownWidgets() {
  List<DropdownMenuItem<String>> menuItemsNew = [];
  //List<DropdownMenuItem<String>> menuItems = [];

  /*
  for (ElementoTeste elemento in listaElementos) {
    DropdownMenuItem<String> item =
        DropdownMenuItem(child: Text(elemento.texto));
        */

  for (int i = 0; i < listaElementos.length; i++) {
    DropdownMenuItem<String> item = DropdownMenuItem(child: Text(i.toString()));

    menuItemsNew.add(item);
  }

  menuItems = menuItemsNew;

  //return menuItems;
}
*/

List<Widget> gerarPilhaEditor() {
  List<Widget> lista = [];

  for (ElementoTeste elemento in listaElementos) {
    lista.add(elemento.gerar());
  }

  return lista;
}

/*
Widget lerWidgetsCriados() {
  return Material(
    child: DropdownButton(
      onChanged: (indice_selecionado) {
        widgetSelecionado = indice_selecionado;
      },
      items: menuItems,
    ),
  );
}

int getIndice(String textoElemento) {
  for (int i = 0; i < listaElementos.length; i++) {
    if (textoElemento == listaElementos[i].texto) {
      print("Achei o índice #{i}!");
      return i;
    }
  }

  return -1;
}
*/

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final _formKey = GlobalKey<FormState>();

  final controladorPosTop = TextEditingController();
  final controladorPosLeft = TextEditingController();
  final controladorTexto = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    controladorPosTop.dispose();
    controladorPosLeft.dispose();
    controladorTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //dropdownWidgets();

    atualizarTela() {
      //print("Existem ${pilhaEditor.length} elementos na pilha!");
      setState(() {});
    }

    return MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade800),
          useMaterial3: true,
        ),
        home: Center(
            child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (listaElementos.isEmpty && imagemBase.isNull)
                dialogoAlerta(context, atualizarTela),
              if (imagemBase.isDefinedAndNotNull)
                Column(
                  children: [
                    /*
                    Material(
                      child: DropdownButton(
                        onChanged: (indice_selecionado) {
                          widgetSelecionado = indice_selecionado;
                        },
                        items: menuItems,
                      ),
                    ),
                    */
                    FilledButton(
                        onPressed: atualizarTela,
                        child: Text("Atualizar tela")),
                    FilledButton(
                        onPressed: () {
                          double? posTop =
                              double.tryParse(controladorPosTop.text);
                          double? posLeft =
                              double.tryParse(controladorPosLeft.text);

                          if (posLeft.isUndefinedOrNull ||
                              posTop.isUndefinedOrNull) {
                            return;
                          }

                          ElementoTeste novo = ElementoTeste(
                              controladorTexto.text, posTop!, posLeft!);

                          listaElementos.add(novo);

                          /*
                          menuItems
                              .add(DropdownMenuItem(child: Text(novo.texto)));
                              */

                          atualizarTela();
                        },
                        child: Text("Adicionar texto teste")),
                    /*
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          
                          Material(
                            child:
                                Text("Alterar propriedades do Widget teste: "),
                          ),
                          Material(
                            child: TextFormField(
                              /*
                              validator: (value) {
                                if (double.tryParse(value!) == null) {
                                  return 'Campo obrigatório!';
                                }

                                return null;
                              },
                              */
                              onChanged: (top_left) {
                                //WidgetTeste.texto = field_text;

                                /*
                                WidgetTeste.pos_left = double.parse(top_left);

                                listaElementos[0] = WidgetTeste;
                                */

                                //int indiceRecuperado = getIndice(widgetSelecionado!);

                                /*
                                if (indiceRecuperado != -1) {
                                  listaElementos[indiceRecuperado] =
                                      WidgetTeste;
                                }
                                */

                                atualizarTela();
                              },
                              controller: controladorPosLeft,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.text_fields),
                                  border: OutlineInputBorder(),
                                  hintText: "Left do widget"),
                            ),
                          ),
                          Material(
                            child: TextFormField(
                              onChanged: (top_pos) {
                                //WidgetTeste.texto = field_text;

                                /*
                                WidgetTeste.pos_top = double.parse(top_pos);

                                listaElementos[0] = WidgetTeste;
                                */

                                /*
                                int indiceRecuperado =
                                    getIndice(widgetSelecionado!);

                                if (indiceRecuperado != -1) {
                                  listaElementos[indiceRecuperado] =
                                      WidgetTeste;
                                }
                                */

                                atualizarTela();
                              },
                              controller: controladorPosTop,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.text_fields),
                                  border: OutlineInputBorder(),
                                  hintText: "Top do widget"),
                            ),
                          ),
                          Material(
                            child: TextFormField(
                              onChanged: (field_text) {
                                //WidgetTeste.texto = field_text;

                                /*
                                WidgetTeste.texto = field_text;

                                listaElementos[0] = WidgetTeste;

                                //int indiceRecuperado =
                                getIndice(widgetSelecionado!);
                                */

                                //print("Indice recuperado: ${indiceRecuperado}");

                                //listaElementos[indiceRecuperado].texto = field_text;

                                /*
                                if (indiceRecuperado != -1) {
                                  listaElementos[indiceRecuperado] =
                                      WidgetTeste;
                                }
                                */

                                atualizarTela();
                              },
                              controller: controladorTexto,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.text_fields),
                                  border: OutlineInputBorder(),
                                  hintText: "Texto do widget"),
                            ),
                          )
                        ],
                      ),
                    ),
                    */
                    Divider(),
                    /*
                    ListView(
                      children: [...gerarCardsElementos()],
                    ),
                    */
                    //dropdownmenu,
                    //lerWidgetsCriados(),
                    /*
                    Material(
                      child: DropdownButton(
                        onChanged: (indice_selecionado) {
                          widgetSelecionado = indice_selecionado;
                        },
                        items: menuItems,
                      ),
                    ),
                    */
                    Row(
                      children: [
                        //Text("Hello world!"),
                        /*
                        ListView(
                          shrinkWrap: true,
                          children: gerarCardsElementos(),
                        ),
                        */

                        Stack(
                          children: [
                            Image.memory(
                              imagemBase!,
                              fit: BoxFit.cover,
                            ),
                            //...pilhaEditor,
                            ...gerarPilhaEditor()
                          ],
                        ),
                        VerticalDivider(),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: gerarCardsElementos(atualizarTela),
                                ),
                              )
                            ])
                        //...gerarCardsElementos()
                        //Text("Hello world!")
                      ],
                    ),
                  ],
                )
            ],
          ),
        )));
  }
}
*/
