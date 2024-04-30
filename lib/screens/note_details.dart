import 'package:flutter/material.dart';
import 'package:noteapp_internship/model/note.dart';
import 'package:noteapp_internship/screens/addNoteScreen.dart';
import 'package:noteapp_internship/utils/appcolors.dart';
import 'package:noteapp_internship/utils/textConstants.dart';

class NoteDetails extends StatefulWidget {
  final Note note;
  final Function(int) onDelete;

  const NoteDetails({Key? key, required this.note, required this.onDelete}) : super(key: key);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late List<bool> isChecked;

  @override
  void initState() {
    isChecked = widget.note.isCheckedList ??
        List<bool>.filled(widget.note.isCheckedList?.length ?? 0, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.basicTheme,
        title: Text(
          widget.note.title!,
          style: AppTextTheme.appBarTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _navigateToEditScreen();
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.75),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
            image: AssetImage("assets/images/back.jpg"),
          ),
        ),
        child: ListView(
          children: [
            Text(
              widget.note.content!,
              style: AppTextTheme.bodyTextStyle,
            ),
            const SizedBox(height: 15),
            if (widget.note.checkList != null &&
                widget.note.checkList!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CheckList : ",
                    style: AppTextTheme.bodyTextStyle,
                  ),
                  Divider(
                    color: AppColor.basicTheme,
                    thickness: 3,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.note.checkList!.length,
                    itemBuilder: (context, index) {
                      final item = widget.note.checkList![index];
                      return CheckboxListTile(
                        checkColor: AppColor.basicTheme,
                        activeColor: Colors.white,
                        title: Text(
                          item,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColor.basicTheme,
                            decoration: isChecked[index]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        value: isChecked[index],
                        onChanged: (value) {
                          setState(() {
                            isChecked[index] = value!;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.basicTheme,
        onPressed: () {
          _deleteNote();
        },
        child: Icon(Icons.delete,color: Colors.white,),
      ),
    );
  }

  void _navigateToEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNoteScreen(note: widget.note),
      ),
    ).then((updatedNote) {
      if (updatedNote != null) {
        setState(() {
          widget.note.title = updatedNote.title;
          widget.note.content = updatedNote.content;
          widget.note.checkList = updatedNote.checkList;
          widget.note.isCheckedList = updatedNote.isCheckedList ?? [];
          isChecked = List<bool>.filled(
            widget.note.checkList!.length,
            false,
          );
        });
      }
    });
  }

  void _deleteNote() {
    widget.onDelete(widget.note.id!);
    Navigator.pop(context); // Navigate back to the home page after deletion
  }
}
