import 'package:ProjetoTeste/app/modules/home/controller/exemplo.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/input-text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExemploSepararLogica extends ConsumerWidget {
  const ExemploSepararLogica({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.watch(exemploCtrlProvider);

    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputTextComponent(
                      textEditingController: ctrl.email,
                      labelText: 'E-mail',
                      hintText: 'Informe seu e-mail',
                    ),
                    const SizedBox(height: 10),
                    InputTextComponent(
                      textEditingController: ctrl.password,
                      labelText: 'Senha',
                      hintText: 'Informe sua senha',
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                        valueListenable: ctrl.isLoading,
                        builder: (context, isLoading, _) {
                          return !isLoading
                              ? ButtonComponent(
                                  onPressed: () {
                                    ctrl.login();
                                  },
                                  label: 'Entrar')
                              : const CircularProgressIndicator();
                        })
                  ],
                ))),
      );
    });
  }
}
