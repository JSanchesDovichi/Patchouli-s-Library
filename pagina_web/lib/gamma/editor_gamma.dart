import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_easy_drag/draggable_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagina_web/gamma/ImageCanvas.dart' as LocalCanvas;
//import 'package:pagina_web/gamma/canvas.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

const double pi = 3.1415926535897932;

double canvasScale = 1;
double minScale = 0.01;
double maxScale = 2.0;
double x = 0;
double y = 0;
double z = 0;
Uint8List? imagemBase;
Image? base;
//Matrix4 canvasMatrix = Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, canvasScale);
//TransformationController canvasController = TransformationController()..value = Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, canvasScale);

class EditorGamma extends StatefulWidget {
  const EditorGamma({super.key});

  @override
  State<EditorGamma> createState() => _EditorGammaState();
}

class _EditorGammaState extends State<EditorGamma> {
  //double scale = 1;

  @override
  Widget build(BuildContext context) {
    Matrix4 canvasMatrix =
        Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, canvasScale)
          //..rotateX(x)
          ..rotateX(x);
    //..rotateY(y)
    //..rotateZ(z);

    LocalCanvas.TransformationController canvasController =
        LocalCanvas.TransformationController()..value = canvasMatrix;

    return MaterialApp(
        //scrollBehavior: MyCustomScrollBehavior(),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      if (canvasScale < maxScale) {
                        canvasScale += 0.5;

                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.add_circle),
                    label: Text("add")),
                Card(child: Text("Current: ")),
                ElevatedButton.icon(
                    onPressed: () {
                      //canvasScale -= 0.5;
                      if (canvasScale > 0.5) {
                        canvasScale -= 0.5;

                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove_circle),
                    label: Text("minus")),
                Slider(
                    thumbColor: Colors.white,
                    max: 2 * pi,
                    min: 0,
                    divisions: 1000000,
                    value: z,
                    onChanged: (newValue) {
                      //scale = newValue;
                      //print(newValue);
                      setState(() {
                        z = newValue;
                      });
                    }),
                Slider(
                    thumbColor: Colors.white,
                    max: maxScale,
                    min: minScale,

                    //divisions: 10,
                    value: canvasScale,
                    onChanged: (newValue) {
                      //scale = newValue;
                      //print(newValue);
                      setState(() {
                        canvasScale = newValue;
                      });
                    })
              ],
            ),
            body: LocalCanvas.InteractiveViewerPatchouli(
                transformationController: canvasController,
                child: Center(
                  child: Image.network(
                    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2F736x%2Fd1%2F40%2Fe1%2Fd140e13cd826909fa1a77a46dd2d215c--dream-big-one-piece-.jpg&f=1&nofb=1&ipt=fa7fbd0a40324af98fb6479db69120d6316f483e5acc42b166659b9968277231&ipo=images',
                    //fit: BoxFit.fill,
                  ),
                ))

            /*
              Transform(
                  child: Image.network(
                    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2F736x%2Fd1%2F40%2Fe1%2Fd140e13cd826909fa1a77a46dd2d215c--dream-big-one-piece-.jpg&f=1&nofb=1&ipt=fa7fbd0a40324af98fb6479db69120d6316f483e5acc42b166659b9968277231&ipo=images',
                    fit: BoxFit.cover,
                  ),
                  transform: canvasMatrix),
                  */
            ));
  }
}
