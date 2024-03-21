import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsFirebase {
  final fireStore = FirebaseFirestore.instance;

  CollectionReference? _productsCollection;

  ProductsFirebase() {
    _productsCollection = fireStore.collection('productos');
  }

  Stream<QuerySnapshot> consultar() {
    return _productsCollection!.snapshots(); //Obtenemos los resultados de la BD
  }

  Future<void> insertar(Map<String, dynamic> data) async {
    return _productsCollection!.doc().set(data);
  }

  Future<void> actualizar(Map<String, dynamic> data, String id) async {
    return _productsCollection!.doc(id).update(data);
  }

  Future<void> borrar(String id) async {
    _productsCollection!.doc(id).delete();
  }
}