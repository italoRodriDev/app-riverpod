import 'package:dio/dio.dart';

class StatusCodeProvider {
  static void handle(
    Response res,
    Function(String message) success,
    Function(String message) error,
  ) {
    try {
      String message = 'Aguardando resposta...';

      switch (res.statusCode) {
        case 200:
          success(message);
          break;

        case 202:
        case 206:
          final msg = _extractMessage(res);
          success(msg ?? message);
          break;

        case 400:
          error('Ops! Seus dados estão incorretos.');
          break;

        case 401:
          error('Sua conta foi deslogada!');
          break;

        case 403:
          error(_extractMessage(res) ?? 'Acesso negado (403).');
          break;

        case 500:
          error('O servidor encontrou uma situação com a qual não sabe lidar.');
          break;

        case 503:
          error('Servidor em manutenção ou sobrecarregado. Status: 503');
          break;

        default:
          if (res.statusCode != null) {
            error('Algo saiu errado! Erro: ${res.statusCode}');
          } else {
            error('Erro inesperado!');
          }
      }
    } catch (e) {
      error('Erro inesperado: $e');
    }
  }

  static String? _extractMessage(Response res) {
    if (res.data is Map && res.data['message'] != null) {
      return res.data['message'].toString();
    }
    return null;
  }
}
