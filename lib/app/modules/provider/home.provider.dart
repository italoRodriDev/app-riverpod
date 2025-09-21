import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/joke.repository.dart';

JokeRepository repo = JokeRepository();

final isLoadingProvider = FutureProvider((ref) async {
  bool isLoading = true;
  await Future.delayed(const Duration(seconds: 3)).then((t) {
    isLoading = false;
  });
  return isLoading;
});

// -> Provider piada
final randomJokeProvider = FutureProvider((ref) async {
  return repo.getJoke();
});
