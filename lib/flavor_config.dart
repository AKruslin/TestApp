import 'package:injectable/injectable.dart';

abstract class Env {
  static const development = 'development';
  static const stage = 'stage';
  static const production = 'production';
}

enum Flavor { dev, stage, prod }

abstract class FlavorConfig {
  String getBaseUrl();

  Flavor getFlavor();
}

@Singleton(as: FlavorConfig, env: [Env.stage])
class StageConfig implements FlavorConfig {
  @override
  String getBaseUrl() => 'https://jsonplaceholder.typicode.com'; 
  @override
  Flavor getFlavor() => Flavor.stage;
}

@Singleton(as: FlavorConfig, env: [Env.development])
class DevConfig implements FlavorConfig {
  @override
  String getBaseUrl() => 'https://jsonplaceholder.typicode.com'; 
  @override
  Flavor getFlavor() => Flavor.dev;
}

@Singleton(as: FlavorConfig, env: [Env.production])
class ProdConfig implements FlavorConfig {
  @override
  String getBaseUrl() => 'https://jsonplaceholder.typicode.com'; 
  @override
  Flavor getFlavor() => Flavor.prod;
}

