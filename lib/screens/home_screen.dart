// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/Model/exercise_hub.dart';
import 'package:fitness_app/screens/exercise_start.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiURL =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

   ExerciseHub? exerciseHub;

  @override
  void initState() {
    getExercises();
    super.initState();
  }

  void getExercises() async {
    var response = await http.get(Uri.parse(apiURL));
    var body = response.body;

    var decodedJson = jsonDecode(body);

    exerciseHub = ExerciseHub.fromJson(decodedJson);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness App"),
        centerTitle: true,
      ),
      body: Container(
        child: exerciseHub != null
            ? ListView(
                children: exerciseHub!.exercises!
                    .map((e) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ExerciseStart(exercises: e)));
                          },
                          child: Hero(
                            tag: e.id!,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: FadeInImage(
                                  placeholder: const AssetImage(
                                      "assets/placeholder.jpg"),
                                  image: NetworkImage(e.thumbnail!),
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  fit: BoxFit.cover,
                                  ),
                                  // child: CachedNetworkImage(
                                  //   imageUrl: e.thumbnail!,
                                  //   placeholder: (context, url) => Image(
                                  //     image: const AssetImage(
                                  //         "assets/placeholder.jpg"),
                                  //     fit: BoxFit.cover,
                                  //     height:
                                  //         MediaQuery.of(context).size.height,
                                  //     width: MediaQuery.of(context).size.width,
                                  //   ),
                                  //   errorWidget: (context, url, error) =>
                                  //       const Icon(Icons.error),
                                  //   fit: BoxFit.cover,
                                  //   height: MediaQuery.of(context).size.height,
                                  //   width: MediaQuery.of(context).size.width,
                                  // ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          Color(0xFF000000),
                                          Color(0x00000000),
                                        ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.center)),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 250,
                                  margin: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: Text(
                                    e.title!,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ))
                    .toList(),
              )
            : const LinearProgressIndicator(),
      ),
    );
  }
}
