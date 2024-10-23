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

  @override
  Future<List<Movie>> getNowPopuler({int page = 1}) {
    return datasources.getNowPopuler(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasources.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasources.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasources.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasources.searchMovies(query);
  }
}
