import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CryptoController {
  TextEditingController editText = TextEditingController();
  TextEditingController editPassword = TextEditingController();
  ValueNotifier<String> messageEncrypted = ValueNotifier<String>('');
  ValueNotifier<String> messageDecrypted = ValueNotifier<String>('');

  // by Italo Rodri.

  // -> Criptografar mensagem
  String encryptText(String plainText, String password) {
    // Deriva a chave SHA-256 a partir da senha
    final key = encrypt.Key(
        Uint8List.fromList(sha256.convert(utf8.encode(password)).bytes));

    // IV aleatório de 16 bytes
    final iv = encrypt.IV.fromLength(16);

    // Cria o encrypter AES-256 CBC
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Criptografa o texto
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Retorna IV + ciphertext separados por ':' para descriptografia
    return iv.base64 + ':' + encrypted.base64;
  }

// -> Descriptografar mensagem
  String decryptText(String encryptedWithIv, String password) {
    // Separa IV e ciphertext
    final parts = encryptedWithIv.split(':');
    if (parts.length != 2) {
      throw FormatException("Formato inválido. Deve ser 'IV:ciphertext'");
    }

    final iv = encrypt.IV.fromBase64(parts[0]);
    final encrypted = parts[1];

    // Deriva a chave SHA-256 a partir da senha
    final key = encrypt.Key(
        Uint8List.fromList(sha256.convert(utf8.encode(password)).bytes));

    // Cria o encrypter AES-256 CBC
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Descriptografa
    return encrypter.decrypt64(normalizeBase64(encrypted), iv: iv);
  }

  String normalizeBase64(String base64Str) {
    // Remove espaços e quebras de linha
    String str = base64Str.replaceAll(RegExp(r'\s+'), '');

    // Remove '=' extras
    str = str.replaceAll(RegExp(r'=+$'), '');

    // Adiciona padding correto (múltiplo de 4)
    int mod4 = str.length % 4;
    if (mod4 > 0) {
      str += '=' * (4 - mod4);
    }

    return str;
  }

  sendMessage() {
    if (editText.text.isNotEmpty) {
      final encrypted = encryptText(editText.text, '123456');
      print(encrypted);
      messageEncrypted.value = encrypted;
    }
  }

  decryptMessage() {
    if (editPassword.text.isNotEmpty) {
      final decrypted = decryptText(
          normalizeBase64(messageEncrypted.value), editPassword.text);
      messageDecrypted.value = decrypted;
    }
  }

  /**
   * DESCRIPTOGRAFIA VIA APP ANGULAR
   
   import * as CryptoJS from 'crypto-js';

function decryptText(encryptedBase64: string, password: string): string {
  const key = CryptoJS.SHA256(password).toString().substring(0, 32);
  const bytes = CryptoJS.AES.decrypt(encryptedBase64, CryptoJS.enc.Utf8.parse(key), {
    iv: CryptoJS.enc.Utf8.parse('0000000000000000'), // mesmo IV usado no Flutter
  });
  return bytes.toString(CryptoJS.enc.Utf8);
}
   */
}

final cryptoProvider = Provider<CryptoController>((ref) => CryptoController());
