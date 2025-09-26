import 'package:ProjetoTeste/app/config/app_theme.dart';
import 'package:ProjetoTeste/app/modules/crypto/crypto.dart';
import 'package:ProjetoTeste/app/modules/home/view/exemplo_consumer.dart';
import 'package:ProjetoTeste/app/modules/home/view/exemplo_separar_logica.dart';
import 'package:ProjetoTeste/app/modules/scanner/view/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Rivepod',
      theme: appThemeData,
      home: const CryptoScreen(),
    );
  }
}
