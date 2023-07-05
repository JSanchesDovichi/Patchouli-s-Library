import 'dart:js_interop';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagina_web/editorsingleton.dart';
import 'package:pagina_web/global_resources.dart';
import 'ElementoTraducaoTeste.dart';

Uint8List? imagemBase;
List<Widget> listaElementos = [];

class Editor3 extends StatefulWidget {
  const Editor3({super.key});

  @override
  State<Editor3> createState() => _Editor3State();
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

class _Editor3State extends State<Editor3> with TickerProviderStateMixin {
  double zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    atualizarTela() {
      setState(() {});
    }

    return MaterialApp(
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad
        },
      ),
      theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.blueGrey,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade800),
          useMaterial3: true),
      home: Scaffold(
          body: listaElementos.isEmpty && imagemBase.isNull
              ? Center(child: dialogoAlerta(context, atualizarTela))
              : Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child:
                            /*SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: 

                              */
                            AnimatedScale(
                          scale: zoom,
                          curve: Curves.decelerate,
                          duration: Duration(milliseconds: 200),
                          child: Stack(
                            children: [
                              Image.memory(
                                imagemBase!,
                              ),
                              Text(
                                "HELLO!",
                                style: TextStyle(
                                    fontSize: 150,
                                    backgroundColor: Colors.white),
                              )
                            ],
                          ),
                          //)),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                          child: Column(
                            children: [
                              Text("Zoom"),
                              Slider(
                                value: zoom,
                                min: 0.1,
                                max: 5.0,
                                //divisions: 19,
                                label: zoom.toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    zoom = value;
                                    atualizarTela();
                                  });
                                },
                              ),
                              Divider(),
                              FilledButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.add_box),
                                label: Text("Criar nova camada"),
                              ),
                              SingleChildScrollView()
                            ],
                          )),
                    )
                  ],
                )),
    );
  }
}
