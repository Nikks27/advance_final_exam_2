
import 'package:flutter/widgets.dart';

import '../DB Helper/db_helper.dart';

class AttendanceProvider extends ChangeNotifier {

  var txtname = TextEditingController();
  var txtdate = TextEditingController();
  var txtpresent = TextEditingController();
  List AttendenceList = [];
  int id = 0;

  void initDatabase() {
    DatabaseHelper.databaseHelper.initDatabase();
  }

  void insertDatabase(
      {required int id,
        required String name,
        required String date,
        required String present}) {
    DatabaseHelper.databaseHelper.addAttendanceDatabase(id, name, date, present);
    // DatabaseHelper.databaseHelper.addAttendanceDatabase(id: id, name: name, author: date, status: present);
  }


  Future<void> updateData(
      {required int id,
        required String name ,
        required String date,
        required String present}) async {
    await DatabaseHelper.databaseHelper.updateAttendance(id, name, date, present);
  }

  Future<void> deleteData({required int id}) async {
    await DatabaseHelper.databaseHelper.deleteAttendance(id);
  }

  Future<List> readData() async {
    AttendenceList = await DatabaseHelper.databaseHelper.readAllAttendance();
    notifyListeners();
    return AttendenceList;
  }

  void clearAll() {
    txtname.clear();
    txtdate.clear();
    txtpresent.clear();
    notifyListeners();
  }

  AttendanceProvider()
  {
    initDatabase();
  }
}
