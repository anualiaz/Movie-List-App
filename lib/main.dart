import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/movie_bloc.dart';
import 'repository/movie_repository.dart';
import 'screens/movie_search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MovieRepository repository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Search',
      home: BlocProvider(
        create: (context) => MovieBloc(repository),
        child: MovieSearchScreen(),
      ),
    );
  }
}