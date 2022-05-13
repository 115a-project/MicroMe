import 'package:flutter/material.dart';
import 'package:testing/Pages/charts/data.dart'; 

class BarData {
  static int interval = 7;

  static List<Data> barData = [
    Data(
      id: 0,
      name: "Mon",
      y: 15.0,
      color: Color(0xff19bfff),
    ),
    Data(
      id: 1,
      name: "Tues",
      y: 20.0,
      color: Color(0xff19bfff),
    ),
    Data(
      id: 2,
      name: "Wed",
      y: 15,
      color: Color(0xff19bfff),
    ),
    Data(
      id: 3,
      name: "Thurs",
      y: 20.0,
      color: Color(0xff19bfff),
    ),
    Data(
      id: 4,
      name: "Fri",
      y: 15.0,
      color: Color(0xff19bfff),
    ),
    Data(
      id: 5,
      name: "Sat",
      y: 0.0,
      color: Color(0xff19bfff),
    ),
    Data(
      id: 6,
      name: "Sun",
      y: 4.0,
      color: Color(0xff19bfff),
    ),

  ];

}
