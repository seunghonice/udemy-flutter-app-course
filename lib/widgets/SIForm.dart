import 'package:flutter/material.dart';
import 'package:udemy_flutter_app_course/const/currencies.dart';

class SIForm extends StatefulWidget {
  const SIForm({Key? key}) : super(key: key);

  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  final double _minimumPadding = 5.0;
  var _currentItem = "";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = "";


  @override
  void initState() {
    super.initState();

    _currentItem = currencies[0];
  }

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
              controller: principalController,
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
                controller: roiController,
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
                    controller: termController,
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
                    value: _currentItem,
                    items: currencies.map((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: textStyle,
                          ));
                    }).toList(),
                    onChanged: (String? newValue) =>
                        {_onDropDownItemSelected(newValue)},
                  )),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    child: Text(
                      "Calculate",
                      textScaleFactor: 1.2,
                    ),
                    onPressed: () {
                      setState(() {
                        displayResult = _calculateTotalReturns();
                      });
                    },
                  )),
                  Container(width: _minimumPadding * 2),
                  Expanded(
                      child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Reset",
                      textScaleFactor: 1.2,
                    ),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                  )),
                ],
              )),
          Padding(
            padding: EdgeInsets.all(_minimumPadding),
            child: Text(displayResult),
          )
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

  void _onDropDownItemSelected(String? newValue) {
    setState(() {
      _currentItem = newValue!;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        "After $term years, your investment will be worth $totalAmountPayable";
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentItem = currencies.first;
  }
}
