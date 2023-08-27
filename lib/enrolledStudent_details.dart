import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:studenttutorapp/components.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    int count;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Tata Digital Tutor'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffedccee),
                Color(0xffcceeed),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('StudentsInfo')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    count = index + 1;
                    return ListTile(
                      leading: CircleAvatar(child: Text(count.toString())),
                      title: Text(documentSnapshot['Name']),
                      subtitle: Text(documentSnapshot['Email']),
                      trailing: Text(documentSnapshot['Course']),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}

class StudentDetailFetch extends StatelessWidget {
  final String studentName;
  final String email;
  final String phone;
  final String course;
  const StudentDetailFetch({
    super.key,
    required this.studentName,
    required this.email,
    required this.phone,
    required this.course,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffedccee),
            Color(0xffcceeed),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OpenSans(
                  text: 'Name: $studentName',
                  fontweight: FontWeight.bold,
                  size: 15.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.0,
                ),
                OpenSans(
                  text: 'Email: $email',
                  fontweight: FontWeight.bold,
                  size: 10.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.0,
                ),
                OpenSans(
                  text: 'Number: $phone',
                  fontweight: FontWeight.normal,
                  size: 10.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.0,
                ),
                OpenSans(
                  text: 'Course: $course',
                  fontweight: FontWeight.bold,
                  size: 10.0,
                  color: Colors.black,
                ),
                /* ElevatedButton(
                    onPressed: () => ShowDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffedccee),
                    ),
                    child: Text(
                      'Enroll Now',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
