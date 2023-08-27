import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:studenttutorapp/addCourses.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/courseMaterial.dart';
import 'video_player.dart';

String courseName = '';
String videoLink = '';
String videotitle = '';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool isLoadingV = false;
  Map<String, dynamic>? userMapV;
  Logger logger = Logger();

  @override
  void initState() {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoadingV = true;
    });
    _fireStore
        .collection('StudentsInfo')
        .where('Course', isEqualTo: title.toString())
        .get()
        .then((value) {
      setState(() {
        userMapV = value.docs[0].data();
        isLoadingV = false;
        courseName = userMapV!['Course'];
      });
      print(userMapV!['Course']);
    });
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('AI');
    Future<void> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      print(allData);
    }

    super.initState();
  }

  ensureFlutterViewEmbedderInitialized() {}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    logger.d(courseName);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("SP Videos"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
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
          child: Column(
            children: [
              OpenSans(
                text:
                    "If Any Error Occcured Plase Go One Step Back And Come Again",
                size: 10.0,
                fontweight: FontWeight.bold,
                color: Colors.black,
              ),
              Container(
                height: 100,
                width: width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('CourseVideos')
                      .doc('Videos')
                      .collection('$courseName')
                      .snapshots(),
                  builder: (context, snapshot) {
                    logger.d(courseName);
                    if (snapshot.hasData) {
                      return Container(
                        height: 100.0,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];
                                  logger.d(documentSnapshot['videolink']);

                                  videoLink = documentSnapshot['videolink'];

                                  logger.d(videoLink);
                                  return OpenSans(
                                    text: documentSnapshot['videotitle'],
                                    size: 15.0,
                                    fontweight: FontWeight.bold,
                                    color: Colors.black,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Container(
                width: width,
                height: 400.0,
                child: YoutubeVideo(videoLink.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
