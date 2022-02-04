import 'package:flutter/material.dart';
import 'package:udemy_flutter_app_course/widgets/notekeeper/note_list.dart';
import 'dart:async';

void main() async {
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
   * SIForm
   */
  // runApp(MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: "Calculator App",
  //     home: SIForm(),
  //   theme: ThemeData(
  //     primaryColor: Colors.amber,
  //     accentColor: Colors.amberAccent,
  //     backgroundColor: Colors.black12,
  //     buttonColor: Colors.amberAccent
  //   ),
  // ));

  /**
   * NoteKeeper
   */
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "NoteKeeper App",
    home: NoteKeeper(),
  ));


  program2();
  program1();

}

program1() {
  print("Main program1: Starts");

  printFileContent1();

  print("Main program1: Ends");
}

program2() async {
  print("Main program2: Starts");

  await printFileContent2();

  print("Main program2: Ends");
}

printFileContent1() {
  Future<String> fileContent = downloadAFile();
  fileContent.then((fileContent) =>
      print("The content of the file is --> $fileContent")
  );
}

printFileContent2() async {
  String fileContent = await downloadAFile();
  print("The content of the file is --> $fileContent");
}

Future<String> downloadAFile() {
  Future<String> result = Future.delayed(Duration(seconds: 6), () {
    return "My secret file content";
  });

  return result;
}
