import 'package:flutter/material.dart';

class EditorCanvas extends StatefulWidget {
  const EditorCanvas({Key? key, required this.canvasScale}) : super(key: key);

  final double canvasScale;

  @override
  State<EditorCanvas> createState() => _EditorCanvasState();
}

class _EditorCanvasState extends State<EditorCanvas> {
  //double scale = 1;

  double x = 0;
  double y = 0;
  double z = 0;

  TransformationController canvasController = TransformationController();

  @override
  Widget build(BuildContext context) {
    canvasController.value = Matrix4(
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      widget.canvasScale,
    );

    return InteractiveViewer(
        transformationController: canvasController,
        //scaleEnabled: false,
        minScale: 0.01,
        maxScale: 2,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: CircularProgressIndicator(),
        )
        //boundaryMargin: const EdgeInsets.all(20.0),

        /*
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.orange, Colors.red],
            stops: <double>[0.0, 1.0],
          ),
        ),
      ),
      */
        );
    /*
    return Center(
      child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4(
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            widget.canvasScale,
          )
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          //transform: Matrix4.skewY(0.3)..rotateZ(-3.14 / 12.0),
          child:
              //boundaryMargin: const EdgeInsets.all(20.0),
              //minScale: 0.1,
              //maxScale: 1.6,
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  child: LinearProgressIndicator())),
    );
    */
  }
}
