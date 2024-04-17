import 'package:flutter/material.dart';
import 'package:noteapp_internship/screens/home_note.dart';
import 'package:noteapp_internship/utils/appcolors.dart';

import '../utils/textConstants.dart';

class AddNoteScreen extends StatefulWidget {
  /// create a initial state or mutable state of this screen
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  ///used to fetch values from textfield
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _addItemController = TextEditingController();

  ///list is to store data from add item field as list
  List<String> checkListItems = [];

  /// to fetch state of checklist item
  List<bool> _isChecked = [];
  bool isCheckListEnabled = false;

  ///to monitor the state of this form which is valid or not
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.basicTheme,
        title: Text("Add Your Notes", style: AppTextTheme.appBarTextStyle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: AppTextTheme.bodyTextStyle,
                ),
                TextFormField(
                  validator: (title) {
                    if (title!.isEmpty) {
                      return "Please Enter a Title.";
                    } else {
                      return null;
                    }
                  },
                  controller: _titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your Title"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Content",
                  style: AppTextTheme.bodyTextStyle,
                ),
                TextFormField(
                  controller: _contentController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your Content"),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: isCheckListEnabled,
                        onChanged: (value) {
                          setState(() {
                            isCheckListEnabled = value!;
                          });
                        }),
                    Text(
                      "Create CheckList",
                      style: AppTextTheme.bodyTextStyle,
                    )
                  ],
                ),
                if (isCheckListEnabled == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _addItemController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Add Item"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: AppColor.basicTheme,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: AppColor.headTextTheme,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          backgroundColor: AppColor.basicTheme,
          onPressed: () {
            var valid = formkey.currentState!.validate();
            if (valid == true) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NoteHome()));
            }
          },
          label: Text(
            "Add Note",
            style: AppTextTheme.appBarTextStyle,
          ),
          icon: Icon(
            Icons.note_add_outlined,
            size: 20,
            color: AppColor.headTextTheme,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
