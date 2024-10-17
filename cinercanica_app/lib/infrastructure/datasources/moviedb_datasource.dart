import 'package:cinercanica_app/config/constants/environment.dart';
import 'package:cinercanica_app/domain/datasources/movies_datasources.dart';
import 'package:cinercanica_app/domain/entities/movie.dart';
import 'package:cinercanica_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinercanica_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'tr-MX'
      }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBEntity(moviedb))
        .toList();

    return movies;
  }
}
