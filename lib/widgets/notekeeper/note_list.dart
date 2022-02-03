import 'package:flutter/material.dart';

import 'note_detail.dart';

class NoteKeeper extends StatefulWidget {
  const NoteKeeper({Key? key}) : super(key: key);

  @override
  _NoteKeeperState createState() => _NoteKeeperState();
}

class _NoteKeeperState extends State<NoteKeeper> {
  int count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoteKeeper"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // ListView(
            //   children: [],
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB clicked");
          _navigateToDetail("Add Note");
        },
        tooltip: "Add Note",
        child: Icon(Icons.add),
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
              leading: const CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                "Dummy Title $position",
                style: titleStyle,
              ),
              subtitle: Text("Dummy Date"),
              trailing: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                _navigateToDetail("Edit Note");
              },
            ),
          );
        });
  }

  void _navigateToDetail(String title) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoteDetail(title)));
  }
}
