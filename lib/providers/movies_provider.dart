import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_unidad_1/models/credits_response.dart';
import 'package:proyecto_unidad_1/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '9dc27117b000e7e5acfb365fa957971a';
  String _language = 'es-MX';

  List<Movie> onDisplayMovies = []; //Lista con las películas
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    //getMoviesCast();
  }

  getOnDisplayMovies() async {
    //aquí se llena la lista de las peliculas
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(response.body);
    //print(decodeData);
    //print(response.body);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response
        .body); //Creación de una variable que aprende la respuesta de la petición (instancia)
    onDisplayMovies = nowPlayingResponse.results;
    //le notificamos a los widgets que estan escuchando que se cambió la data por lo tanto se tiene que redibujar
    notifyListeners(); //Actualiza todo
    //  print(nowPlayingResponse.results[0].title); //
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);

    final popularResponse = PopularResponse.fromRawJson(response
        .body); //Creación de una variable que aprende la respuesta de la petición

    //Destructurar resultado para cambiar página y mantener los datos actuales
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (movieCast.containsKey(movieId))
      return movieCast[movieId]!; //si ya esta guardado no hace todo el proceso

    var url = Uri.https(_baseUrl, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    final credit_response = CreditResponse.fromJson(jsonDecode(response.body));

    movieCast[movieId] = credit_response
        .cast; //guardamos el resultado de la variable para optimizar

    //Variable: espacio guardado en memoria que puede estar sujeto a restricciones de tipo
    return credit_response.cast;
  }
}
