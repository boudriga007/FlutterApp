import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/model/class_produit.dart';
import 'package:projet/projet_e_commerce/model/class_produit_panier.dart';
import 'package:projet/projet_e_commerce/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProduitDetailPage extends StatefulWidget {
  const ProduitDetailPage({super.key});

  @override
  State<ProduitDetailPage> createState() => _ProduitDetailPageState();
}

class _ProduitDetailPageState extends State<ProduitDetailPage> {
  late Produit produit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Récupérer le produit passé en paramètre
    final args = ModalRoute.of(context)!.settings.arguments;
    
    if (args is Produit) {
      produit = args;
      print("Produit sélectionné: ${produit.title}");
    } else {
      // Fallback si jamais l'argument n'est pas un produit
      produit = Produit(
        id: "0",
        title: "Produit inconnu",
        description: "Description non disponible",
        price: 0,
        imageUrl: "",
        brand: "Inconnu",
        produitCategoryName: "Inconnu",  
        quantity: 0,
      );
      print("ERREUR: Aucun produit valide reçu");
    }
  }

  @override
  Widget build(BuildContext context) {
    final monpanier = Provider.of<PanierProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(produit.title),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              produit.imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text("Image non disponible"),
                  ),
                );
              },
            ),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Prix: ${produit.price.toString()} €",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Informations produit",
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
                        onPressed: () {
                          final produitPanier = ProduitPanier(
                            id: produit.id,
                            title: produit.title,
                            description: produit.description,
                            price: produit.price,
                            imageUrl: produit.imageUrl,
                            quantite: 1,
                          );
                          
                          monpanier.ajouterProduit(produitPanier);
                          
                          // Afficher un message de confirmation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${produit.title} ajouté au panier"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              titre,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}