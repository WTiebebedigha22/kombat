import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/kombat_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKombat',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: GameWidget(
            game: KombatGame(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}