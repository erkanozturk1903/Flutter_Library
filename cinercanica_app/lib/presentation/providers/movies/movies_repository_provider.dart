import 'package:cinercanica_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinercanica_app/infrastructure/repositories/movie_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImp(MoviedbDatasource());
});
