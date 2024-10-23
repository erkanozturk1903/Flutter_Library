import 'package:cinercanica_app/domain/entities/movie.dart';
import 'package:cinercanica_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>(
  (ref) => '',
);

final searchedMoviesProvider =
    StateNotifierProvider<SearchMoviesProvider, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchMoviesProvider(
    searchMovies: movieRepository.searchMovies,
    ref: ref,
  );
});

typedef SearcMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesProvider extends StateNotifier<List<Movie>> {
  final SearcMoviesCallback searchMovies;
  final Ref ref;

  SearchMoviesProvider({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
