import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/note.dart';
import '../../utils/database_helper.dart';

class NoteDetail extends StatefulWidget {
  NoteDetail(this.note, this.appBarTitle, {Key? key}) : super(key: key);

  Note note;
  String appBarTitle = "";

  @override
  _NoteDetailState createState() =>
      _NoteDetailState(this.note, this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  static final _priority = ["High", "low"];

  DatabaseHelper dbHelper = DatabaseHelper();
  Note note;
  String appBarTitle = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                // first element
                ListTile(
                  title: DropdownButton(
                    items: _priority
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    style: textStyle,
                    value: getPriorityAsString(note.priority),
                    onChanged: (String? value) {
                      setState(() {
                        debugPrint("User selected $value");
                        updatePriorityAsInt(value!);
                      });
                    },
                  ),
                ),

                // second elemenet
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something changed in Title text field");
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Third elemenet
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something changed in Description text field $value");
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Fourth Element
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: ElevatedButton(
                        child: const Text("Save"),
                        onPressed: () => _save(),
                      )),
                      Container(width: 5.0),
                      Expanded(
                          child: ElevatedButton(
                        child: Text(appBarTitle == "Add Note" ? "Cancel" : "Delete"),
                        onPressed: () => _delete(),
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
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case "High":
        note.priority = 1;
        break;
      case "Low": default:
        note.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String? priority;
    switch (value) {
      case 1:
        priority = _priority[0]; // High
        break;
      case 2:
        priority = _priority[1]; // Low
        break;
    }
    return priority!;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (note.id > 0) {
      // Update operation
      result = await dbHelper.updateNote(note);
    } else {
      // Insert Operation
      result = await dbHelper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog("Status", "Note Saved Successfully");
    } else {
      _showAlertDialog("Status", "Problem Saving Note");
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Delete for New Note
    if (note.id == 0) {
      _showAlertDialog("Status", "No Note was deleted");
      return;
    }

    // Delete for Old Note
    int result = await dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog("Status", "Note Deleted Successfully");
    } else {
      _showAlertDialog("Status", "Error Occured whilte Deleting Note");
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
