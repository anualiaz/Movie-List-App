import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(movie.overview),
            const SizedBox(height: 8),
            Text("Rating: ${movie.rating}/10"),
          ],
        ),
      ),
    );
  }
}