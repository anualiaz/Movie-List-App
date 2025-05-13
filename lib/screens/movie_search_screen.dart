import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../screens/movie_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String currentQuery = '';
  bool isSearching = false;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchPopularMovies());
    _scrollController.addListener(_onScroll);
  }

  void _search(String query) {
    currentQuery = query.trim();
    if (currentQuery.isNotEmpty) {
      isSearching = true;
      context.read<MovieBloc>().add(SearchMovies(currentQuery, page: 1));
    } else {
      isSearching = false;
      context.read<MovieBloc>().add(FetchPopularMovies(page: 1));
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore) {
      isLoadingMore = true;
      final state = context.read<MovieBloc>().state;
      if (state is MovieLoaded && state.hasMore) {
        Future.delayed(const Duration(milliseconds: 500), () {
          print("Current Page: ${state.currentPage}");
          final nextPage = state.currentPage + 1;
          final event = isSearching
              ? SearchMovies(currentQuery, page: nextPage)
              : FetchPopularMovies(page: nextPage);
          context.read<MovieBloc>().add(event);
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: "Search Movies...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _search(_controller.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading && state is! MovieLoaded) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  isLoadingMore = false; // Reset the loading flag
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasMore ? state.movies.length + 1 : state.movies.length,
                    itemBuilder: (context, index) {
                      if (index < state.movies.length) {
                        final movie = state.movies[index];
                        return ListTile(
                          leading: movie.posterPath.isNotEmpty
                              ? Image.network(
                            "https://image.tmdb.org/t/p/w92${movie.posterPath}",
                            width: 50,
                          )
                              : const SizedBox(width: 50),
                          title: Text(movie.title),
                          subtitle: Text("Release: ${movie.releaseDate}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailsScreen(movie: movie),
                              ),
                            );
                          },
                        );
                      } else {
                        // 👇 Show loading indicator at the bottom
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  );
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text("Loading movies..."));
                }
              },
            )
          ),
        ],
      ),
    );
  }
}