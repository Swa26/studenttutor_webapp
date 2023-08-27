import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:studenttutorapp/courseMaterial.dart';
import 'package:studenttutorapp/coursesDetail_screen.dart';
import 'package:studenttutorapp/firebase_options.dart';
import 'package:studenttutorapp/main.dart';

class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontweight;
  final alignment;
  const OpenSans(
      {super.key,
      this.text,
      this.size,
      this.fontweight,
      this.color,
      this.alignment});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == null ? TextAlign.center : alignment,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color == null ? Colors.white : color,
        fontWeight: fontweight == null ? FontWeight.normal : fontweight,
      ),
    );
  }
}

DialogBox(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: const Color(0xffcceeed),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 2.0),
      ),
      title: OpenSans(
        text: title,
        size: 20.0,
        color: Colors.black,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: OpenSans(
            text: "Ok",
            size: 20.0,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}

/*class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialog with TextFormField'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showDialog(context);
          },
          child: Text('Open Dialog'),
        ),
      ),
    );
  }
*/
TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _phone = TextEditingController();
TextEditingController _course = TextEditingController();

final formkey = GlobalKey<FormState>();
ShowDialog(BuildContext context) {
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
                  text: "Name",
                  containerWidhth: width / 2,
                  hinttext: "Enter Name",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 8) {
                      return "Please Enter Valid Name";
                    }
                  },
                  controller: _name,
                ),
                TextForm(
                  text: "Email",
                  containerWidhth: width / 2,
                  onChanged: (text) => null,
                  hinttext: "Enter Email",
                  validator: (text) {
                    if (text.toString().isEmpty ||
                        !text.toString().contains("@gmail.com")) {
                      return "Please Enter Valid Email";
                    }
                  },
                  controller: _email,
                ),
                TextForm(
                  text: "Phone Number",
                  containerWidhth: width / 2,
                  onChanged: (text) => null,
                  hinttext: "Enter Phone Number",
                  validator: (text) {
                    if (text.toString().isEmpty ||
                        text.toString().length < 10) {
                      return "Please Enter Valid Number";
                    }
                  },
                  controller: _phone,
                ),
                Text('Do Not Change Course Name'),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: width / 2,
                  child: TextField(
                    controller: TextEditingController(text: coursename),
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
                  ),
                )
                /*TextForm(
                  text: "Course Name",
                  containerWidhth: width / 2,
                  onChanged: (text) => null,
                  initialvalue: coursename,
                  hinttext: "Enter Your Course Name",
                  controller: _course,
                ),*/
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
                final addData = AddDataFireStore();
                if (formkey.currentState!.validate()) {
                  if (await addData.addResponse(
                      _name.text, _email.text, _phone.text, coursename)) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CourseMaterial(),
                    ));
                    formkey.currentState!.reset();
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

//Add Data To FireStore
class AddDataFireStore {
  CollectionReference respose =
      FirebaseFirestore.instance.collection('StudentsInfo');
  Future addResponse(
    final name,
    final email,
    final number,
    final courseName,
  ) async {
    return respose
        .add({
          'Name': name,
          'Email': email,
          'Number': number,
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

//Chocolate Cakes
/*class ChocolateCakes extends StatefulWidget {
  const ChocolateCakes({super.key});
  _ChocolateCakesState createState() => _ChocolateCakesState();
}

class _ChocolateCakesState extends State<ChocolateCakes> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('ChocolateCakes').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Column(
                children: [
                  SlideTransitionExample(
                    url: documentSnapshot['image'],
                    title: documentSnapshot['title'],
                    ratings: documentSnapshot['rating'],
                    price: documentSnapshot['price'],
                    color: documentSnapshot['color'],
                  ),
                ],
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
}

//Strawbery
class VanilaCakes extends StatefulWidget {
  const VanilaCakes({super.key});
  _VanilaCakesState createState() => _VanilaCakesState();
}

class _VanilaCakesState extends State<VanilaCakes> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('VanilaCakes').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Column(
                children: [
                  SlideTransitionExample(
                    url: documentSnapshot['image'],
                    title: documentSnapshot['title'],
                    ratings: documentSnapshot['rating'],
                    price: documentSnapshot['price'],
                    color: documentSnapshot['color'],
                  ),
                ],
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
}

//All
class AllCakes extends StatefulWidget {
  const AllCakes({super.key});
  _AllCakesState createState() => _AllCakesState();
}

class _AllCakesState extends State<AllCakes> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Cakes').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (BuildContext context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Column(
                children: [
                  SlideTransitionExample(
                    url: documentSnapshot['image'],
                    title: documentSnapshot['title'],
                    ratings: documentSnapshot['rating'],
                    price: documentSnapshot['price'],
                    color: documentSnapshot['color'],
                  ),
                ],
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
}
*/

class LogicForCourse extends StatefulWidget {
  const LogicForCourse({super.key});
  _LogicForCourseState createState() => _LogicForCourseState();
}

class _LogicForCourseState extends State<LogicForCourse> {
  bool isLoading = false;
  Map<String, dynamic>? userMapC;
  void onSearchC() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _fireStore
        .collection('StudentsInfo')
        .where('Email', isEqualTo: username.toString())
        .get()
        .then((value) {
      setState(() {
        userMapC = value.docs[0].data();
        isLoading = false;
      });
      print(userMapC);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: AlertDialog(
        title: const Text('Enter Details'),
        content: Form(
          key: formkey,
          child: Column(
            children: [
              TextForm(
                text: "Please Enter Your Registered Email",
                containerWidhth: width / 2,
                hinttext: "Please Enter Email",
                onChanged: (text) => null,
                validator: (text) {
                  if (text.toString().isEmpty || text.toString().length < 8) {
                    return "Please Enter Valid Email";
                  }
                },
                controller: emailVerify,
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
            onPressed: onSearchC,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

TextEditingController emailVerify = TextEditingController();
final formkeyC = GlobalKey<FormState>();
ShowDialogForEmail(BuildContext context) {}
