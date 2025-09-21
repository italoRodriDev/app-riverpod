import 'package:ProjetoTeste/app/config/colors/colors.dart';
import 'package:ProjetoTeste/app/modules/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExemploConsumer extends StatefulWidget {
  const ExemploConsumer({super.key});

  @override
  State<ExemploConsumer> createState() => _ExemploConsumerState();
}

class _ExemploConsumerState extends State<ExemploConsumer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(child: Consumer(builder: (context, ref, child) {
        final randomJoke = ref.watch(randomJokeProvider);
        return Stack(
          alignment: Alignment.center,
          children: [
            switch (randomJoke) {
              AsyncValue(:final value?) => TextComponent(
                  value: value.setup.toString(), color: AppColor.primary),
              AsyncValue(error: != null) => TextComponent(
                  value: 'Algo saiu errado', color: AppColor.primary),
              AsyncValue() => const CircularProgressIndicator()
            },
            if (randomJoke.isRefreshing)
              const Positioned(
                  bottom: 30,
                  right: 0,
                  left: 0,
                  child: LinearProgressIndicator()),
            if (!randomJoke.isRefreshing)
              Positioned(
                  bottom: 30,
                  child: ButtonComponent(
                      onPressed: () {
                        ref.invalidate(randomJokeProvider);
                        ref.invalidate(isLoadingProvider);
                      },
                      label: 'Gerar Nova Piada'))
          ],
        );
      })),
    );
  }
}
