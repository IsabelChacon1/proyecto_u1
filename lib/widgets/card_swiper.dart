import "package:card_swiper/card_swiper.dart";
import "package:flutter/material.dart";

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity, //el contenedor toma el anocho de la pantalla
        height: size.height * 0.5, //el alto es la mitad de la pantalla
        child: Swiper(
            itemCount: 10,
            layout: SwiperLayout.STACK, //FORMA EN QUE SE VEN LAS TARJETAS
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (_, int index) {
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: ''),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: AssetImage('assets/no-image.jpg'),
                    //NetworkImage('https://via.placeholder.com/300x400')
                  ),
                ), //HACE LOS BORDES REDONDEADOS
              );
            }));
  }
}
