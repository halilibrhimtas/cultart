

class MovieModel {
  final int? id;
  final bool? video;
  final int? voteCount;
  final String? voteAverage;
  final String? title;
  final String? releaseDate;
  final String? originalTitle;
  final String? backdropPath;
  final bool? adult;
  final String? overview;
  final String? posterPath;
  final double? popularity;
  final String? mediaType;


  MovieModel({this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalTitle,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
    this.popularity,
    this.mediaType,
    }
      );

  factory MovieModel.fromJson(Map<String, dynamic> json){
    return MovieModel(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString()
    );
  }
   Map<String, dynamic> toJson() => {
     "id" : id,
     "originalTitle" : originalTitle,
     "backdropPath":backdropPath,
     "overview":overview,
     "popularity":popularity,
     "posterPath":posterPath,
     "releaseDate":releaseDate,
     "title":title,
     "video":video,
     "voteCount":voteCount,
     "voteAverage" : voteAverage,
   };
}

