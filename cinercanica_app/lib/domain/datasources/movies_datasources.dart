import 'package:cinercanica_app/domain/entities/movie.dart';

abstract class MoviesDatasources {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getNowPopuler({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<Movie> getMovieById(String id);
}
