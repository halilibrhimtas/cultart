import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/cast.dart';
import '../../models/movie.dart';
import '../../service/api_service.dart';

class MovieDetailPage extends ConsumerStatefulWidget {
  const MovieDetailPage(this.index, this.movie, {Key? key}) : super(key: key);
  final List<MovieModel> movie;
  final int index;
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends ConsumerState<MovieDetailPage> {
  List<Cast> castList = [];

  void getCast() async {
    castList = await ApiService().getCastList(widget.movie[widget.index].id!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    getCast();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.network(
                        "https://image.tmdb.org/t/p/original/${widget.movie[widget.index].backdropPath}")
                        .image)
                  )
                ),
              ),
            const Padding(padding: EdgeInsets.only(bottom: 8)),
            Center(
              child: Text(
                  widget.movie[widget.index].title!,
                style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 21, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.orangeAccent, size: 14,),
                    const Padding(padding: EdgeInsets.only(right: 4)),
                    Text((widget.movie[widget.index].voteAverage)!,
                      style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 4)),
                    Text("(${widget.movie[widget.index].voteCount.toString()})",
                      style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                    )],
                ),
                const Padding(padding: EdgeInsets.only(right: 16)),
                Text(
                    widget.movie[widget.index].releaseDate.toString(),
                  style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                ),


              ],
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 8)
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Overview",
                style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),

            // ignore: prefer_const_constructors
            Padding(padding: const EdgeInsets.only(bottom: 8)),
            Text(
              widget.movie[widget.index].overview!,
              style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: const Color(0xFF606670),fontWeight: FontWeight.normal),
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 8)
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: castList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Cast cast = castList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF606670),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 220,
                        width: 80,
                        child: SingleChildScrollView(
                          child : Column(
                            children: [
                              cast.profilePath == null
                                  ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage("assets/indir.jpg"),
                                ),
                              )
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: Image.network(
                                      "https://image.tmdb.org/t/p/w200${cast.profilePath}")
                                      .image,
                                ),
                              ),
                              Text(
                                cast.name,
                                style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,

                              ),
                              const Padding(padding: EdgeInsets.only(bottom: 15)),
                              Text(
                                  "(${cast.character})",
                                style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 12.5, color: Colors.white,fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),



          ],
        ),
      ),
    );
  }
}
