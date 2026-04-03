import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/data/list_produits.dart';
import 'package:projet/projet_e_commerce/model/class_produit.dart';

/**
 * Passage INDEX , PRODUIT selectionné
 *   => Constructeur
 *   => Navugator  +  arguments :index ou produit
 */
class ProduitDetailPage extends StatefulWidget {
  // Produit produit = Produit(
  //   id: "",
  //   description: "",
  //   title: "",
  //   price: 0,
  //   quantity: 0,
  //   brand: "",
  //   imageUrl: "",
  //   produitCategoryName: "",
  // );
  ProduitDetailPage({super.key});

  @override
  State<ProduitDetailPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProduitDetailPage> {
  @override
  Widget build(BuildContext context) {
    //recupération de l'index du produit selectionné  à partir de
    // ARGUMENTS , du systeme de navigation

    final dynamic args = ModalRoute.of(context)!.settings.arguments;

    int indexProduit;

    if (args == null || args.toString().isEmpty) {
      indexProduit = 0;
    } else {
      // Use int.tryParse to avoid crashes if the string isn't a valid number
      indexProduit = int.tryParse(args.toString()) ?? 0;
    }
    final produit = AllProductData.Produits[indexProduit];
    return Scaffold(
      appBar: AppBar(title: Text(produit.title)),
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(produit.imageUrl),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            child: Column(
              children: [
                const SizedBox(height: 250.0),
                Container(
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          produit.description,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Prix:" + produit.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(),
                      infoProduct("Brand", produit.brand),
                      infoProduct("Quantity", produit.quantity.toString()),
                      infoProduct("Category", produit.produitCategoryName),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text("Add to Cart"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoProduct(String titre, String value) {
    return Row(
      children: [
        Text(titre, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
