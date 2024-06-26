import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp_internship/screens/addNoteScreen.dart';
import 'package:noteapp_internship/screens/note_details.dart';
import 'package:noteapp_internship/utils/appcolors.dart';
import 'package:noteapp_internship/utils/textConstants.dart';
import 'package:hive/hive.dart';
import '../model/note.dart';

class NoteHome extends StatefulWidget {
  @override
  State<NoteHome> createState() => _NoteHomeState();
}
class _NoteHomeState extends State<NoteHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.basicTheme,
        title: Text(
          "My Notes 📋",
          style: AppTextTheme.appBarTextStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.basicTheme,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                AddNoteScreen()),
          );
        },
        child: Icon(
          Icons.note_alt_outlined,
          color: AppColor.headTextTheme,
          size: 30,
        ),
      ),
      ///ValueListenableBuilder listen to the changes in the box
      ///and rebuilds the body whenever an changes in box occurs
      body: ValueListenableBuilder<Box<Note>>(
        valueListenable: Hive.box<Note>('my_notes').listenable(),
        builder: (context, box, widget) {
          List<Note> notes = box.values.toList().cast<Note>();
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              var note = notes[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.dstATop,
                      ),
                      fit: BoxFit.cover,
                      image: const AssetImage("assets/images/back.jpg"),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.edit_note),
                    title: Text(
                      "${notes[index].title}",
                      style: AppTextTheme.bodyTextStyle,
                    ),
                    onTap: () {
                      _navigateToNoteDetails(note);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToNoteDetails(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetails(
          note: note,
          onDelete: _deleteNoteAtIndex,
        ),
      ),
    );
  }
  void _deleteNoteAtIndex(int id) {
    var box = Hive.box<Note>('my_notes');
    int index = box.values.toList()
        .indexWhere((note) => note.id == id);
    if (index != -1) {
      box.deleteAt(index);
      _refreshHome();
    }
  }
  void _refreshHome() {
    setState(() {});
  }
}
