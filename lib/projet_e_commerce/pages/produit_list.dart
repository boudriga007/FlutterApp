// lib/projet_e_commerce/pages/produit_list.dart

import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/model/class_produit.dart';
import 'package:projet/projet_e_commerce/myWidgets/un_produit.dart';
import 'package:projet/projet_e_commerce/services/produit_firebase_service.dart';

class ProduitListPage extends StatefulWidget {
  const ProduitListPage({super.key});

  @override
  State<ProduitListPage> createState() => _ProduitListPageState();
}

class _ProduitListPageState extends State<ProduitListPage> {

  final ProduitFirebaseService _service = ProduitFirebaseService();
  late Future<List<Produit>> _produitsFuture;

  @override
  void initState() {
    super.initState();
    print(" Initialisation de la page produit...");
    _produitsFuture = _service.getAllProduits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page Liste des produits"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                print(" Rafraîchissement manuel...");
                _produitsFuture = _service.getAllProduits();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Produit>>(
        future: _produitsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Chargement des produits..."),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text("Erreur : ${snapshot.error}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _produitsFuture = _service.getAllProduits();
                      });
                    },
                    child: const Text("Réessayer"),
                  ),
                ],
              ),
            );
          }

          final produits = snapshot.data ?? [];
          
          if (produits.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Aucun produit trouvé."),
                  SizedBox(height: 8),
                  Text("Vérifiez la connexion Firebase"),
                ],
              ),
            );
          }

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.4,
            children: List.generate(produits.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'detailProduit',
                    arguments: produits[index],
                  );
                },
                child: WidgetProduit(p: produits[index]),
              );
            }),
          );
        },
      ),
    );
  }
}