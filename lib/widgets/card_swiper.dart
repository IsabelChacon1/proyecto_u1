import "package:card_swiper/card_swiper.dart";
import "package:flutter/material.dart";
import "package:proyecto_unidad_1/models/models.dart";

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity, //el contenedor toma el anocho de la pantalla
        height: size.height * 0.5, //el alto es la mitad de la pantalla
        child: Swiper(
            itemCount:
                movies.length, //cuenta las peliculas que hay para mostrar
            layout: SwiperLayout.STACK, //FORMA EN QUE SE VEN LAS TARJETAS
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (_, int index) {
              final movie = movies[index];
              //print(movie.posterPath); //donde está la imagen
              //print(movie.fullPosterImg); //la imagen?
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: ''),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(
                        movie.fullPosterImg), //la imagen de la pelicula
                  ),
                ), //HACE LOS BORDES REDONDEADOS
              );
            }));
  }
}
