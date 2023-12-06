import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginsit/StaffPages/DepartmentDetails.dart';

class Student {
  final String name;
  final String department;
  final int batchNumber;
  final List<String> skills;
  final DateTime dateOfBirth;
  final String registrationNumber;

  Student({
    required this.name,
    required this.department,
    required this.batchNumber,
    required this.skills,
    required this.dateOfBirth,
    required this.registrationNumber,
  });
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final List<Student> allStudents = [
    Student(
      name: 'John Doe',
      department: 'Computer Science',
      batchNumber: 2022,
      skills: ['Flutter', 'Dart', 'UI/UX'],
      dateOfBirth: DateTime(2000, 10, 15),
      registrationNumber: 'REG001',
    ),
    Student(
      name: 'Alice Johnson',
      department: 'Computer Science',
      batchNumber: 2023,
      skills: ['Python', 'Java', 'Web Development'],
      dateOfBirth: DateTime(2001, 5, 20),
      registrationNumber: 'REG002',
    ),
    Student(
      name: 'Emily Davis',
      department: 'Electrical Engineering',
      batchNumber: 2022,
      skills: ['C', 'Embedded Systems', 'Signal Processing'],
      dateOfBirth: DateTime(2000, 8, 7),
      registrationNumber: 'REG003',
    ),
    Student(
      name: 'Mike Williams',
      department: 'Electrical Engineering',
      batchNumber: 2023,
      skills: ['MATLAB', 'Power Systems', 'Renewable Energy'],
      dateOfBirth: DateTime(2001, 2, 18),
      registrationNumber: 'REG004',
    ),
    Student(
      name: 'Sarah Garcia',
      department: 'CSD',
      batchNumber: 2023,
      skills: ['C++', 'Cybersecurity', 'Networking'],
      dateOfBirth: DateTime(2001, 11, 30),
      registrationNumber: 'REG005',
    ),
    // Add more students here...
  ];

  List<String> departments = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    departments =
        allStudents.map((student) => student.department).toSet().toList();
  }

  void filterStudentsByDepartment(String selectedDepartment) {
    final List<Student> filteredStudents = allStudents
        .where((student) => student.department == selectedDepartment)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DepartmentDetailsPage(
          department: selectedDepartment,
          students: filteredStudents,
        ),
      ),
    );
  }

  List<String> getFilteredDepartments() {
    if (searchText.isEmpty) {
      return departments;
    } else {
      return departments
          .where(
              (dept) => dept.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF536DFE), Color(0xFF1E88E5)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 60, 24, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departments',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey[600]),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchText = value;
                                      });
                                    },
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Search departments...',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getFilteredDepartments().length,
                        itemBuilder: (context, index) {
                          final department = getFilteredDepartments()[index];
                          return GestureDetector(
                            onTap: () {
                              filterStudentsByDepartment(department);
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      department,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios, size: 18),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
