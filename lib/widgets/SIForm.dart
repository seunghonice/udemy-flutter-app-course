import 'package:flutter/material.dart';
import 'package:udemy_flutter_app_course/const/currencies.dart';

class SIForm extends StatefulWidget {
  const SIForm({Key? key}) : super(key: key);

  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _minimumPadding = 5.0;
  var currentItem = currencies[0];

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;

    return Scaffold(
      appBar: AppBar(
        title: Text("SIForm"),
      ),
      body: Container(
        padding: EdgeInsets.all(_minimumPadding),
        child: ListView(children: <Widget>[
          Center(
            child: getImageAsset(),
          ),
          Padding(
            padding: EdgeInsets.only(top: _minimumPadding),
            child: TextField(
              style: textStyle,
              decoration: InputDecoration(
                  labelText: "Principal",
                  hintText: "Enter Principal E.g. 12000",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: _minimumPadding),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "In percent",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              )),
          Padding(
              padding: EdgeInsets.only(top: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Term",
                        hintText: "Time in years",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
                  Container(
                    width: _minimumPadding * 5,
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                    value: currentItem,
                    items: currencies.map((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: textStyle,
                          ));
                    }).toList(),
                    onChanged: (String? newValue) => {
                      setState(() {
                        currentItem = newValue!;
                      })
                    },
                  )),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text("Reset", textScaleFactor: 1.2,),
                    onPressed: () {},
                  )),
                  Container(width: _minimumPadding * 2),
                  Expanded(
                      child: ElevatedButton(
                    child: Text("Calculate", textScaleFactor: 1.2,),
                    onPressed: () {},
                  ))
                ],
              )),
          Text("To do ~ ")
        ]),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/bank.png');
    Image image = Image(
      image: assetImage,
      width: 175,
      height: 175,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }
}
