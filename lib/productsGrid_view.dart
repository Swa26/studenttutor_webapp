import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_to_color/string_to_color.dart';
import 'package:studenttutorapp/components.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:studenttutorapp/coursesDetail_screen.dart';

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenTypeLayout(
      mobile: _buildGridView(2), // 2 items per row on mobile
      tablet: _buildGridView(3), // 3 items per row on tablet
      desktop: _buildGridView(6), // 6 items per row on desktop
    ));
  }

  Widget _buildGridView(int crossAxisCount) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ShortCourses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
            ),
            itemCount: snapshot.data!.docs.length,
            // Total number of items
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              //final color = documentSnapshot['color'];
              // Color _color = ColorUtils.stringToColor(color.toString());

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CourseDetails(
                              productName: documentSnapshot['title'],
                              image: documentSnapshot['image'],
                              productInfo: documentSnapshot['info'],
                              productPrice: documentSnapshot['price'],
                            )),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          documentSnapshot['image'],
                          height: 200.0,
                          width: 200.0,
                        ),
                      ),
                      OpenSans(
                        text: documentSnapshot['title'],
                        color: Colors.black,
                        fontweight: FontWeight.bold,
                        size: 14.0,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
} /**/
