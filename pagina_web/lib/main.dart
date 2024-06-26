import 'package:flutter/material.dart';
import 'package:pagina_web/gamma/editor_gamma.dart';
import 'package:pagina_web/placeholder_content_local.dart';
//import 'package:pagina_web/editor.dart';
//import 'package:pagina_web/editor2.dart';
//import 'package:pagina_web/editor3.dart';
//import 'package:pagina_web/placeholder_content_local.dart';
import 'package:pagina_web/test_requests.dart';
import 'package:go_router/go_router.dart';

import 'editor_alpha.dart';

void main() {
  //runApp(const MyApp());

  // GoRouter configuration
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => FilledButton(
            onPressed: () => context.go('/DebugToolbox'),
            child: Text("Acessar toolbox de testes!")),
      ),
      GoRoute(
        path: '/DebugToolbox',
        builder: (context, state) => MyApp(),
      ),
      GoRoute(
        path: '/placeholder_content_local',
        builder: (context, state) => PlaceholderContentPageLocal(),
      ),
      GoRoute(
        path: '/editor',
        builder: (context, state) => const EditorAlpha(),
      ),
      GoRoute(
        path: '/editor_gamma',
        builder: (context, state) => const EditorGamma(),
      ),
    ],
  );

  runApp(MaterialApp.router(
    routerConfig: router,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Patchouli's Library Debug Toolbox",
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
      home: const MyHomePage(
          title: Text(
        "Patchouli's Library Debug Toolbox",
        textAlign: TextAlign.center,
      )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Widget title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Debug:"),
            const Divider(),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FilledButton(
                onPressed: () {
                  getHttp();
                },
                child: const Text("Tentar chamar a API")),
            const Text("Autenticação:"),
            const Divider(),
            FilledButton(
                onPressed: () {
                  areaProibida();
                },
                child: const Text("Tentar acessar página proibida")),
            FilledButton(
                onPressed: () {
                  criarUsuario();
                },
                child: const Text("Criar usuário teste")),
            FilledButton(
                onPressed: () {
                  tryLogin();
                },
                child: const Text("Executar Login")),
            FilledButton(
                onPressed: () {
                  logout();
                },
                child: const Text("Logout")),
            const Divider(),
            FilledButton(
                onPressed: () {
                  //logout();
                  context.go('/placeholder_content_local');
                },
                child: const Text("Acessar conteúdo placeholder")),
            /*
            FilledButton(
                onPressed: () {
                  //logout();
                  context.go('/debug_editor2');
                },
                child: Text("Acessar editor (debug2)")),
            FilledButton(
                onPressed: () {
                  //logout();
                  context.go('/debug_editor3');
                },
                child: Text("Acessar editor (debug3)")),
                */
            FilledButton(
                onPressed: () {
                  //logout();
                  context.go('/editor');
                },
                child: const Text("Acessar editor (alpha debug)")),
            FilledButton(
                onPressed: () {
                  //logout();
                  context.go('/editor_gamma');
                },
                child: const Text("Acessar editor (gamma)")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
