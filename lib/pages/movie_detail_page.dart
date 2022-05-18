import 'package:cultart/models/movie_model.dart';
import 'package:flutter/material.dart';

import '../service/api_service.dart';

// ignore: must_be_immutable
class MoiveDetailPage extends StatefulWidget {
   const MoiveDetailPage({Key? key, required this.index, required this.movieModel}) : super(key: key);

  final int index;
  final List<MovieModel> movieModel;
  @override
  _MoiveDetailPageState createState() => _MoiveDetailPageState();
}

class _MoiveDetailPageState extends State<MoiveDetailPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height/3,
            child: Image.network("https://image.tmdb.org/t/p/original/${widget.movieModel[widget.index].backdropPath}"))
      ],
    );
  }
}
