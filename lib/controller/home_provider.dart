import 'package:flutter/material.dart';
import 'package:themovieapp/constants/secret.dart';
import 'package:themovieapp/model/movie_model.dart';
import 'package:themovieapp/service/api_service.dart';

class HomeProvider extends ChangeNotifier{
  final ApiService movieApiService = ApiService();
    List<MovieModel>? movies = [];
    Future<void> getMoviestoHome() async {
    try {
      List<MovieModel> movieResults = await movieApiService.getMovies(apiUrl: "${ApiConstants().trending}${ApiConstants().apiKey}");
        movies = movieResults;
    } catch (error) {
      throw Exception(error);
    }
    notifyListeners();
  }
}