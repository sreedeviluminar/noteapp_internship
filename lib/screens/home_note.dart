import 'package:flutter/material.dart';
import 'package:noteapp_internship/screens/addNoteScreen.dart';
import 'package:noteapp_internship/utils/appcolors.dart';
import 'package:noteapp_internship/utils/textConstants.dart';

class NoteHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.basicTheme,
        title: Text("My Notes 📋", style: AppTextTheme.appBarTextStyle),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.basicTheme,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        child: Icon(
          Icons.note_alt_outlined,
          color: AppColor.headTextTheme,
          size: 30,
        ),
      ),
    );
  }
}
