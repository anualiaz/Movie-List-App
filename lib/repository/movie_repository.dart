import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieRepository {
  final String apiKey = '8d3092d45613244108cae0458a54e7d6'; // Replace with your actual API key

  // Search movies by query
  Future<List<Movie>> searchMovies(String query, int page) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}&page=$page',
      ));

    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'];
      return (results as List).map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load searched movies');
    }
  }

  //  Fetch popular movies by default
  Future<List<Movie>> getPopularMovies(int page) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&page=$page',
        ),
      );

      if (response.statusCode == 200) {
        final results = json.decode(response.body)['results'];
        return (results as List).map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    }catch (e){
      print('Error: $e');  // Logs "Connection reset by peer" here
      throw Exception("Failed to fetch: $e");
    }
  }
}