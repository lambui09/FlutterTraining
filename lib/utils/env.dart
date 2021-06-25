import 'package:flutter/material.dart';

enum Flavor { dev, product }

@immutable
class Environment {
  const Environment._({
    required this.endpoint,
    required this.apiKey,
  });

  factory Environment.of() {
    final flavor = Flavor.dev;
    /* final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment('FLAVOR'),
    );*/

    switch (flavor) {
      case Flavor.dev:
        return Environment._dev();
      case Flavor.product:
      default:
        return Environment._product();
    }
  }

  factory Environment._dev() {
    return const Environment._(
      endpoint: 'api.themoviedb.org',
      apiKey: 'c29a024e152bfd1ad3d4d0dc8cb48019',
    );
  }

  factory Environment._product() {
    return const Environment._(
      endpoint: 'api.themoviedb.org',
      apiKey: 'c29a024e152bfd1ad3d4d0dc8cb48019',
    );
  }

  static late final Environment instance = Environment.of();

  final String endpoint;
  final String apiKey;
}
