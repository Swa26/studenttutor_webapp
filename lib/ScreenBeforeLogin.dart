import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/login_handler.dart';
import 'package:studenttutorapp/main.dart';
import 'package:studenttutorapp/view_model.dart';

class ScreenBeforeLogin extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final viewModelProvider = ref.watch(viewModel);
    useEffect(() {
      viewModelProvider.logout();
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Container(
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
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/applogo.jpg',
                    width: width / 1.5,
                    height: height / 2,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () {
                      role = "student";
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginHandler(),
                      ));
                    },
                    child: OpenSans(
                      text: "Student Login",
                      color: Colors.black,
                      size: 30.0,
                      fontweight: FontWeight.bold,
                    ),
                    color: Color(0xffcceeed),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () {
                      role = "tutor";
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginHandler(),
                        ),
                      );
                    },
                    child: OpenSans(
                      text: "Tutor Login",
                      color: Colors.black,
                      size: 30.0,
                      fontweight: FontWeight.bold,
                    ),
                    color: Color(0xffedccee),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
