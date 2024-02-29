import 'package:flutter/material.dart';
import 'package:flutter_application_1/introScreens/into_page_1.dart';
import 'package:flutter_application_1/introScreens/into_page_2.dart';
import 'package:flutter_application_1/introScreens/into_page_3.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _controller = PageController();

  bool  onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ 

          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onLastPage = (index == 2); //si esta en la ultima pagina regresa true
              });
            } ,
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),
        Container(
          alignment: Alignment(0,0.75), //0 horizontal en medio y 0.5 es para abajo en vertical
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              //skip
              GestureDetector(
                onTap: (){
                  _controller.jumpToPage(2);
                },
                child: Text("Skip")
                ),

              SmoothPageIndicator(controller: _controller, count: 3),

              onLastPage
              ? 
              //next or done
              GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/dash");
                  },
                child: Text("Done")
                ): GestureDetector(
                  onTap: (){
                  _controller.nextPage(duration: Duration(milliseconds: 500), 
                  curve: Curves.easeIn//estás indicando que deseas una transición que comience lentamente y luego se acelere más rápidamente 
                  );
                },
                child: Icon(Icons.arrow_circle_right_outlined)
                ),
            ],
          ),
          )
        ]
      ),



    );
  }
}