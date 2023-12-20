import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginsit/Backend/models/student_model.dart';

class StudentDetailsPage extends StatelessWidget {
  final Student student;

  StudentDetailsPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          student.name + " Details",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.download,
              color: Colors.black,
            ),
            onPressed: () {
              // Add your download functionality here
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {
              // Add your share functionality here
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(
              'Name',
              student.name,
              icon: Icons.person,
              iconColor: Colors.blue,
            ),
            SizedBox(height: 12.0),
            _buildDetailCard(
              'Department',
              student.department,
              icon: Icons.business,
              iconColor: Colors.orange,
            ),
            SizedBox(height: 12.0),
            _buildDetailCard(
              'Registration Number',
              student.registerNumber.toString(),
              icon: Icons.confirmation_number,
              iconColor: Colors.green,
            ),
            SizedBox(height: 12.0),
            _buildDetailCard(
              'Batch Number',
              student.batchNumber.toString(),
              icon: Icons.format_list_numbered,
              iconColor: Colors.purple,
            ),
            SizedBox(height: 12.0),
            _buildSkillsSection(student.skills),
            // Add more sections or details here...
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value,
      {required IconData icon, required Color iconColor}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.blue.withOpacity(0.1)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection(List<dynamic> skills) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.blue.withOpacity(0.1)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: skills
                  .map((skill) => Chip(
                        label: Text(
                          skill,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
