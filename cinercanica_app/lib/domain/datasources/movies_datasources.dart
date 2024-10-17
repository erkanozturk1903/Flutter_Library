import 'package:cinercanica_app/domain/entities/movie.dart';

abstract class MoviesDatasources {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
