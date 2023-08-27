import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/home_view.dart';
import 'package:studenttutorapp/productsWidget.dart';
import 'package:studenttutorapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

String coursename = "";

class CourseDetails extends StatefulWidget {
  final String productName;
  final String image;
  final String productInfo;
  final String productPrice;

  const CourseDetails(
      {super.key,
      required this.productName,
      required this.image,
      required this.productInfo,
      required this.productPrice});
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    coursename = widget.productName;
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    '${widget.image}',
                  ),
                  OpenSans(
                    text: widget.productName,
                    fontweight: FontWeight.bold,
                    size: 15.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  OpenSans(
                    text: 'What Is ${widget.productName}',
                    fontweight: FontWeight.bold,
                    size: 13.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  OpenSans(
                    text: widget.productInfo,
                    fontweight: FontWeight.normal,
                    size: 12.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  OpenSans(
                    text: 'Fees:${widget.productPrice}',
                    fontweight: FontWeight.bold,
                    size: 15.0,
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    onPressed: () => ShowDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffedccee),
                    ),
                    child: Text(
                      'Enroll Now',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextForm extends StatefulWidget {
  final text;
  final containerWidhth;
  final hinttext;
  final controller;
  final validator;
  final initialvalue;
  final Function(String text) onChanged;
  const TextForm(
      {super.key,
      required this.text,
      required this.containerWidhth,
      required this.hinttext,
      this.controller,
      this.validator,
      required this.onChanged,
      this.initialvalue});
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: widget.containerWidhth,
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            initialValue: widget.initialvalue,
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
              hintText: widget.hinttext,
            ),
          ),
        )
      ],
    );
  }
}
