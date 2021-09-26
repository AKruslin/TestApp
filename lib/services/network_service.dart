import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app/flavor_config.dart';
import 'package:test_app/services/rest_client.dart';

abstract class NetworkService {
  RestClient getRestClient();
  //if we need other types of clients we can simply add them here (graphQLCLient...)
}

@Singleton(as: NetworkService)
class NetworkServiceImpl implements NetworkService {
  final FlavorConfig _flavorConfig;
  late RestClient _restClient;
  late Dio _restDio;

  NetworkServiceImpl(this._flavorConfig){
    initRestClient();
  }

  initRestClient() {
    _restDio = Dio(
      BaseOptions(
        baseUrl: _flavorConfig.getBaseUrl(),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _restClient = RestClient(_restDio);
  }

  @override
  RestClient getRestClient() => _restClient;
}
