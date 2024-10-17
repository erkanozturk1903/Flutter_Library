import 'package:cinercanica_app/domain/entities/movie.dart';
import 'package:cinercanica_app/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://imgc.allpostersimages.com/img/posters/keep-calm-and-carry-on-motivational-black-art-poster-print_u-L-PXJ5T40.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '') ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://imgc.allpostersimages.com/img/posters/keep-calm-and-carry-on-motivational-black-art-poster-print_u-L-PXJ5T40.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
