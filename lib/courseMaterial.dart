import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:studenttutorapp/chatscreen.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/main.dart';
import 'package:studenttutorapp/productsWidget.dart';
import 'package:studenttutorapp/studentAssignment.dart';
import 'package:studenttutorapp/video_player.dart';
import 'package:studenttutorapp/videos.dart';

String courseName = '';
String imagelink = '';
String title = '';

class CourseMaterial extends StatefulWidget {
  const CourseMaterial({super.key});
  _CourseMaterialState createState() => _CourseMaterialState();
}

class _CourseMaterialState extends State<CourseMaterial> {
  bool isLoading = false;
  Map<String, dynamic>? userMapC;

  Logger logger = Logger();

  @override
  void initState() {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    _fireStore
        .collection('StudentsInfo')
        .where('Email', isEqualTo: username.toString())
        .get()
        .then((value) {
      setState(() {
        userMapC = value.docs[0].data();
        isLoading = false;
      });
      print(userMapC!['Course']);
      courseName = userMapC!['Course'];

      //print(courseName);
      var document =
          FirebaseFirestore.instance.collection('Courses').doc(courseName);

      document.get().then((document) {
        setState(() {
          title = document['title'];
          imagelink = document['image'];
        });

        print(document['image']);
      });
    });

    //fetchdocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    logger.d(imagelink);
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  Image.network(
                    imagelink,
                    width: width / 2,
                    height: height / 3,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  OpenSans(
                    text: title,
                    color: Colors.black,
                    fontweight: FontWeight.bold,
                    size: 20.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          color: Color(0xffcceeed),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VideoPage(),
                            ));
                          },
                          child: OpenSans(
                            text: 'SelfPaced Lectures',
                            color: Colors.black,
                            size: 15.0,
                            fontweight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "OR",
                        style: GoogleFonts.pacifico(fontSize: 14.0),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      MaterialButton(
                        color: Color(0xffcceeed),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StudentAssignments(),
                          ));
                        },
                        child: OpenSans(
                          text: 'Assignments',
                          color: Colors.black,
                          size: 15.0,
                          fontweight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffedccee),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ),
          );
        },
        child: Icon(
          Icons.chat,
          color: Colors.black,
        ),
      ),
    );
  }
}

/*Future<void> fetchdocument() async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('Courses')
      .doc('$courseName')
      .get();

  if (documentSnapshot.exists) {
    return print(documentSnapshot.data());
  } else {
    return print("Document no exist");
  }
}*/
