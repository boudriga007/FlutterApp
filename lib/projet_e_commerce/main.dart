import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/pages/barre_navigation.dart';
import 'package:projet/projet_e_commerce/pages/favoris.dart';
import 'package:projet/projet_e_commerce/pages/home_page.dart';
import 'package:projet/projet_e_commerce/pages/page_user.dart';
import 'package:projet/projet_e_commerce/pages/panier.dart';
import 'package:projet/projet_e_commerce/pages/produit_detail.dart';
import 'package:projet/projet_e_commerce/pages/produit_list.dart';
import 'package:projet/projet_e_commerce/provider/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PanierProvider())],
      child: EcommerceApp(),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home': (context) => HomePage(),
        'listProduit': (context) => ProduitListPage(),
        'detailProduit': (context) => ProduitDetailPage(),
        'panier': (context) => PanierScreen(),
        'favorite': (context) => FavoriPage(),
        'profile': (context) => UserInfoPage(),
        'barreNavigation': (context) => BarreNavigationScreen(),
      },
      initialRoute: 'barreNavigation',
      //home: BarreNavigationScreen()
      //HomePage()
    );
  }
}
