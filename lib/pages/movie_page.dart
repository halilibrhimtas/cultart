import 'package:cultart/home/login/login_page.dart';
import 'package:cultart/models/movie.dart';
import 'package:cultart/pages/movie_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/api_service.dart';


class MoviePage extends ConsumerStatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  const Text(
            "FİLM",
            style: TextStyle(
              color: Colors.black38,
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),

          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(
            Icons.menu_rounded,
            color: Colors.black38,
          ),
          automaticallyImplyLeading: false,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: IconButton(icon: const Icon(Icons.exit_to_app_rounded), color: Colors.black38, onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage())));
              },),
            )
          ],
        ),
        body: const FilmKart()
    );
  }
}

class FilmKart extends ConsumerWidget {
  const FilmKart({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MovieModel>> movie = ref.watch(movieStateFuture);
    return movie.when(
        loading: () => const Center(child: CircularProgressIndicator(),),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (movie) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: PageView.builder(
              itemCount: movie.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    height: 300,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: Image.network("https://image.tmdb.org/t/p/original/${movie[index].posterPath}").image
                        )
                    ),
                  ),

                  TextButton(
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(index, movie)));
                    },
                    child: Text(
                        (movie[index].title)!.toUpperCase(),
                        style: const TextStyle()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star),
                      Text((movie[index].voteAverage)!)
                    ],
                  )
                ],
              )
          ) ,
        )
    );
  }
}