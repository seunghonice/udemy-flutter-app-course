import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  NoteDetail(this.appBarTitle, {Key? key}) : super(key: key);

  String appBarTitle = "";

  @override
  _NoteDetailState createState() => _NoteDetailState(this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  static var _priority = ["high", "low"];

  String appBarTitle = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _NoteDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme
        .of(context)
        .textTheme
        .subtitle1;

    return WillPopScope(onWillPop: () {
      moveToLastScreen();
      return Future.value(true);
    }, child: Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            // first element
            ListTile(
              title: DropdownButton(
                items: _priority
                    .map((item) =>
                    DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                    .toList(),
                style: textStyle,
                value: _priority[1],
                onChanged: (value) =>
                    setState(() {
                      debugPrint("User selected $value");
                    }),
              ),
            ),

            // second elemenet
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) =>
                    debugPrint("Something changed in Title text field"),
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Third elemenet
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) =>
                    debugPrint(
                        "Something changed in Description text field"),
                decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                        child: Text("Save"),
                        onPressed: () => {},
                      )),
                  Container(width: 5.0),
                  Expanded(
                      child: ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () => {},
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
