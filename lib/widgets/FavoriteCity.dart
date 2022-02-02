import 'package:flutter/material.dart';
import '../const/currencies.dart';

class FavoriteCity extends StatefulWidget {
  @override
  _FavoriteCityState createState() => _FavoriteCityState();
}

class _FavoriteCityState extends State<FavoriteCity> {
  String cityName = "";
  var _currentItemSelected = "Rupees";

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
              onSubmitted: (String userInput) {
                setState(() {
                  debugPrint(
                      "set State is called, this tells framework to redraw the FavCity widget");
                  cityName = userInput;
                });
              },
            ),
            DropdownButton<String>(
              value: _currentItemSelected,
              items: currencies
                  .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                  .toList(),
              onChanged: (String? newItemSelected) {
                _onDropdownItemSelected(newItemSelected!);
              },
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Your best city is $cityName with $_currentItemSelected",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onDropdownItemSelected(String newItemSelected) {
    setState(() {
      _currentItemSelected = newItemSelected;
    });
  }
}
