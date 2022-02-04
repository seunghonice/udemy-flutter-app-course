import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter_app_course/utils/database_helper.dart';

import '../../models/note.dart';
import 'note_detail.dart';

class NoteKeeper extends StatefulWidget {
  const NoteKeeper({Key? key}) : super(key: key);

  @override
  _NoteKeeperState createState() => _NoteKeeperState();
}

class _NoteKeeperState extends State<NoteKeeper> {
  int count = 0;

  List<Note> noteList = <Note>[];
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteKeeper"),
      ),
      body: Container(
        child: getNoteListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB clicked");
          _navigateToDetail(Note("", "", 2, ""), "Add Note");
        },
        tooltip: "Add Note",
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getPriorityColor(noteList[position].priority),
                child: getPriorityIcon(noteList[position].priority),
              ),
              title: Text(noteList[position].title, style: titleStyle),
              subtitle: Text(noteList[position].date),
              trailing: GestureDetector(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, noteList[position]);
                  }),
              onTap: () {
                debugPrint("ListTile Tapped");
                _navigateToDetail(noteList[position], "Edit Note");
              },
            ),
          );
        });
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.play_arrow);
      case 2:
      default:
        return const Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id!);

    if (result != 0) {
      _showSnackBar(context, "Note Deleted Succesffully!");
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteDetail(note, title)));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((db) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
