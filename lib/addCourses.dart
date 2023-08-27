import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/coursesDetail_screen.dart';
import 'package:studenttutorapp/tutor_homeView.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});
  _AddCourseState createState() => _AddCourseState();
}

TextEditingController _courseName = TextEditingController();
TextEditingController _courseFees = TextEditingController();
TextEditingController _courseInfo = TextEditingController();
TextEditingController _courseImageLink = TextEditingController();
String info = "";
String name = "";
String imageLink = "";
String price = "";
const List<String> list = <String>['Long Term', 'Short Term'];
String dropdownValue = list.first;

class _AddCourseState extends State<AddCourse> {
  final formkey = GlobalKey<FormState>();
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            color: Colors.black,
          ),
        ],
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
                    text: "Course Name",
                    containerWidhth: width / 1.5,
                    controller: _courseName,
                    onChanged: (text) {
                      name = _courseName.text.capitalize();
                    },
                    hinttext: "Please Enter Course Name",
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
                    text: "Course Fees",
                    containerWidhth: width / 1.5,
                    controller: _courseFees,
                    onChanged: (text) {
                      price = _courseFees.text;
                    },
                    hinttext: "Please Enter Course Fees",
                    validator: (text) {
                      if (text.toString().isEmpty ||
                          !text.toString().contains('+GST/-')) {
                        return "Amount Format Should Be 'Amount+GST/-'";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextForm(
                    text: "Image Link",
                    containerWidhth: width / 1.5,
                    controller: _courseImageLink,
                    onChanged: (text) {
                      imageLink = _courseImageLink.text;
                    },
                    hinttext: "Please Enter Course Image Link",
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
                    text: "Course Info",
                    containerWidhth: width / 1.5,
                    controller: _courseInfo,
                    onChanged: (text) {
                      info = _courseInfo.text.capitalize();
                    },
                    hinttext: "Please Enter Course Info",
                    validator: (text) {
                      if (text.toString().isEmpty) {
                        return "Field Should Not Be Empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Course Type",
                  ),
                  SizedBox(
                    width: width / 1.5,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (dropdownValue == "Long Term") {
                        final addData = AddDataFireStore1();
                        if (formkey.currentState!.validate()) {
                          if (await addData.addResponse(
                              imageLink, info, price, name)) {
                            formkey.currentState!.reset();
                            await DialogBox(
                                context, 'Course Added Sucessfully');
                          } else {
                            DialogBox(context,
                                'Please Check Validations and Fill Again');
                          }
                        }
                      } else if (dropdownValue == "Short Term") {
                        final addData1 = AddDataFireStore2();
                        if (formkey.currentState!.validate()) {
                          if (await addData1.addResponse(
                              imageLink, info, price, name)) {
                            formkey.currentState!.reset();
                            await DialogBox(
                                context, 'Course Added Sucessfully');
                          } else {
                            DialogBox(context,
                                'Please Check Validations and Fill Again');
                          }
                        }
                      } else {
                        return DialogBox(context, 'Please Select Course Type');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffedccee),
                    ),
                    child: Text(
                      'Submit',
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
      FirebaseFirestore.instance.collection('Courses');
  Future addResponse(
    final clink,
    final cinfo,
    final cfees,
    final cname,
  ) async {
    return respose
        .add({
          'image': clink,
          'info': cinfo,
          'price': cfees,
          'title': cname,
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}

class AddDataFireStore2 {
  CollectionReference respose =
      FirebaseFirestore.instance.collection('ShortCourses');
  Future addResponse(
    final slink,
    final sinfo,
    final sfees,
    final sname,
  ) async {
    return respose
        .add({
          'image': slink,
          'info': sinfo,
          'price': sfees,
          'title': sname,
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}
