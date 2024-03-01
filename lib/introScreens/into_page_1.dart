import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
   const IntroPage1({Key? key}) : super(key: key); // Corrección aquí


  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> with SingleTickerProviderStateMixin{

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
        children: [
          Container(
            alignment: Alignment(0, 0),
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
              "images/poke.json",
              controller: _controller,
              height: 250
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Image.asset("images/gotta.jpg"),
          )
        ]
      ),


    );
  }
}