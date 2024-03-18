import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthFirebase {
  final auth = FirebaseAuth.instance;

  Future<bool> singUpUser({required String name,required String password, required String email})async{
   
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

  Future<bool> signInUser({required String password, required String email})async{

    final userCredential =await auth.signInWithEmailAndPassword(email: email, password: password);
    var band = false;

    if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) { //si el email esta verificado
          band = true;
         
        }
    }

    return band;

  }
}