import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.cyan,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Jokes App',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.cyan,
          ),
          body: PageView.builder(
            itemBuilder: (context, index) => FutureBuilder(
                future: getRandomJoke(),
                builder: (context, snapshot) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xffFCE8D5),
                          borderRadius: BorderRadius.circular(12)),
                      child: AnimatedSwitcher(
                        duration: Durations.extralong1,
                        child: (snapshot.connectionState ==
                                ConnectionState.waiting)
                            ? CircularProgressIndicator(
                                color: Colors.cyan,
                              )
                            : Text(snapshot.data!),
                      ),
                    ),
                  );
                }),
          )),
    );
  }

  Future<String> getRandomJoke() async {
    return jsonDecode((await get(Uri.parse(
            'https://geek-jokes.sameerkumar.website/api?format=json')))
        .body)['joke'];
  }
}
