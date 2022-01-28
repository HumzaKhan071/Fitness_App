import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/Model/exercise_hub.dart';
import 'package:fitness_app/screens/exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExerciseStart extends StatefulWidget {
  final Exercises exercises;
  const ExerciseStart({Key? key, required this.exercises}) : super(key: key);

  @override
  _ExerciseStartState createState() => _ExerciseStartState();
}

class _ExerciseStartState extends State<ExerciseStart> {
  int seconds = 10;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Hero(
          tag: widget.exercises.id!,
          child: Stack(children: [
            CachedNetworkImage(
              imageUrl: widget.exercises.thumbnail!,
              placeholder: (context, url) => Image(
                image: const AssetImage("assets/placeholder.jpg"),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF000000),
                Color(0x00000000),
              ], begin: Alignment.bottomCenter, end: Alignment.center)),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                width: 200,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(),
                  onChange: (double value) {
                    seconds = value.toInt();
                  },
                  initialValue: 30,
                  min: 10,
                  max: 60,
                  innerWidget: (v) => Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${v.toInt()} S",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ExerciseScreen(
                                exercises: widget.exercises,
                                seconds: seconds,
                              )));
                },
                child: Text(
                  "Start Exercise",
                  style: TextStyle(fontSize: 20),
                ),
                splashColor: Colors.black,
                color: Color(0xFFE83350),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
          ])),
    );
  }
}
