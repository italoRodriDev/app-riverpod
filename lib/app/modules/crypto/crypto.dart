import 'package:ProjetoTeste/app/config/colors/colors.dart';
import 'package:ProjetoTeste/app/modules/crypto/controller/cripto.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/input-text.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CryptoScreen extends ConsumerStatefulWidget {
  const CryptoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends ConsumerState<CryptoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final prov = ref.watch(cryptoProvider);
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
              title: TextComponent(
            value: 'Chat com criptografia - by Italo. Rodry',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )),
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsetsGeometry.all(30),
            child: Column(
              children: [
                TextComponent(
                    value:
                        'Sua mensagem é criptografada de ponta a ponta, tornando totalmente confidencial',
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),
                InputTextComponent(
                  textEditingController: prov.editText,
                  maxLines: 5,
                  hintText: 'Digite sua mensagem',
                  labelText: 'Mensagem',
                ),
                const SizedBox(height: 10),
                ButtonComponent(
                    padding: const EdgeInsetsGeometry.all(10),
                    color: Colors.pink,
                    label: 'Enviar mensagem',
                    onPressed: () {
                      prov.sendMessage();
                    }),
                ValueListenableBuilder(
                    valueListenable: prov.messageEncrypted,
                    builder: (context, value, child) {
                      if (value.isEmpty) {
                        return Container();
                      } else {
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            TextComponent(
                                textAlign: TextAlign.center,
                                value: 'Sua mensagem foi criptografada',
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.lightGreen),
                            TextComponent(value: '$value'),
                          ],
                        );
                      }
                    }),
                Divider(color: AppColor.medium),
                ValueListenableBuilder(
                    valueListenable: prov.messageEncrypted,
                    builder: (context, value, child) {
                      if (value.isEmpty) {
                        return Container();
                      } else {
                        return Column(
                          children: [
                            TextComponent(
                                value:
                                    'Você recebeu uma mensagem digite a senha para descriptografar',
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            InputTextComponent(
                                textEditingController: prov.editPassword,
                                maxLines: 5,
                                hintText: 'Digite sua senha',
                                labelText: 'Senha'),
                            const SizedBox(height: 10),
                            ButtonComponent(
                                padding: const EdgeInsetsGeometry.all(10),
                                color: Colors.pink,
                                label: 'Descriptografar',
                                onPressed: () {
                                  prov.decryptMessage();
                                }),
                            SizedBox(height: 10),
                            ValueListenableBuilder(
                                valueListenable: prov.messageDecrypted,
                                builder: (context, value, child) {
                                  return TextComponent(value: value);
                                })
                          ],
                        );
                      }
                    })
              ],
            ),
          )),
        ));
      },
    );
  }
}
