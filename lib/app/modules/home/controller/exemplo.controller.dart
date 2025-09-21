import 'package:ProjetoTeste/app/data/repository/auth.repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExemploController {
  AuthRepository authRepo = AuthRepository();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      isLoading.value = true;
      bool res =
          await authRepo.login(email: email.text, password: password.text);

      if (res) {
        // login bem-sucedido
        Future.delayed(Duration(milliseconds: 400)).then((t) {
          isLoading.value = false;
        });
      } else {
        // login falhou
        isLoading.value = false;
      }
    }
  }
}

final exemploCtrlProvider =
    Provider<ExemploController>((ref) => ExemploController());
