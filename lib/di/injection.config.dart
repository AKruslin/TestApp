// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../common/services/network_service.dart' as _i5;
import '../data/datasource/comment_datasource.dart' as _i6;
import '../data/repository/comment_repository_impl.dart' as _i8;
import '../domain/repository/comment_repository.dart' as _i7;
import '../domain/usecases/get_comments_usecase.dart' as _i9;
import '../flavor_config.dart' as _i3;
import '../presentation/bloc/home_bloc.dart' as _i4;

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
  gh.factory<_i4.HomeBloc>(() => _i4.HomeBloc());
  gh.singleton<_i5.NetworkService>(
      _i5.NetworkServiceImpl(get<_i3.FlavorConfig>()));
  gh.lazySingleton<_i6.CommentDatasource>(() =>
      _i6.CommentDatasourceImpl(networkService: get<_i5.NetworkService>()));
  gh.singleton<_i7.CommentRepository>(_i8.CommentRepositoryImpl(
      commentDatasource: get<_i6.CommentDatasource>()));
  gh.lazySingleton<_i9.GetCommentsUsecase>(
      () => _i9.GetCommentsUsecase(get<_i7.CommentRepository>()));
  return get;
}
