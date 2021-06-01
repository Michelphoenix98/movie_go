class Movie {
  final bool isAdult;
  final String backdrop_path;
  final List<dynamic> genre_ids;
  final int id;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final String poster_path;
  final String release_date;
  final String title;
  final bool video;
  final double vote_average;
  final int vote_count;
  Movie(
      {this.isAdult,
      this.backdrop_path,
      this.genre_ids,
      this.id,
      this.original_language,
      this.original_title,
      this.overview,
      this.popularity,
      this.poster_path,
      this.release_date,
      this.title,
      this.video,
      this.vote_average,
      this.vote_count});
  factory Movie.fromJson(Map data) {
    return Movie(
      isAdult: data["isAdult"],
      backdrop_path: data["backdrop_path"],
      genre_ids: data["genre_ids"],
      id: data["id"],
      original_language: data["original_language"],
      original_title: data["original_title"],
      overview: data["overview"],
      popularity: data["popularity"],
      poster_path: data["poster_path"],
      release_date: data["release_date"],
      title: data["title"],
      video: data["video"],
      vote_average: data["vote_average"],
      vote_count: data["vote_count"],
    );
  }
}

class Cast {
  final int id;
  final String name;
  final String profile_path;
  Cast({this.id, this.name, this.profile_path});
  factory Cast.fromJson(Map data) {
    return Cast(
      id: data["id"],
      name: data["name"],
      profile_path: data["profile_path"],
    );
  }
}
