import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/sign_button.dart';
import 'package:studenttutorapp/ScreenBeforeLogin.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/main.dart';
import 'package:studenttutorapp/view_model.dart';

class StudentLoginView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final viewModelProvide = ref.watch(viewModel);
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Student Login'),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
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
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight / 5.5,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/applogo.jpg',
                        width: deviceWidth / 1.5,
                        height: deviceHeight / 3,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    EmailAndPassWordFieldsstudent(),
                    SizedBox(
                      height: 30.0,
                    ),
                    RegisterAndLoginstudent(),
                    SizedBox(
                      height: 20.0,
                    ),
                    SignInButton(
                      buttonType: ButtonType.google,
                      btnColor: Color(0XFFE39FF6),
                      btnTextColor: Colors.black,
                      buttonSize: ButtonSize.medium,
                      onPressed: () async {
                        viewModelProvide.signInWithGoogleWeb(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextEditingController _emailFieldstudent = TextEditingController();
TextEditingController _passwordFieldstudent = TextEditingController();
final formkeys = GlobalKey<FormState>();

class EmailAndPassWordFieldsstudent extends HookConsumerWidget {
  //final List _name = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final viewModelProvide = ref.watch(viewModel);
    return Form(
      key: formkeys,
      child: Column(
        children: [
          //Email
          SizedBox(
            width: width / 1.5,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              controller: _emailFieldstudent,
              onChanged: (value) {
                username = _emailFieldstudent.text;
              },
              validator: (value) {
                if (!value.toString().contains('@gmail.com')) {
                  return DialogBoxstudent(context,
                      "Please Follow The Tutor's Instructions Given By Organization");
                }
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: "Email",
                hintStyle: GoogleFonts.openSans(),
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),

          //Password
          SizedBox(
            width: width / 1.5,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              controller: _passwordFieldstudent,
              obscureText: viewModelProvide.isObscure,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    viewModelProvide.toggleObscure();
                  },
                  icon: Icon(
                    viewModelProvide.isObscure
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black,
                  ),
                ),
                hintText: "Password",
                hintStyle: GoogleFonts.openSans(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterAndLoginstudent extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    FirebaseAuth _auth = FirebaseAuth.instance;
    final _authState = ref.watch(authStateProvider);
    FirebaseFirestore _firebase = FirebaseFirestore.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.0,
          width: 150.0,
          child: MaterialButton(
            child: OpenSans(
              text: "Register",
              size: 20.0,
              color: Colors.black,
            ),
            splashColor: Colors.lightBlueAccent,
            color: Color(0xffcceeed),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              if (formkeys.currentState!.validate()) {
                await viewModelProvide.createUserWithEmailAndPassword(context,
                    _emailFieldstudent.text, _passwordFieldstudent.text);

                await _firebase.collection('Users').add({
                  "name": _emailFieldstudent.text.split("@")[0],
                  "email": _emailFieldstudent.text,
                  "status": "unavialable",
                });

                _authState.when(
                    data: (data) {
                      if (data != null) {
                        data.updateDisplayName(
                            _emailFieldstudent.text.split('@')[0]);
                      }
                    },
                    error: (error, stackTrace) {
                      return print("Name Operation Failed");
                    },
                    loading: () => CircularProgressIndicator());
              }
            },
          ),
        ),
        SizedBox(
          width: 7.0,
        ),
        Text(
          "OR",
          style: GoogleFonts.pacifico(fontSize: 14.0),
        ),
        SizedBox(
          width: 7.0,
        ),
        SizedBox(
          height: 50.0,
          width: 150.0,
          child: MaterialButton(
            child: OpenSans(
              text: "LOGIN",
              size: 20.0,
              color: Colors.black,
            ),
            splashColor: Colors.pinkAccent,
            color: Color(0xffedccee),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              if (formkeys.currentState!.validate()) {
                await viewModelProvide.signInWithEmailAndPassword(context,
                    _emailFieldstudent.text, _passwordFieldstudent.text);

                _emailFieldstudent.clear();
                _passwordFieldstudent.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}

DialogBoxstudent(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 2.0),
      ),
      title: OpenSans(
        text: title,
        size: 20.0,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScreenBeforeLogin(),
            ));
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
