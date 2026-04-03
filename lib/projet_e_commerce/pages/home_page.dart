import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/const/images.dart';
import 'package:projet/projet_e_commerce/myWidgets/carousel_images.dart';
import 'package:projet/projet_e_commerce/myWidgets/image_categorie.dart';
import 'package:projet/projet_e_commerce/myWidgets/mon_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MonMenu(),
      appBar: AppBar(
        title: Text("Page d'accueil"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //affciher uen image
          ImageCarousel(),
          Text(
            "Catégorie",
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.black,
            ),
          ),
          //Catégories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(mesImagesCategories.length, (index) {
                return ImageCategorie(
                  titre: titreMesImagesCategories[index],
                  urlImage: mesImagesCategories[index],
                );
              }),
            ),
          ),
          Text(
            "Marque",
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.black,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(mesImagesCategories.length, (index) {
                return ImageCategorie(
                  titre: titreMesImagesCategories[index],
                  urlImage: mesImagesCategories[index],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
