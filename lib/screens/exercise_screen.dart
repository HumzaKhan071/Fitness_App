import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/Model/exercise_hub.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;
  const ExerciseScreen(
      {Key? key, required this.exercises, required this.seconds})
      : super(key: key);

  final int seconds;
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool _isCompleted = false;
  int _elapsedSeconds = 0;
  Timer? timer;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == widget.seconds) {
        t.cancel();
        setState(() {
          _isCompleted = true;
        });
        playAudio();
      }

      setState(() {
        _elapsedSeconds = t.tick;
      });
    });
    super.initState();
  }

  void playAudio() {
    audioCache.play("cheering1.mp3");
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.exercises.gif!,
              placeholder: (context, url) => Image(
                image: const AssetImage("assets/placeholder.jpg"),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          _isCompleted != true
              ? SafeArea(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text("${_elapsedSeconds}/${widget.seconds} S"),
                  ),
                )
              : Container(),
          SafeArea(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)))
        ],
      ),
    );
  }
}
