import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp_internship/database/db.dart';
import 'package:noteapp_internship/screens/addNoteScreen.dart';
import 'package:noteapp_internship/screens/note_details.dart';
import 'package:noteapp_internship/utils/appcolors.dart';
import 'package:noteapp_internship/utils/textConstants.dart';

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
        body: ValueListenableBuilder<Box<Note>>(

            ///Returns a ValueListenable which notifies its listeners when an entry in the box changes
            valueListenable: Hive.box<Note>('my_notes').listenable(),
            builder: (context, box, widget) {
              ///read all the values from box as list then covert it in form of model class NOTE
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
                                  BlendMode.dstATop),
                              fit: BoxFit.cover,
                              image:
                              const AssetImage("assets/images/back.jpg")),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.edit_note),
                          title: Text(
                            "${notes[index].title}",
                            style: AppTextTheme.bodyTextStyle,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              HiveDb.deleteNote(notes[index]);
                              setState(() {
                              });
                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, animation2) {
                                    return NoteDetails(note: note);
                                  },
                                  transitionsBuilder:
                                      (context, ani1, ani2, widget) {
                                    return FadeTransition(
                                      opacity: ani1,
                                  child: widget,
                                );
                              },
                                  transitionDuration: const Duration(milliseconds: 500)
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  });
            }));
  }
}
