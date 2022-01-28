import 'package:fitness_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pages = [
    PageViewModel(
      title: "Title of first page",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(child: Image.asset("assets/1.png", height: 175.0)),
      decoration: const PageDecoration(
          pageColor: Color(0xFF192A56),
          bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
    ),
    PageViewModel(
      title: "Title of first page",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(child: Image.asset("assets/2.png", height: 175.0)),
      decoration: const PageDecoration(
          pageColor: Color(0xFF192A56),
          bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
    ),
    PageViewModel(
      title: "Title of first page",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(child: Image.asset("assets/3.png", height: 175.0)),
      decoration: const PageDecoration(
          pageColor: Color(0xFF192A56),
          bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: pages,
      onDone: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      },
      onSkip: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      },
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        color: Colors.white,
      ),
      next: const Icon(Icons.arrow_right, color: Colors.white),
      done: const Text("Done",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.deepOrange,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    ));
  }
}
