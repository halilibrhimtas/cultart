import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cast.dart';
import '../models/movie.dart';
import '../service/api_service.dart';




class MovieDetailPage extends ConsumerStatefulWidget {
  const MovieDetailPage(this.index, this.movie, {Key? key}) : super(key: key);
  final List<MovieModel> movie;
  final int index;
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends ConsumerState<MovieDetailPage> {

  List<Cast> castList = [];



  void getCast() async{
    castList = await ApiService().getCastList(widget.movie[widget.index].id!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCast();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.network("https://image.tmdb.org/t/p/original/${widget.movie[widget.index].backdropPath}").image
                )
            ),
          ),
          Text(widget.movie[widget.index].title.toString(),
            style: const TextStyle(
                fontSize: 15
            ),),
          Text(widget.movie[widget.index].overview.toString(),
            style: const TextStyle(
                fontSize: 10
            ),),
          Text(widget.movie[widget.index].releaseDate.toString(),
            style: const TextStyle(
                fontSize: 10
            ),),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: castList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder:(BuildContext context, int index){
                  Cast cast = castList[index];
                  return SizedBox(
                    height: 80,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // ignore: unnecessary_null_comparison
                          cast.profilePath == null ? const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage("assets/indir.jpg"),
                          )
                              :CircleAvatar(
                            radius: 20,
                            backgroundImage: Image.network("https://image.tmdb.org/t/p/w200${cast.profilePath}").image,
                          ),
                          Text(cast.name, style: const TextStyle(
                              fontSize: 10
                          ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 15)),
                          Text(
                            cast.character,
                            style: const TextStyle(
                                fontSize: 10
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),

          ),
        ],
      ),
    );
  }
}