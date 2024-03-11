import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthFirebase {
  final auth = FirebaseAuth.instance;

  Future<bool> singUpUser({required name,required String password, required String email})async{
   
    try {
      //generar en firebase el usuario 
     final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
     if (userCredential.user != null) {
      //mandar al correo para poder validar
      userCredential.user!.sendEmailVerification();

      return true;
     }
    return false;
    } catch (e) {
      return false;
    }


    
  }
}