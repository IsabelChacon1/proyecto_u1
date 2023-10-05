import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_unidad_1/models/models.dart';
import 'package:proyecto_unidad_1/models/now_playing_response.dart';
import 'package:proyecto_unidad_1/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '9dc27117b000e7e5acfb365fa957971a';
  String _language = 'es-MX';

  List<Movie> onDisplayMovies = []; //Lista con las películas
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }
  getOnDisplayMovies() async {
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
        .body); //Creación de una variable que aprende la respuesta de la petición
    onDisplayMovies = nowPlayingResponse.results;
    //le notificamos a los widgets que estan escuchando que se cambió la data por lo tanto se tiene que redibujar
    notifyListeners();
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
}
