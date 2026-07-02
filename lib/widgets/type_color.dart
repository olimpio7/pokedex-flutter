import 'package:flutter/material.dart';

Color typeColor(String? type) {
  switch (type?.toLowerCase()) {
    case "fire":
      return Colors.deepOrange;

    case "water":
      return Colors.blue;

    case "grass":
      return Colors.green;

    case "electric":
      return Colors.amber;

    case "psychic":
      return Colors.pink;

    case "ice":
      return Colors.cyan;

    case "rock":
      return Colors.brown;

    case "ground":
      return const Color(0xffC2A633);

    case "poison":
      return Colors.purple;

    case "bug":
      return Colors.lightGreen;

    case "dragon":
      return Colors.indigo;

    case "ghost":
      return Colors.deepPurple;

    case "dark":
      return Colors.black87;

    case "steel":
      return Colors.blueGrey;

    case "fairy":
      return Colors.pinkAccent;

    case "fighting":
      return Colors.red;

    case "flying":
      return Colors.lightBlue;

    default:
      return Colors.grey;
  }
}