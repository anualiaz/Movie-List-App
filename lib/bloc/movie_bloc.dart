import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/movie_model.dart';
import 'movie_event.dart';
import 'movie_state.dart';
import '../repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc(this.repository) : super(MovieInitial()) {
    on<FetchPopularMovies>(_onFetchPopularMovies);
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onFetchPopularMovies(
      FetchPopularMovies event,
      Emitter<MovieState> emit,
      ) async {
    final currentState = state;
    List<Movie> existing = [];

    if (currentState is MovieLoaded && event.page > 1) {
      existing = currentState.movies;
    } else {
      emit(MovieLoading());
    }

    try {
      final movies = await repository.getPopularMovies(event.page);
      final allMovies = [...existing, ...movies];
      emit(MovieLoaded(allMovies, event.page, movies.length >= 20));
    } catch (e) {
      emit(MovieError("Failed to load popular movies: ${e.toString()}"));
    }
  }

  Future<void> _onSearchMovies(
      SearchMovies event,
      Emitter<MovieState> emit,
      ) async {
    final currentState = state;
    List<Movie> existing = [];

    if (currentState is MovieLoaded && event.page > 1) {
      existing = currentState.movies;
    } else {
      emit(MovieLoading());
    }

    try {
      final movies = await repository.searchMovies(event.query, event.page);
      final allMovies = [...existing, ...movies];
      emit(MovieLoaded(allMovies, event.page, movies.length >= 20));
    } catch (e) {
      emit(MovieError("Failed to search movies: ${e.toString()}"));
    }
  }
}