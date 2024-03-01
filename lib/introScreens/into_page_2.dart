import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> with SingleTickerProviderStateMixin{

  late final AnimationController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      reverseDuration: Duration(milliseconds: 500),
      vsync: this,
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  bool bookmarked = false;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:[ 
          Positioned(
            bottom: 570,
            child: Lottie.asset(
              "images/la.json"
            ),
          ),

        Container(
          alignment: Alignment(0, -0.45),
          child: Text("REVIVE LA NOSTALGIA",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
          ),
        ),
        Container(
          width:  MediaQuery.of(context).size.width*.7,
          alignment: Alignment(0, -0.25),
          child: Text("En un mundo lleno de maravillas y misterios, los Pokémon han sido compañeros inseparables. Cada día es una nueva aventura mientras exploras los bosques, montañas y mares en busca de estas criaturas increíbles.",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          ),
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
          Lottie.asset(
          "images/pika.json",
          height: 100
        ),
          Lottie.asset(
          "images/pika.json",
          height: 100
        )
          ],
        ),
        Container(
          alignment: Alignment(0, 0.5),
          child: GestureDetector(
            onTap: (){
              if (bookmarked == false ) {
                bookmarked = true;
                _controller.forward();
              }else{
                bookmarked = false;
                _controller.reverse();
              }
            },
            child: Lottie.asset(
              "images/bu.json",
              controller: _controller,
              height: 305
            ),
            ),
        )
        ]
      ),
    );
  }
}