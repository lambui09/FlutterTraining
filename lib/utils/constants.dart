import 'package:flutter/material.dart';

enum Flavor { dev, product }

@immutable
class Constants {
  const Constants._({
    required this.endpoint,
    required this.apiKey,
  });

  factory Constants.of() {
    final flavor = Flavor.dev;
    /* final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment('FLAVOR'),
    );*/

    switch (flavor) {
      case Flavor.dev:
        return Constants._dev();
      case Flavor.product:
      default:
        return Constants._product();
    }
  }

  factory Constants._dev() {
    return const Constants._(
      endpoint: 'api.themoviedb.org',
      apiKey: 'c29a024e152bfd1ad3d4d0dc8cb48019',
    );
  }

  factory Constants._product() {
    return const Constants._(
      endpoint: 'api.themoviedb.org',
      apiKey: 'c29a024e152bfd1ad3d4d0dc8cb48019',
    );
  }

  static late final Constants instance = Constants.of();

  final String endpoint;
  final String apiKey;
}
