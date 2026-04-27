
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet/projet_e_commerce/data/list_produits.dart';
import 'package:projet/projet_e_commerce/model/class_produit.dart';

class ProduitFirebaseService {

  final CollectionReference collectionProduits =
      FirebaseFirestore.instance.collection('Produits');

  Future<void> saveAllProduits() async {
    try {
      print(" Début sauvegarde des produits...");
      for (var produit in AllProductData.Produits) {
        String cleanId = produit.id.toString().replaceAll(' ', '_');
        await collectionProduits.doc(cleanId).set({
          ...produit.toMap(),
          "originalId": produit.id,
        });
      }
      print(" Sauvegarde terminée: ${AllProductData.Produits.length} produits dans Firebase");
    } catch (e) {
      print(" Erreur sauvegarde: $e");
    }
  }

  Future<List<Produit>> getAllProduits() async {
    try {
      print(" Lecture des produits depuis Firebase...");
      
      QuerySnapshot snapshot = await collectionProduits.get();
      
      print(" Firebase connecté avec succès");
      print(" Nombre de produits chargés: ${snapshot.docs.length}");
      
      List<Produit> produits = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Produit.fromMap({
          ...data,
          "id": doc.id,
        });
      }).toList();
      
      print(" Total: ${produits.length} produits disponibles");
      return produits;
      
    } catch (e) {
      print(" Erreur lecture Firebase: $e");
      return [];
    }
  }
}