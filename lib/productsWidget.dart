import 'dart:html';
import 'package:logger/logger.dart';
import 'package:string_to_color/string_to_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:studenttutorapp/components.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:studenttutorapp/coursesDetail_screen.dart';
import 'package:studenttutorapp/productsGrid_view.dart';

List<String> cNames = [];

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({super.key});
  _ProductsWidgetState createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Logger logger = Logger();
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
      child: Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: ListView(
            children: [
              Column(
                children: [
                  OpenSans(
                    text: 'Long Term Career Oriented Courses',
                    fontweight: FontWeight.bold,
                    size: 17.0,
                    color: Colors.black,
                  ),
                  SingleChildScrollView(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 0.0),
                        margin: EdgeInsets.only(left: 0.0),
                        height: 200.0,
                        width: width,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Courses')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];

                                  cNames.add(documentSnapshot['title']);
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseDetails(
                                                    productName:
                                                        documentSnapshot[
                                                            'title'],
                                                    image: documentSnapshot[
                                                        'image'],
                                                    productInfo:
                                                        documentSnapshot[
                                                            'info'],
                                                    productPrice:
                                                        documentSnapshot[
                                                            'price'],
                                                  )),
                                        );
                                        logger.d(cNames);
                                      },
                                      child: Column(
                                        children: [
                                          SlideTransitionExample(
                                            url: documentSnapshot['image'],
                                            title: documentSnapshot['title'],
                                          ),
                                        ],
                                      ));
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  OpenSans(
                    text: 'Short Term Skills Oriented Courses',
                    fontweight: FontWeight.bold,
                    size: 15.0,
                    color: Colors.black,
                  ),
                  Container(
                    height: 250.0,
                    width: width,
                    child: MyGridView(),
                  )
                ],
              ),
            ],
          )),
    );
  }
}

class SlideTransitionExample extends StatefulWidget {
  final url;

  final title;

  // final price;

//  final ratings;
  // final color;

  const SlideTransitionExample(
      {super.key,
      this.url,
      this.title /* this.price, this.ratings, this.color*/});

  @override
  State<SlideTransitionExample> createState() => _SlideTransitionExampleState();
}

class _SlideTransitionExampleState extends State<SlideTransitionExample>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //Color _color = ColorUtils.stringToColor(widget.color.toString());
    return Card(
      margin: EdgeInsets.all(5.0),
      // color: _color,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Colors.tealAccent,
        ),
      ),
      shadowColor: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Image.network(
              widget.url,
              height: 150.0,
              width: 150.0,
              fit: BoxFit.fill,
            ),
            OpenSans(
              text: widget.title,
              color: Colors.black,
              fontweight: FontWeight.bold,
              size: 15.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            /*OpenSans(
              text: widget.ratings,
              color: Colors.black,
              fontweight: FontWeight.normal,
              alignment: TextAlign.left,
            ),
            SizedBox(
              height: 5.0,
            ),
            OpenSans(
              text: widget.price,
              color: Colors.black,
              fontweight: FontWeight.bold,
              alignment: TextAlign.left,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),*/
          ],
        ),
      ),
    );
  }
}
