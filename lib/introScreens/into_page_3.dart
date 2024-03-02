import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> with SingleTickerProviderStateMixin{

  late final AnimationController _controller;

  bool bookmarked = false;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 114, 197, 243),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*.7,
            
            child: Text("Descubre tu Pokemon Favorito",style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w800,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: Offset(0, 3), 
                )
              ]
            ),
            ),
          ),
          Container(
            
            child: Lottie.asset(
            "images/snorlax.json"
          ),
          ),
        ] 
      ),


    );
  }
}