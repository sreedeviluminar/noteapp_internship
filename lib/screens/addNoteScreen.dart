import 'package:flutter/material.dart';
import 'package:noteapp_internship/utils/appcolors.dart';

import '../utils/textConstants.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  bool isCheckListEnabled = false;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: AppTextTheme.bodyTextStyle,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your Title"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Content",
                  style: AppTextTheme.bodyTextStyle,
                ),
                TextFormField(
                  maxLines: 8,
                  decoration: InputDecoration(
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
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Add Item"),
                            ),
                          ),
                          SizedBox(
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
            onPressed: () {},
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
