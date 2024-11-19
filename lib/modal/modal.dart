import 'package:flutter/material.dart';

class AttendanceModal
{
  String name,date;
  String present;

  AttendanceModal ({required this.name,required this.date,required this.present});

  factory AttendanceModal.fromMap(Map m1)
  {
    return AttendanceModal(name: m1['name'], date: m1['date'], present: m1['present']);
  }
}

Map toMap (AttendanceModal Attendance)
{
  return{
     'name' : Attendance.name,
     'date' : Attendance.date,
     'present' : Attendance.present,
  };
}