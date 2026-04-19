import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/model/class_produit.dart';
import 'package:projet/projet_e_commerce/model/class_produit_panier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PanierProvider with ChangeNotifier {
  //attribut Private panier
  List<ProduitPanier> _panier = [];
  PanierProvider(){
    getCart();
  }
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

  // Gestion de la persistance de données
  //sauvegarder le cointenu du panier
  Future<void> saveCart() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    final List<String> panierjson = _panier
        .map((item) => item.toJson())
        .toList();
    await data.setString("savedCart", json.encode(panierjson).toString());
    print("Sauvagarde Panier: ${_panier.length} Produits");
    //data =>
    //setString
    //setListString
    // _panier => List de Produit Panier
    //format String
    // _panier => JSON => String
    // => JSON => String FORMATE
  }

  //Charger le contenu du panier
  Future<void> getCart() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    final String? x = await data.getString("savedCart");
    if (x == null) {
      _panier = [];
    } else {
      final List<dynamic> panierjson = json.decode(x);

      _panier = panierjson.map((item) => ProduitPanier.fromJson(item)).toList();
    }
    print("Recupération des produits sauvegardés: ${_panier.length} Produits");
    notifyListeners();
  }
}
