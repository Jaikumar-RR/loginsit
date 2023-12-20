import 'package:flutter/material.dart';

class Student {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePic;

  Student({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profilePic,
  });
}

class StudentProfilePage extends StatefulWidget {
  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  late Student student;
  bool isContactExpanded = false;
  bool isAdditionalExpanded = false;

  @override
  void initState() {
    super.initState();
    initializeStudentData();
  }

  void initializeStudentData() {
    String defaultProfilePic =
        'https://rukminim2.flixcart.com/image/850/1000/l2rwzgw0/poster/6/v/3/medium-obito-uchiha-naruto-anime-series-matte-finish-poster-original-imagefd2yuvhfaw9.jpeg?q=20'; // Placeholder image URL
    student = Student(
      name: 'John Doe',
      email: 'johndoe@example.com',
      phoneNumber: '123-456-7890',
      address: '123 Main Street, City',
      profilePic: defaultProfilePic,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Student Profile',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 95),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          student.profilePic,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  student.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 2),
              Center(
                child: Text(
                  student.email,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildExpansionTile(
                title: 'Contact Information',
                isExpanded: isContactExpanded,
                onPressed: () {
                  setState(() {
                    isContactExpanded = !isContactExpanded;
                  });
                },
                children: [
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone Number'),
                    subtitle: Text(student.phoneNumber),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Address'),
                    subtitle: Text(student.address),
                  ),
                ],
              ),
              buildExpansionTile(
                title: 'Additional Information',
                isExpanded: isAdditionalExpanded,
                onPressed: () {
                  setState(() {
                    isAdditionalExpanded = !isAdditionalExpanded;
                  });
                },
                children: [
                  ListTile(
                    title: Text('Detail 1'),
                    subtitle: Text('Some Detail Here'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Detail 2'),
                    subtitle: Text('Some Detail Here'),
                  ),
                  // Add more ListTile widgets for additional details
                ],
              ),
              buildExpansionTile(
                title: 'Additional Information',
                isExpanded: isAdditionalExpanded,
                onPressed: () {
                  setState(() {
                    isAdditionalExpanded = !isAdditionalExpanded;
                  });
                },
                children: [
                  ListTile(
                    title: Text('Detail 1'),
                    subtitle: Text('Some Detail Here'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Detail 2'),
                    subtitle: Text('Some Detail Here'),
                  ),
                  // Add more ListTile widgets for additional details
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExpansionTile({
    required String title,
    required bool isExpanded,
    required Function onPressed,
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onExpansionChanged: (value) {
            onPressed();
          },
          initiallyExpanded: isExpanded,
          children: children,
        ),
      ),
    );
  }
}
