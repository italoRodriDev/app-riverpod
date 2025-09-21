import 'package:ProjetoTeste/app/data/model/joke.model.dart';
import 'package:ProjetoTeste/app/data/provider/api.provider.dart';
import 'package:ProjetoTeste/app/data/provider/status_code.provider.dart';
import 'package:dio/dio.dart';

class JokeRepository {
  ApiProvider api =
      ApiProvider(baseUrl: 'https://official-joke-api.appspot.com');

  Future<JokeModel?> getJoke() async {
    try {
      final res = await api.get('/random_joke');

      JokeModel model = JokeModel();

      StatusCodeProvider.handle(res, (success) {
        model = JokeModel.fromJson(res.data);
      }, (error) {
        print('Erro: ${error.toString()}');
      });

      return model;
    } on DioException catch (e) {
      print('Erro: ${e.message}');
      return null;
    }
  }
}
