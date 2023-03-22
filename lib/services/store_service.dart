import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarnama02/models/models.dart';

class StoreService {
  final db = FirebaseFirestore.instance;
  Future<void> saveProduct(Product product) async {
    await db.collection("product").add(product.toMap());
  }
}
