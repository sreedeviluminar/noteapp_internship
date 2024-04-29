import 'package:hive/hive.dart';
import 'package:noteapp_internship/model/note.dart';


///Future async shows that this function will work in future
///await to wait until the particular operation is completed
/// my_notes - name of  hive box n

class HiveDb {
  static Future<int?> addNote(Note note) async {
    int id = await Hive.box<Note>('my_notes').add(note);
    return id;
  }


}
