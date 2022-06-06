import 'package:cultart/home/login/login_page.dart';
import 'package:cultart/models/movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../service/api_service.dart';
import 'movie_detail_page.dart';

class MoviePage extends ConsumerStatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key:_key,
        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF606670)),
                  accountName: Text(
                    FirebaseAuth.instance.currentUser!.displayName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture:
                   CircleAvatar(
                     radius: 50,
                     backgroundImage: Image.network(FirebaseAuth.instance.currentUser!.photoURL!).image,
                  ),
                ),
                 ListTile(
                  leading: IconButton(onPressed: ()async {
                    await FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()
                            )
                        )
                    );
                    },
                      icon: const Icon(Icons.exit_to_app_rounded)),
                  title: const Text("Çıkış"),
                ),
              ],
            )

        ),
        appBar: AppBar(
          centerTitle: true,
          leading:  IconButton(
            icon: const Icon(Icons.menu_rounded),
            color: const Color(0xFF606670),
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
          title: const Text(
            "FİLM",
            style: TextStyle(
              color: Color(0xFF606670),
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,

        ),
        body: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FilmKart()));
  }
}

class FilmKart extends ConsumerWidget {
  const FilmKart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MovieModel>> movie = ref.watch(movieStateFuture);
    return movie.when(
        loading: () => const Center(
              child: CircularProgressIndicator(color: Color(0xFF606670),),
            ),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (movie) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: movie.length,
                    itemBuilder: (context, index) =>
                        Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailPage(index, movie)));
                          },
                          child: Column(
                                children: [
                                  Container(
                                    height: 350,
                                    width: 270,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: Image.network(
                                                    "https://image.tmdb.org/t/p/original/${movie[index].posterPath}")
                                                .image)),
                                  ),
                                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                                  SizedBox(
                                    width: 200,
                                    child: Center(
                                      child: Text((movie[index].title)!.toUpperCase(),
                                        style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 18, color: const Color(0xFF606670),fontWeight: FontWeight.bold),

                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.star, color: Colors.orangeAccent, size: 20,),
                                      Text((movie[index].voteAverage)!,
                                        style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: const Color(0xFF606670),fontWeight: FontWeight.normal),

                                      ),
                                      const Padding(padding: EdgeInsets.only(right: 4)),
                                      Text("(${movie[index].voteCount.toString()})",
                                        style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: const Color(0xFF606670),fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                                  Text(
                                    "Popülerlik: ${movie[index].popularity.toString()}",
                                    style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: const Color(0xFF606670),fontWeight: FontWeight.normal),
                                  ),

                                ],
                              ),
                        ),
                      ),
                    )
              ));
  }
}
