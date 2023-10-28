import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> images = [
    'assets/images/cuidador1.jpeg',
    'assets/images/veterinario.jpeg',
    'assets/images/adestrador1.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        disableCenter: true,
        enlargeCenterPage: false,
      ),
      items: images.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
