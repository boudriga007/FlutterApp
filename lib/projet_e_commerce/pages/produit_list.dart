import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/data/list_produits.dart';
import 'package:projet/projet_e_commerce/myWidgets/un_produit.dart';
import 'package:projet/projet_e_commerce/pages/produit_detail.dart';

class ProduitListPage extends StatefulWidget {
  const ProduitListPage({super.key});

  @override
  State<ProduitListPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProduitListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Liste des produits"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.4,
        children: List.generate(AllProductData.Produits.length, (index) {
          return InkWell(
            onTap: () {
              //Implémenter la navigation pour charger la page Detail produits
              Navigator.pushNamed(context,'detailProduit',arguments: index);
              // ProduitDetailPage(produit: AllProductData.Produits[index]);
            },
            child: WidgetProduit(p: AllProductData.Produits[index]),
          );
        }),
      ),
    );
  }
}
