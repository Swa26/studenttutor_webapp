import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/coursesDetail_screen.dart';
import 'package:studenttutorapp/productsWidget.dart';
//import 'package:studenttutorapp/tutor_homeView.dart';

String dropdownValue = cNames.first;

class AddAssignments extends StatefulWidget {
  const AddAssignments({super.key});
  _AddAssignmentsState createState() => _AddAssignmentsState();
}

TextEditingController _assgnName = TextEditingController();
TextEditingController _assgnLastDate = TextEditingController();
TextEditingController _assgnInfo = TextEditingController();
TextEditingController _assgnImageLink = TextEditingController();
TextEditingController _assgnCourse = TextEditingController();
String info = "";
String name = "";
String imageLink = "";
String date = "";
String course = "";

class _AddAssignmentsState extends State<AddAssignments> {
  //FirebaseFirestore _firebase = FirebaseFirestore.instance;

  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    print(cNames);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Tata Digital Tutor'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffedccee),
              Color(0xffcceeed),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextForm(
                    text: "Assignment Title",
                    containerWidhth: width / 1.5,
                    controller: _assgnName,
                    onChanged: (text) {
                      name = _assgnName.text.capitalize();
                    },
                    hinttext: "Please Enter Assignment Name",
                    validator: (text) {
                      if (text.toString().isEmpty) {
                        return "Field Should Not Be Empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextForm(
                    text: "Problem Statement",
                    containerWidhth: width / 1.5,
                    controller: _assgnInfo,
                    onChanged: (text) {
                      info = _assgnInfo.text;
                    },
                    hinttext: "Please Enter Details",
                    validator: (text) {
                      if (text.toString().isEmpty) {
                        return "Field Should Not Be Empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextForm(
                    text: "Last Date",
                    containerWidhth: width / 1.5,
                    controller: _assgnLastDate,
                    onChanged: (text) {
                      date = _assgnLastDate.text;
                    },
                    hinttext: "Last Date",
                    validator: (text) {
                      if (text.toString().isEmpty) {
                        return "Field Should Not Be Empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextForm(
                    text: "Image Link If Any",
                    containerWidhth: width / 1.5,
                    controller: _assgnImageLink,
                    onChanged: (text) {
                      imageLink = _assgnImageLink.text;
                    },
                    hinttext: "Please Enter Course Info",
                    validator: null,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextForm(
                    text: "Course Name",
                    containerWidhth: width / 1.5,
                    controller: _assgnCourse,
                    onChanged: (text) {
                      course = _assgnCourse.text.capitalize();
                    },
                    hinttext: "AI,Block Chain, Cyber Security",
                    validator: (text) {
                      if (text.toString().isEmpty) {
                        return "Field Should Not Be Empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final addData = AddDataFireStore1();
                      if (formkey.currentState!.validate()) {
                        if (await addData.addResponse(
                            imageLink, info, date, name, course)) {
                          formkey.currentState!.reset();
                          await DialogBox(
                              context, 'Assignment Added Sucessfully');
                        } else {
                          DialogBox(context,
                              'Please Check Validations and Fill Again');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffedccee),
                    ),
                    child: Text(
                      'Create Assignment',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class AddDataFireStore1 {
  CollectionReference respose =
      FirebaseFirestore.instance.collection('NewAssignments');
  Future addResponse(
    final clink,
    final cinfo,
    final cdate,
    final cname,
    final ccourse,
  ) async {
    return respose
        .add({
          'image': clink,
          'info': cinfo,
          'lastdate': cdate,
          'title': cname,
          'course': ccourse
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}
