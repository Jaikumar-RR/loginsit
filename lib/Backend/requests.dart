import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginsit/Backend/models/student_model.dart';
import 'package:loginsit/Backend/url_config.dart';

class Request {
  static Future<List<Student>> getAllStudents() async {
    var url = "${Config.baseurl}getall/";
    var response = await http.get(Uri.parse(url));
    List<dynamic> jsonData = jsonDecode(response.body);

    List<Student> studentsObjList = [];
    for (var object in jsonData) {
      var Student_name = object['name'];
      var Student_rollno = object['rollNumber'];
      var Student_dept = object['department'];
      var Student_batch = object['batchNumber'];
      var Student_skill = object['skills'];
      var Student_dob = object['dateOfBirth'];
      var Student_regno = object['registerNumber'];
      Student sobj = Student(
          name: Student_name,
          rollno: Student_rollno,
          department: Student_dept,
          batchNumber: Student_batch,
          skills: Student_skill,
          dateOfBirth: Student_dob,
          registerNumber: Student_regno);
      studentsObjList.add(sobj);
    }
    return studentsObjList;
  }
}

// {
//         "id": 1,
//         "name": "Mahesh",
//         "rollNumber": "21CD056",
//         "department": "CSD",
//         "batchNumber": "2023",
//         "skills": [
//             "Java",
//             "Python",
//             "Mysql"
//         ],
//         "dateOfBirth": "17-08-2004",
//         "registerNumber": "921721115027"
//     },
