import 'package:flutter/material.dart';

class FavoriteCity extends StatefulWidget {
  @override
  _FavoriteCityState createState() => _FavoriteCityState();
}

class _FavoriteCityState extends State<FavoriteCity> {
  String cityName = "";

  @override
  Widget build(BuildContext context) {
    debugPrint("Favorite City widget is created");
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("My Flutter App"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String userInput) {
                setState(() {
                  debugPrint(
                      "set State is called, this tells framework to redraw the FavCity widget");
                  cityName = userInput;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Your best city is $cityName",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
