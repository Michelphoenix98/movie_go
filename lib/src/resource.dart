import 'package:http/http.dart' as http;
import '../movie_go.dart';
import 'config.dart';

Future<List<Movie>> getTopRated() async {
  String apikey = getApiKey();
  var url =
      Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=$apikey');

  http.Response response = await http.get(url);
  return json.decode(response.body)["results"].map<Movie>((element) {
    return Movie.fromJson(element);
  }).toList();
}

Future<Map> getTVShows() async {
  String apikey = getApiKey();
  var url = Uri.parse(
      'https://api.themoviedb.org/3/tv/popular?api_key=$apikey&language=en-US&page=1');

  http.Response response = await http.get(url);

  return json.decode(response.body);
}

Future<List<Cast>> getCast(int movieId) async {
  String apikey = getApiKey();
  var url = Uri.parse(
      'https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=$apikey&language=en-US');

  http.Response response = await http.get(url);

  return json
      .decode(response.body)["cast"]
      .map<Cast>((element) {
        return Cast.fromJson(element);
      })
      .take(20)
      .toList();
}
