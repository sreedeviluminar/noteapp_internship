import 'package:flutter/material.dart';
import 'package:noteapp_internship/model/note.dart';
import 'package:noteapp_internship/utils/appcolors.dart';
import 'package:noteapp_internship/utils/textConstants.dart';

class NoteDetails extends StatefulWidget {
  final Note note;

  const NoteDetails({super.key, required this.note});

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
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.75), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: const AssetImage("assets/images/back.jpg"))),
        child: ListView(
          children: [
            Text(
              widget.note.content!,
              style: AppTextTheme.bodyTextStyle,
            ),
            const SizedBox(
              height: 15,
            ),
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
                                      : TextDecoration.none),
                            ),
                            value: isChecked[index],
                            onChanged: (value) {
                              setState(() {
                                isChecked[index]=value!;
                              });
                            });
                      })
                ],
              )
          ],
        ),
      ),
    );
  }
}
