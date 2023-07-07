//import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pagina_web/global_resources.dart';

void getHttp() async {
  //print("Tentando chamar a api com a conexão nova...");
  //Resources.logger.info('Tentando chamar a api com a conexão nova...');
  Resources.logger.d('Tentando chamar a api com a conexão nova...');

  try {
    //Resources.api .get('people/').then((response) => Resources.logger.d(response.toString()));

    Response resposta = await Resources.api.get('usuarios/');

    Resources.logger.d(resposta.data);
  } on DioError catch (e) {
    Resources.logger.e("$e");
  }
}

void areaProibida() async {
  Options opcoes = Options();
  if (Resources.authKey != null) {
    String token = "Bearer ${Resources.authKey!}";
    opcoes = Options(headers: {'Authorization': token});
  }

  try {
    Response resposta = await Resources.api.get('protected/', options: opcoes);

    Resources.logger.d(resposta.data);
  } on DioError catch (e) {
    Resources.logger.e("$e");
  }
}

void criarUsuario() async {
  try {
    //Resources.api .get('people/').then((response) => Resources.logger.d(response.toString()));
    Options opcoes = Options(contentType: Headers.formUrlEncodedContentType);

    Map<String, dynamic> formData = {
      'email': 'email_teste@gmail.com',
      'senha': '12345'
    };

    Response resposta =
        await Resources.api.post('signup/', data: formData, options: opcoes);

    Resources.logger.d(resposta.data);
  } on DioError catch (e) {
    Resources.logger.e("$e");
  }
}

void tryLogin() async {
  try {
    Options opcoes = Options(contentType: Headers.formUrlEncodedContentType);

    Map<String, dynamic> formData = {
      'email': 'email_teste@gmail.com',
      'senha': '12345'
    };

    Response resposta =
        await Resources.api.post('login/', data: formData, options: opcoes);

    //Resources.logger.i(resposta.data);
    Map<String, dynamic> respostaTok = resposta.data;

    //print(resposta_tok['token']);

    Resources.authKey = respostaTok['token'];

    //print(resposta.data.token);
  } on DioError catch (e) {
    Resources.logger.e("$e");
  }
}

void logout() {
  Resources.authKey = null;
}
