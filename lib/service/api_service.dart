import 'package:dio/dio.dart';

import '../models/movie_model.dart';

const String baseUrl = "https://api.themoviedb.org/3";
const String apiKey = "api_key=dec8f0480246d17d5de975df2ac4bea5";
Dio dio = Dio();

class ApiService{

  Future<List<MovieModel>> getMovie() async {
  var response = await dio.get("https://api.themoviedb.org/3/movie/now_playing?api_key=dec8f0480246d17d5de975df2ac4bea5");
  var movie = response.data["results"] as List ;
  List<MovieModel> movieList = movie.map((m) => MovieModel.fromJson(m)).toList();
  return movieList;
  }

}