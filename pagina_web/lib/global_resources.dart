//import 'dart:io';

//import 'dart:io';

//import 'package:cookie_jar/cookie_jar.dart';
//import 'dart:convert';

import 'package:dio/dio.dart';
//import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
//import 'package:path_provider/path_provider.dart';

class Resources {
  static final Resources _singleton = Resources._internal();

  //Connection to the API
  static Dio api = configureDio();

  //Logger
  //static Logger logger = Logger('ExampleLogger');
  static Logger logger = Logger(
    level: kDebugMode ? Level.info : Level.nothing,
    printer: PrettyPrinter(),
  );

  //AuthKey
  static String? authKey;

  factory Resources() {
    return _singleton;
  }

  Resources._internal();
}

/*
Future<PersistCookieJar> prepareJar() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  final jar = PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage("$appDocPath/.cookies/"),
  );
  //dio.interceptors.add(CookieManager(jar));
  return jar;
}
*/

Dio configureDio() {
  // Or create `Dio` with a `BaseOptions` instance.
  final options = BaseOptions(
    baseUrl: 'http://localhost:3000/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );

  final Dio dio = Dio(options);

  return dio;
}
