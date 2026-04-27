
import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/model/class_produit_panier.dart';
import 'package:projet/projet_e_commerce/myWidgets/cart_empty.dart';
import 'package:projet/projet_e_commerce/myWidgets/widget_produit_dans_panier.dart';
import 'package:projet/projet_e_commerce/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class PanierScreen extends StatelessWidget {
  const PanierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProduitPanier> contenuPanier = Provider.of<PanierProvider>(
      context,
    ).Panier;

    print("TAILLE PANIER: ${contenuPanier.length}");

    return contenuPanier.isEmpty
        ? const Scaffold(body: CartEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Nombre Produit: " + contenuPanier.length.toString(),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // Vider le panier
                    final panierProvider = Provider.of<PanierProvider>(
                      context,
                      listen: false,
                    );
                    panierProvider.viderPanier();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Panier vidé")),
                    );
                  },
                  icon: const Icon(Icons.delete_sweep),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: ListView.builder(
                itemCount: contenuPanier.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return WidgetProduitPanier(
                    produitPanier: contenuPanier[index],
                  );
                },
              ),
            ),
          );
  }
}