import 'package:cinercanica_app/domain/datasources/movies_datasources.dart';
import 'package:cinercanica_app/domain/entities/movie.dart';
import 'package:cinercanica_app/domain/repository/movies_repository.dart';

class MovieRepositoryImp extends MoviesRepository {
  final MoviesDatasources datasources;

  MovieRepositoryImp(this.datasources);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasources.getNowPlaying(page: page);
  }
}
