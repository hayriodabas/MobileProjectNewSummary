import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutterfire/core/model/projects.dart';
import 'package:flutterfire/core/model/user/user_auth_error.dart';
import 'package:flutterfire/core/model/user/user_request.dart';
import 'package:http/http.dart' as http;

import '../model/student.dart';
import '../model/user.dart';

class FirebaseService {
  // static const String FIREBASE_URL = "https://hwafire-4cae8.firebaseio.com";
  static const String FIREBASE_URL = "https://mobileprojectsummary.firebaseio.com/projects";
  static const String FIREBASE_AUTH_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[YOUR_API_KEY]";
    static String a ="";

  var projectListGlobal = List<Projects>();
  var projectListHistoryGlobal = List<Projects>();
  Future postUser(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response = await http.post(FIREBASE_AUTH_URL, body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = FirebaseAuthError.fromJson(errorJson);
        return error;
    }
  } 
  static int weekOfYear(DateTime date) {
    DateTime monday = weekStart(date);
    DateTime first = weekYearStartDate(monday.year);

    int week = 1 + (monday.difference(first).inDays / 7).floor();

    if (week == 53 && DateTime(monday.year, 12, 31).weekday < 4)
      week = 1;
    debugPrint(week.toString());
    return week;
  }

  static DateTime weekStart(DateTime date) {
    // This is ugly, but to avoid problems with daylight saving
    DateTime monday = DateTime.utc(date.year, date.month, date.day);
    monday = monday.subtract(Duration(days: monday.weekday - 1));

    return monday;
  }

  static DateTime weekEnd(DateTime date) {
    // This is ugly, but to avoid problems with daylight saving
    // Set the last microsecond to really be the end of the week
    DateTime sunday = DateTime.utc(date.year, date.month, date.day, 23, 59, 59, 999, 999999);
    sunday = sunday.add(Duration(days: 7 - sunday.weekday));

    return sunday;
  }

  static DateTime weekYearStartDate(int year) {
    final firstDayOfYear = DateTime.utc(year, 1, 1);
    final dayOfWeek = firstDayOfYear.weekday;

    return firstDayOfYear.add(Duration(days: (dayOfWeek <= DateTime.thursday ? 1 : 8) - dayOfWeek));
  }
//list
  Future<List<Projects>> getProjects() async {
    // final response = await http.get("$FIREBASE_URL/users.json");
    final response = await http.get("$FIREBASE_URL/projectMap.json");

    final response2 = await http.get("$FIREBASE_URL/UpdateTime.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
      final jsonModel = json.decode(response.body) as Map;
        final projectList = List<Projects>();
        final projectListHistory = List<Projects>();
        jsonModel.forEach((key, value) {
          
          Projects project = Projects.fromJson(value);
          project.key = key;
          project.updateTime= response2.body;
          if(project.week== weekOfYear(DateTime.now()).toString()){
            String temp = value.toString();
             debugPrint(temp); 
            
            projectList.add(project);

          }
          else{
            projectListHistory.add(project);
          }
        });

        // final jsonModel = json.decode(response.body);
        // // final userList = jsonModel
        // //     .map((e) => User.fromJson(e as Map<String, dynamic>))
        // //     .toList()
        // //     .cast<User>();
        // final projectList = jsonModel
        //     .map((e) => Projects.fromJson(e as Map<String, dynamic>))
        //     .toList()
        //     .cast<Projects>();
      projectListGlobal = projectList;
      projectListHistoryGlobal = projectListHistory;

      return projectList;
        // return userList;
      default:
        return Future.error(response.statusCode);
    }
  }
//list
  Future<List<Projects>> getProjectsForWeek(int index1) async {
    // final response = await http.get("$FIREBASE_URL/users.json");
    final response = await http.get("$FIREBASE_URL/projectMap.json");


    switch (response.statusCode) {
      case HttpStatus.ok:
      final jsonModel = json.decode(response.body) as Map;
        final projectList = List<Projects>();
        final projectListHistory = List<Projects>();
        jsonModel.forEach((key, value) {
          
          Projects project = Projects.fromJson(value);
          project.key = key;
          if(project.week== index1.toString()){
              String temp = value.toString();
             debugPrint(temp); 
              projectList.add(project);
          }
        });

        // final jsonModel = json.decode(response.body);
        // // final userList = jsonModel
        // //     .map((e) => User.fromJson(e as Map<String, dynamic>))
        // //     .toList()
        // //     .cast<User>();
        // final projectList = jsonModel
        //     .map((e) => Projects.fromJson(e as Map<String, dynamic>))
        //     .toList()
        //     .cast<Projects>();
      projectListGlobal = projectList;
      projectListHistoryGlobal = projectListHistory;

      return projectList;
        // return userList;
      default:
        return Future.error(response.statusCode);
    }
  }


//list
  Future<List<User>> getUsers() async {
    final response = await http.get("$FIREBASE_URL/users.json");
    //final response = await http.get("$FIREBASE_URL/project.json");


    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<User>();
        // final projectList = jsonModel
        //     .map((e) => Projects.fromJson(e as Map<String, dynamic>))
        //     .toList()
        //     .cast<Projects>();
      // return projectList;
        return userList;
      default:
        return Future.error(response.statusCode);
    }
  }

//map
  Future<List<Student>> getStudents() async {
    final response = await http.get("$FIREBASE_URL/students.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        final studentList = List<Student>();

        jsonModel.forEach((key, value) {
          Student student = Student.fromJson(value);
          student.key = key;
          studentList.add(student);
        });

        // final projectList = List<Projects>();

        // jsonModel.forEach((key, value) {
        //   Projects project = Projects.fromJson(value);
        //   project.key = key;
        //   projectList.add(project);
        // });
        // return projectList;
        return studentList;

      default:
        return Future.error(response.statusCode);
    }
  }
}
