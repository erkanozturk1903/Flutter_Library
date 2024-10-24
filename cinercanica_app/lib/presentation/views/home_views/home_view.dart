

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movies/initial_loading_provider.dart';
import '../../providers/movies/movies_providers.dart';
import '../../providers/movies/movies_slideshow_provider.dart';
import '../../widgets/movies/movie_horizontal_listview.dart';
import '../../widgets/movies/movies_slideshow.dart';
import '../../widgets/shared/custom_appbar.dart';
import '../../widgets/shared/full_screen_loader.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final populerMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);


    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                //const CustomAppbar(),
                MoviesSlideshow(
                  movies: slideShowMovies,
                ),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Vizyondakiler',
                  subTitle: 'Pazartesi 20',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Çok Yakında',
                  subTitle: 'Bu ay',
                  loadNextPage: () {
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: populerMovies,
                  title: 'Popüler',
                  //subTitle: 'Bu ay',
                  loadNextPage: () {
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'En Çok Puan',
                  subTitle: 'Tüm Zamanlar',
                  loadNextPage: () {
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          },
          childCount: 1,
        ),
      ),
    ]);
  }
}
