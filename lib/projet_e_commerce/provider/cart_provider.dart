import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/model/class_produit_panier.dart';

class PanierProvider with ChangeNotifier {
  //attribut Private panier
  List<ProduitPanier> _panier = [];
  //GETTER => GET
  List<ProduitPanier> get Panier {
    return _panier;
  }
  //SETTER => on ne doit pas les ajouer
  //---------- Methode Ajouter Produit

  void ajouterProduit(ProduitPanier produitAjouter) {
    ProduitPanier? produitTrouve = _panier.firstWhere(
      (art) {
        if (art.id == produitAjouter.id) {
          art.quantite += 1;
          return true;
        }
        return false;
      },
      orElse: () {
        print("Ajout nouveau  produit :" + produitAjouter.title);

        final p = ProduitPanier(
          id: produitAjouter.id,
          title: produitAjouter.title,
          description: produitAjouter.description,
          price: produitAjouter.price,
          imageUrl: produitAjouter.imageUrl,
          quantite: 1,
        );
        _panier.add(p);
        
        return p;
      },
    );
    notifyListeners();
  }
}
