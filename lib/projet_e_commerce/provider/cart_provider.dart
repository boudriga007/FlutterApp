
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/model/class_produit_panier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PanierProvider with ChangeNotifier {
  List<ProduitPanier> _panier = [];
  
  PanierProvider() {
    getCart();
  }
  
  List<ProduitPanier> get Panier {
    return _panier;
  }
  
  void ajouterProduit(ProduitPanier produitAjouter) {
    int indexExistant = _panier.indexWhere((art) => art.id == produitAjouter.id);
    
    if (indexExistant != -1) {
      _panier[indexExistant].quantite += 1;
    } else {
      _panier.add(produitAjouter);
    }
    
    notifyListeners();
    saveCart(); // Sauvegarde immédiate
  }
  
  void supprimerProduit(ProduitPanier produit) {
    _panier.removeWhere((item) => item.id == produit.id);
    notifyListeners();
    saveCart();
  }
  
  void modifierQuantite(String produitId, int nouvelleQuantite) {
    int index = _panier.indexWhere((item) => item.id == produitId);
    if (index != -1) {
      if (nouvelleQuantite <= 0) {
        _panier.removeAt(index);
      } else {
        _panier[index].quantite = nouvelleQuantite;
      }
      notifyListeners();
      saveCart();
    }
  }
  
  void viderPanier() {
    _panier.clear();
    notifyListeners();
    saveCart();
  }
  
  // Sauvegarde dans SharedPreferences
  Future<void> saveCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> panierJson = _panier.map((item) => item.toJson()).toList();
    await prefs.setString('cart_data', json.encode(panierJson));
    print("Panier sauvegardé: ${_panier.length} produits");
  }
  
  // Chargement depuis SharedPreferences
  Future<void> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString('cart_data');
    
    if (cartString != null && cartString.isNotEmpty) {
      final List<dynamic> cartJson = json.decode(cartString);
      _panier = cartJson.map((item) => ProduitPanier.fromJson(item)).toList();
      print("Panier chargé: ${_panier.length} produits");
    } else {
      _panier = [];
      print("Panier: vide");
    }
    notifyListeners();
  }
}