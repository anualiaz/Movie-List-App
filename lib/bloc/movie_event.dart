import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchPopularMovies extends MovieEvent {
  final int page;
  const FetchPopularMovies({this.page = 1});
  @override
  List<Object> get props => [page];
}

class SearchMovies extends MovieEvent {
  final String query;
  final int page;
  const SearchMovies(this.query, {this.page = 1});
  @override
  List<Object> get props => [query, page];
}