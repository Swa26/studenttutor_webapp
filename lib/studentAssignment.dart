import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/coursesDetail_screen.dart';
import 'package:studenttutorapp/home_view.dart';
import 'package:studenttutorapp/productsWidget.dart';
import 'package:studenttutorapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class StudentAssignments extends StatelessWidget {
  const StudentAssignments({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Tata Digital'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('NewAssignments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];

                      if (documentSnapshot['image'] != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              documentSnapshot['image'],
                              height: 200.0,
                              width: width / 2,
                            ),
                            const SizedBox(height: 10.0),
                            OpenSans(
                              text: 'Assignment: ${documentSnapshot['title']}',
                              fontweight: FontWeight.bold,
                              size: 15.0,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                            OpenSans(
                              text: 'Detail: ${documentSnapshot['info']}',
                              fontweight: FontWeight.bold,
                              size: 15.0,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                            OpenSans(
                              text:
                                  'Last Date: ${documentSnapshot['lastdate']}',
                              fontweight: FontWeight.bold,
                              size: 15.0,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              onPressed: () => ShowDialogForSubmission(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffedccee),
                              ),
                              child: Text(
                                'Submit Now',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            OpenSans(
                              text: 'Assignment: ${documentSnapshot['title']}',
                              fontweight: FontWeight.bold,
                              size: 15.0,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                            OpenSans(
                              text: 'Detail: ${documentSnapshot['info']}',
                              fontweight: FontWeight.bold,
                              size: 15.0,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                            OpenSans(
                              text:
                                  'Last Date: ${documentSnapshot['lastdate']}',
                              fontweight: FontWeight.bold,
                              size: 15.0,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              onPressed: () => ShowDialogForSubmission(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffedccee),
                              ),
                              child: Text(
                                'Submit Now',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )),
    );
  }
}

TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _link = TextEditingController();
TextEditingController _course = TextEditingController();
ShowDialogForSubmission(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: width / 1.5,
        child: AlertDialog(
          title: const Text('Enter Details'),
          content: Form(
            key: formkey,
            child: Column(
              children: [
                TextForm(
                  text: "Assignment Name",
                  containerWidhth: width / 2,
                  hinttext: "Assignment Name",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 5) {
                      return "Please Enter Valid Name";
                    }
                  },
                  controller: _name,
                ),
                TextForm(
                  text: "Link",
                  containerWidhth: width / 2,
                  hinttext: "Paste any GitHub/PDF Link",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 8) {
                      return "Please Enter Valid Link";
                    }
                  },
                  controller: _link,
                ),
                TextForm(
                  text: "Student Email",
                  containerWidhth: width / 2,
                  hinttext: "Enter Your Registered Email",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty ||
                        !text.toString().contains('@gmail.com')) {
                      return "Please Enter Valid Email";
                    }
                  },
                  controller: _email,
                ),
                TextForm(
                  text: "Course Name",
                  containerWidhth: width / 2,
                  hinttext: "Your Course Name",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty) {
                      return "Please Enter Valid Course";
                    }
                  },
                  controller: _course,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final addData = AddDataFireStoreLink();
                if (formkey.currentState!.validate()) {
                  if (await addData.addResponse(
                      _name.text, _email.text, _link.text, _course.text)) {
                    formkey.currentState!.reset();
                    Navigator.of(context).pop();
                  } else {
                    DialogBox(
                        context, 'Please Check Validations and Fill Again');
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      );
    },
  );
}

class AddDataFireStoreLink {
  CollectionReference respose =
      FirebaseFirestore.instance.collection('StudentsInfo');
  Future addResponse(
    final name,
    final email,
    final link,
    final courseName,
  ) async {
    return respose
        .add({
          'Assignment Name': name,
          'Student Email': email,
          'Link': link,
          'Course': courseName,
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}
