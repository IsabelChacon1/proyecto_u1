import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:proyecto_unidad_1/models/credits_response.dart";
import "package:proyecto_unidad_1/providers/movies_provider.dart";

class Casting extends StatelessWidget {
  final int movieId;
  const Casting({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final size = MediaQuery.of(context).size; //Variable para el tamaño
    return FutureBuilder(
        future: moviesProvider.getMoviesCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 150),
              height: 180,
              child: CupertinoActivityIndicator(),
            );
          }
          final List<Cast> cast = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(actor: cast[index]),
            ),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(actor.fullProfilePath),
            height: 140,
            width: 100,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          actor.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}

class CastPoster extends StatelessWidget {
  //el "_" en el nombre sirve para hacerlo privado
  const CastPoster({super.key});

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
