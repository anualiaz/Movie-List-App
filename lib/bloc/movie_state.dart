import 'package:equatable/equatable.dart';
import '../models/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final int currentPage;
  final bool hasMore;

  const MovieLoaded(this.movies, this.currentPage, this.hasMore);
  @override
  List<Object?> get props => [movies, currentPage, hasMore];
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object?> get props => [message];
}
