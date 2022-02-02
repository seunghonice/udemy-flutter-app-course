import 'package:flutter/material.dart';
import 'package:udemy_flutter_app_course/widgets/SIForm.dart';

void main() {
  /**
   * FavoriteCity
   */
  // runApp(
  //     MaterialApp(
  //       title: "Stateful App Example",
  //       home: FavoriteCity(),
  //     )
  // );

  /**
   * Calculator App
   */
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator App",
      home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.amber,
      accentColor: Colors.amberAccent,
      backgroundColor: Colors.black12,
      buttonColor: Colors.amberAccent
    ),
  ));
}
