import 'package:cultart/models/movie.dart';
import 'package:cultart/service/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieStateFuture = FutureProvider<List<MovieModel>>((ref) async {
  return ApiService().getMovie() ;
});

