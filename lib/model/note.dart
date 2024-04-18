import 'package:hive/hive.dart';
part 'note.g.dart';

/// data store in the form of binary values using adapter class
/// to create adapter class we need to create the model using HiveType and HiveField
@HiveType(typeId: 0)
class Note {
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? content;
  @HiveField(3)
  List<String>? checkList;
  @HiveField(4)
  List<bool>? isCheckedList;
  @HiveField(5)
  int? id; /// this is to identify each not uniquely

  Note({required this.title, this.content, this.checkList, this.isCheckedList}) {
    id = DateTime.now().microsecondsSinceEpoch;
  }
}
