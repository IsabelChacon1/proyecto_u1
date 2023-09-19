import "package:flutter/material.dart";

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

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
            itemCount: 20, //que solo sean 20
            itemBuilder: (_, int index) => const _MoviePoster(),
          ))
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  //el "_" en el nombre sirve para hacerlo privado
  const _MoviePoster({super.key});

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
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: AssetImage('assets/no-image.jpg'),
                width: 130,
                height: 150,
              ),
            )),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Aliqua quien sabe que mas decía pero era mucho texto y así',
          maxLines: 3,
          overflow:
              TextOverflow.ellipsis, //Para que no salga que es mucho texto
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
