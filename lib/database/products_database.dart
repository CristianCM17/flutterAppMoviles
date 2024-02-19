import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductsDatabase{

  static final NAMEDB='DESPENSADB';
  static final VERSIONDB=1;

  static Database? _database;
  Future<Database> get database async {
    if (_database == null)  return _database!; //el signo de admiracion dice que no pude ser null
    return _database = await _initDatabase();        
  }

  Future<Database> _initDatabase() async{
   Directory folder= await getApplicationDocumentsDirectory();
   String pathDB= join(folder.path);
   return openDatabase(
    pathDB,
    version: VERSIONDB,
    onCreate: (db, version) {
      String query= '''CREATE TABLE tblProductos(
        idProducto INTEGER PRIMARY KEY,
        nomProducto VARCHAR(30),
        canProducto INTEGER,
        fechaCaducidad DATE
      )''';
      db.execute(query);
    }, 
   );
  }

  Future<int> INSERTAR(Map<String,dynamic> data)async{ //regresa el ultimo id insertado por laaccion de insertar
    var conexion= await database; //regresa la conexion si existe o no
    return conexion.insert('tblProductos', data );

  }
  Future<int> ACTUALIZAR(Map<String,dynamic> data)async{
     var conexion= await database;
     return conexion.update('tblProducts', data, where: 'idProducto= ?', whereArgs: [data['idProducto']]);
  }
  Future<int> ELIMINAR(int idProducto)async{
    var conexion= await database;
    return conexion.delete('tblProducts',where: 'idProducto= ?', whereArgs: [idProducto]);
  }
  Future<ProductosModel> CONSULTAR()async{

  }

  }