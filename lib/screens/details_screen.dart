import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //recibir argumentos
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'Sin nombre';

    return const Scaffold(
        body: CustomScrollView(
      //widget con comportamiento predefinido al hacer scroll
      slivers: [
        _CustomAppBar(),
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          _PosterAndTitle(),
          _Overview(),
          _Casting(),
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

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
          child: const Text(
            'movie.title',
            style: TextStyle(fontSize: 18),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: AssetImage('assets/no-image.jpg'),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: AssetImage('assets/no-image.jpg'),
            height: 250,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: TextStyle(
                  fontSize: 30,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'movie.titleOriginal',
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
                  'movie.voteAverage',
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
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Text(
        'Officia aliqua cupidatat Lorem est ea adipisicing deserunt. Pariatur nostrud sit quis ex tempor fugiat cupidatat consectetur laboris est anim veniam laboris occaecat. Amet eiusmod fugiat excepteur amet sunt et reprehenderit ut amet magna adipisicing consequat exercitation ex. Duis aliquip cupidatat magna nulla quis labore ullamco id ad. Incididunt ex excepteur nisi laborum amet enim. Est ex aliqua consectetur enim esse. Irure deserunt mollit duis anim ad ad laborum esse fugiat enim veniam fugiat deserunt eiusmod.Cillum consequat dolor id commodo consectetur. Incididunt voluptate esse tempor mollit anim et duis. Eiusmod laborum labore laboris ad reprehenderit. Qui do quis fugiat deserunt magna. Esse irure fugiat eiusmod cupidatat amet tempor eiusmod irure. Labore magna cillum in cupidatat ipsum labore minim pariatur aliquip laboris occaecat nisi.Consectetur laborum proident esse do elit irure ea irure deserunt. Elit exercitation ipsum velit laborum consequat duis enim quis. Ipsum ad ipsum quis culpa culpa elit qui.Non et est officia est irure deserunt ullamco Lorem amet. Minim nostrud adipisicing ut velit dolor sit consequat et fugiat id aute mollit. Excepteur esse non excepteur reprehenderit cupidatat nulla labore ipsum duis nisi nulla consequat enim.',
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}

class _Casting extends StatelessWidget {
  const _Casting({super.key});

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
