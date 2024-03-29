import 'package:flutter/material.dart';
import 'package:themovieapp/constants/secret.dart';
import 'package:themovieapp/model/movie_model.dart';
import 'package:themovieapp/service/api_service.dart';
import 'package:themovieapp/widgets/movie_card.dart';

class SimilarMovieListBuilder extends StatelessWidget {
  final ApiService movieApi;
  final ApiConstants apiconst;
  final String? type;
  final int? id;
  const SimilarMovieListBuilder({
    super.key,
    required this.movieApi,
    required this.apiconst,
    required this.type,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future:movieApi.getSimilarMovies(similarUrl: '${apiconst.base}/$type/$id${apiconst.similarMovieUrl}${apiconst.apiKey}'),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        return Center(child: Text('Error${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(
          child: Text('Data is not Available',style: TextStyle(color: Colors.white),),
        );
      } else {
        List<MovieModel> similarMovie = snapshot.data!;
        return MovieCardWidget( movies: similarMovie, );
      }
    });
  }
}