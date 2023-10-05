import "package:flutter/material.dart";
import "package:proyecto_unidad_1/models/models.dart";

class MovieSlider extends StatelessWidget {
  final List<Movie> movies; //Lista de peliculas
  final String? title; //el titulo es opcional
  MovieSlider({super.key, required this.movies, this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //Variable para el tamaño
    return Container(
      width: double.infinity,
      height: size.height * 0.35,
      color: Colors.blue,
      child: Column(
        //una columna
        crossAxisAlignment: CrossAxisAlignment.start, //alineacion
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    20), //Es para tener una separacion en ambos lados del mismo tamaño
            child: Text(
              'POPULARES',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, //en negritas
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal, //para moverlo a los lados
            itemCount:
                movies.length, //Que aparezcan todas las pelis de la lista
            itemBuilder: (_, int index) => _MoviePoster(movie: movies[index]),
          ))
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  //el "_" en el nombre sirve para hacerlo privado

  final Movie movie;
  _MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        GestureDetector(
            //Para que detecte lo que pasa con la imagen
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments:
                    ''), //El evento, en este caso hace que se muestre otra pantalla
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 150,
              ),
            )),
        const SizedBox(
          height: 5,
        ),
        Text(
          movie.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold, //en negritas
          ),
          maxLines: 3,
          overflow:
              TextOverflow.ellipsis, //Para que no salga que es mucho texto
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
