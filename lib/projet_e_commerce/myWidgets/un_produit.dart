import 'package:flutter/material.dart';
import 'package:projet/projet_e_commerce/model/class_produit.dart';

class WidgetProduit extends StatefulWidget {
  Produit p = Produit(
    id: "",
    description: "",
    price: 0,
    quantity: 0,
    imageUrl: "",
    title: "",
    brand: "",
    produitCategoryName: "",
  );
  WidgetProduit({super.key, required this.p});
  @override
  _WidgetProduitState createState() => _WidgetProduitState();
}

// passage desdata : data :Widget Pere => widget Fils
class _WidgetProduitState extends State<WidgetProduit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                child: Image.network(
                  widget.p.imageUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.38,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 25,
                right: 25,
                child: Badge(
                  largeSize: 28,
                  label: Text('New', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.purple,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 3,
                  widget.p.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.p.price} tnd',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Quantité : ${widget.p.quantity}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
