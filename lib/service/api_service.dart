import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cast.dart';
import '../models/movie.dart';

const String baseUrl = "https://api.themoviedb.org/3";
const String apiKey = "api_key=dec8f0480246d17d5de975df2ac4bea5";
Dio dio = Dio();
class ApiService{

  Future<List<MovieModel>> getMovie() async {
    var response = await dio.get("https://api.themoviedb.org/3/movie/now_playing?$apiKey");
    var movie = response.data["results"] as List ;
    List<MovieModel> movieList = movie.map((m) => MovieModel.fromJson(m)).toList();
    return movieList;
  }

  Future<List<Cast>> getCastList(int? movieId) async {
    try {
      final response = await dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
          name: c['name'],
          profilePath: c['profile_path'],
          character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
final movieStateFuture = FutureProvider<List<MovieModel>>((ref) async {
  return ApiService().getMovie() ;
});
