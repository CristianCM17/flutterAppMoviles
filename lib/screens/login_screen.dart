
//import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;
//input usuario
  final txtUser = TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );

//input contrasenia
  final pwdUser = TextFormField(
    keyboardType: TextInputType.text,
    obscureText: true,
    decoration: const InputDecoration(
      border: OutlineInputBorder()
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height, // ocupe toda la altura de la pantalla 
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/wall2.jpg')
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 370,
              child: Opacity(
                opacity: .5,
                child: Container(
                  padding: EdgeInsets.all(10), // habrá un espacio de 10 píxeles entre el borde del Container interno y su contenido.
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  height: 155,
                  width: MediaQuery.of(context).size.width*.9, //ocupará el 90% del ancho de la pantalla 
                  child: ListView(
                      shrinkWrap: true,
                      children: [
                        txtUser,
                        const SizedBox(height: 10,),
                        pwdUser
                        
                      ],
                    ),
                ),
              ),
            ),
            Positioned(
              top: 220,
              child: Container(
                child: Image.asset('images/letras.png'),
                width: MediaQuery.of(context).size.width*.9,
                height: 200,
                ),
              
              ),
            Positioned(
              bottom: 40,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width*.9,
                child: ListView(
                  shrinkWrap: true, //el list view se adaptara a el tamano de sus hijos
                  children: [
                    SignInButton(
                      Buttons.Email, 
                      onPressed: (){
                        setState(() {
                          isLoading = !isLoading;
                        });
                        Future.delayed(
                          new Duration(milliseconds: 5000),
                          (){
                           /* Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => new DashboardScreen(),)
                            );*/
                            Navigator.pushNamed(context, "/dash").then((value){ //si paso parametros el values los trae
                              setState(() {
                                isLoading= !isLoading;
                              });
                            });
                          }
                        );
                      }
                    ),
                    SignInButton(
                      Buttons.Google, 
                      onPressed: (){}
                    ),
                    SignInButton(
                      Buttons.Facebook, 
                      onPressed: (){}
                    ),
                    SignInButton(
                      Buttons.GitHub, 
                      onPressed: (){}
                    ),
                  ],
                ),
              )
            ),
            isLoading ? const Positioned(
              top: 220,
              child: CircularProgressIndicator(
                color: Colors.white,
              )
            )
            : Container()
          ],
        ),
      ),
    );
  }
}