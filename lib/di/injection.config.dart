// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/home_bloc.dart' as _i5;
import '../flavor_config.dart' as _i3;
import '../services/network_service.dart' as _i4;

const String _stage = 'stage';
const String _development = 'development';
const String _production = 'production';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.FlavorConfig>(_i3.StageConfig(), registerFor: {_stage});
  gh.singleton<_i3.FlavorConfig>(_i3.DevConfig(), registerFor: {_development});
  gh.singleton<_i3.FlavorConfig>(_i3.ProdConfig(), registerFor: {_production});
  gh.singleton<_i4.NetworkService>(
      _i4.NetworkServiceImpl(get<_i3.FlavorConfig>()));
  gh.factory<_i5.HomeBloc>(() => _i5.HomeBloc(get<_i4.NetworkService>()));
  return get;
}
