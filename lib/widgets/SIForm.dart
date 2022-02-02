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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentItem = currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;
    var errorStyle = TextStyle(color: Colors.amber, fontSize: 8);

    return Scaffold(
      appBar: AppBar(
        title: Text("SIForm"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(children: <Widget>[
              Center(
                child: getImageAsset(),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding),
                child: TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please Enter right value";
                    }
                    return null;
                  },
                  style: textStyle,
                  controller: principalController,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      hintText: "Enter Principal E.g. 12000",
                      labelStyle: textStyle,
                      errorStyle: errorStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: _minimumPadding),
                  child: TextFormField(
                    controller: roiController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter right value";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        hintText: "In percent",
                        labelStyle: textStyle,
                        errorStyle: errorStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: termController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter right value";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Term",
                            hintText: "Time in years",
                            labelStyle: textStyle,
                            errorStyle: errorStyle,
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
                            if (_formKey.currentState!.validate()) {
                              displayResult = _calculateTotalReturns();
                            }
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
            ])),
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
