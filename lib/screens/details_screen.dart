import 'package:flutter/material.dart';
import 'package:proyecto_unidad_1/models/models.dart';
import 'package:proyecto_unidad_1/widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //recibir argumentos
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
      //widget con comportamiento predefinido al hacer scroll
      slivers: [
        _CustomAppBar(
          movie: movie,
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          _PosterAndTitle(movie: movie),
          _Overview(
            movie: movie,
          ),
          Casting(movieId: movie.id),
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      //Widget para que se ajuste al tamaño
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        //eliminar el padding
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.backImage),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterImg),
            height: 250,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: TextStyle(
                  fontSize: 30,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(children: [
                Icon(
                  Icons.star_outline,
                  size: 20,
                  color: Color.fromARGB(255, 207, 188, 16),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  movie.voteAverage.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ])
            ],
          ),
        )
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  _Overview({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}

//se va a hacer en otra parte
class _Casting extends StatelessWidget {
  final int movieId;
  const _Casting({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //Variable para el tamaño
    return Container(
      width: double.infinity,
      height: size.height * 0.35,
      color: Colors.indigo,
      child: Column(
        //una columna
        crossAxisAlignment: CrossAxisAlignment.start, //alineacion
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
                //Es para tener una separacion en ambos lados del mismo tamaño (horizontal y vertical)
                horizontal: 20,
                vertical: 10),
            child: Text(
              //Título de la seccion
              'Casting: ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold, //en negritas
                  color: Colors.white),
            ),
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal, //para moverlo a los lados
            itemCount: 20, //que solo se vean 20
            itemBuilder: (_, int index) =>
                const _CastPoster(), //se llama a la lista/contenedor de la foto y nombre
          ))
        ],
      ),
    );
  }
}

class _CastPoster extends StatelessWidget {
  //el "_" en el nombre sirve para hacerlo privado
  const _CastPoster({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //Contenedor en el que va la foto y el nombre
      width: 130,
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        GestureDetector(
            //Para que detecte lo que pasa con la imagen
            // onTap: () => Navigator.pushNamed(context, 'details',
            //     arguments:
            //         ''), //El evento, en este caso hace que se muestre otra pantalla
            child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: AssetImage(
                'assets/no-image.jpg'), //aqui va la foto del actor/actriz
            width: 130,
            height: 150,
          ),
        )),
        const SizedBox(
          //cajita para el nombre del actor
          height: 5,
        ),
        const Text(
          'Nombre del actor o actriz',
          maxLines: 2,
          overflow:
              TextOverflow.ellipsis, //Para que no salga que es mucho texto
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
