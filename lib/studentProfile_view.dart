import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:studenttutorapp/addCourses.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/enrolledStudent_details.dart';
import 'package:studenttutorapp/main.dart';
import 'package:studenttutorapp/productsWidget.dart';
import 'package:studenttutorapp/studentAssignment.dart';
import 'package:studenttutorapp/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentProfile extends HookConsumerWidget {
  final List<Widget> screens = const [ProductsWidget(), Text('Cart')];
  final _page = useState(0);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    // TODO: implement build
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  _HomeState createState() => _HomeState();
}

final ss = username.split('@')[0];
String uname = ss.toString().capitalizeS();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print(ss);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              OpenSans(
                text: 'Hello $uname',
                color: Colors.black,
                size: 18.0,
                fontweight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.0,
              ),
              Image.network(
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg&ga=GA1.1.1437964836.1692623103&semt=sph',
                height: 300.0,
                width: 300.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              OpenSans(
                text: 'Email: $username',
                color: Colors.black,
                size: 18.0,
                fontweight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalizeS() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
