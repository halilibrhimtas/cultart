
import 'package:cultart/models/movie_model.dart';
import 'package:cultart/service/api_service.dart';
import 'package:flutter/material.dart';

import 'movie_detail_page.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<MovieModel> movieModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async{
    movieModel = (await ApiService().getMovie());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
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
            child: const Icon(Icons.search_outlined, color: Colors.black38,),
          )
        ],
      ),
    body: movieModel.isEmpty
        ? const Center(child: CircularProgressIndicator(),)
        : FilmKart(movieModel: movieModel)
    );
  }
}


// ignore: must_be_immutable
class FilmKart extends StatefulWidget {
   const FilmKart({
    Key? key,
    required this.movieModel,
  }) : super(key: key);

  final List<MovieModel> movieModel;


  @override
  State<FilmKart> createState() => _FilmKartState();
}

class _FilmKartState extends State<FilmKart> {
  PageController controller = PageController();

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: PageView.builder(
        itemCount: widget.movieModel.length,
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 250,
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fill,
                  image: Image.network("https://image.tmdb.org/t/p/original/${widget.movieModel[index].posterPath}",).image
              )
              ),
            ),
            Text((widget.movieModel[index].title)!),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Icon(Icons.star),
                 TextButton(
                     onPressed:(){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => MoiveDetailPage(index: index, movieModel: widget.movieModel,)));
                       },
                     child: Text((widget.movieModel[index].voteAverage)!))
               ],
             )
          ],
        ),
      ),
    );
  }
}
