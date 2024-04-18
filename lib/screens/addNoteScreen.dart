import 'package:flutter/material.dart';
import 'package:noteapp_internship/model/note.dart';
import 'package:noteapp_internship/utils/appcolors.dart';
import 'package:noteapp_internship/utils/snackbar.dart';

import '../database/db.dart';
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
                                onPressed: () {
                                  ///fetch value from add item controller
                                  _addCheckListItem(_addItemController.text);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: AppColor.headTextTheme,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ListView.builder(
                    shrinkWrap: true,
                    /// total length of list
                    itemCount: checkListItems.length,
                    itemBuilder: (context, index) {
                      ///each item in the list stored in 'item'
                      final item = checkListItems[index];
                      return ListTile(
                        title: Text(item,style: AppTextTheme.bodyTextStyle,),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                checkListItems.removeAt(index);
                                _isChecked.removeAt(index);
                              });
                            },
                            icon: Icon(
                              size: 25,
                              Icons.delete,
                              color: AppColor.basicTheme,
                            )),
                      );
                    })
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
              ///read all the datas from fileds and store it to title content checklist and ischecked
              String title = _titleController.text;
              String content = _contentController.text;
              final checklist =
                  checkListItems.isNotEmpty ? checkListItems : null;
              final checked = _isChecked.isNotEmpty ? _isChecked : null;

              /// pass the data from ui to model
              final note = Note(
                  title: title,
                  content: content,
                  checkList: checklist,
                  isCheckedList: checked);

              /// add note to hive db
              final id = HiveDb.addNote(note);

              if (id != null) {
                successSnackBar(context);
                Navigator.pop(context);
              }else{
                errorSnackBar(context);
              }
            } else {
              warningSnackBar(context);
            }
            _titleController.clear();
            _contentController.clear();
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

  void _addCheckListItem(String checkListItem) {
    setState(() {
      if (checkListItem.trim().isNotEmpty) {
        ///add the value that we entered in add item field to the list
        checkListItems.add(checkListItem.trim());
        _isChecked.add(false);

        ///clear textfield after adding an item
        _addItemController.clear();
      }
    });
  }
}
