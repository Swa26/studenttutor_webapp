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
import 'package:studenttutorapp/productsWidget.dart';
import 'package:studenttutorapp/teacherAssignments.dart';
import 'package:studenttutorapp/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

final String name = "Tata Digital Tutor";

class TutorHomeScreen extends HookConsumerWidget {
  final List<Widget> screens = const [ProductsWidget(), Text('Cart')];
  final _page = useState(0);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrawerHeader(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/applogo.jpg'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              elevation: 20.0,
              height: 50.0,
              minWidth: 200.0,
              color: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                await viewModelProvider.logout();
              },
              child: OpenSans(
                text: "Logout",
                color: Colors.black,
                size: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('https://www.instagram.com/swanand_joshi_/'),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons8-instagram.svg',
                    width: 50.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('www.linkedin.com/in/swanand-joshi26'),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons8-linkedin.svg',
                    width: 50.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Tata Digital Tutor'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
        centerTitle: true,
      ),
      body: Home(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _page.value,
        onTap: (index) {
          _page.value = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_max_outlined,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: Colors.black,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentDetails(),
                      ));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Image.network(
                            'https://img.freepik.com/free-vector/college-university-students-group-young-happy-people-standing-isolated-white-background_575670-66.jpg?size=626&ext=jpg&ga=GA1.1.1437964836.1692623103&semt=sph',
                            height: 160.0,
                            width: 160.0,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          OpenSans(
                            text: "All Enrolled Students",
                            color: Colors.black,
                            size: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddCourse(),
                      ));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Image.network(
                            'https://img.freepik.com/free-vector/online-certification-illustration_23-2148575636.jpg?size=626&ext=jpg&ga=GA1.1.1437964836.1692623103&semt=sph',
                            height: 160.0,
                            width: 160.0,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          OpenSans(
                            text: "Add Courses",
                            color: Colors.black,
                            size: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddAssignments(),
                      ));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Image.network(
                            'https://img.freepik.com/free-vector/hand-drawn-business-planning_52683-76248.jpg?size=626&ext=jpg&ga=GA1.1.1437964836.1692623103&semt=sph',
                            height: 160.0,
                            width: 160.0,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          OpenSans(
                            text: "Add Assignments",
                            color: Colors.black,
                            size: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Image.network(
                            'https://img.freepik.com/free-vector/build-your-program-appointment-booking_23-2148552954.jpg?size=626&ext=jpg&ga=GA1.1.1437964836.1692623103&semt=sph',
                            height: 160.0,
                            width: 160.0,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          OpenSans(
                            text: "Attendence",
                            color: Colors.black,
                            size: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /*ScreenTypeLayout(
          mobile: _buildGridView(2), // 2 items per row on mobile
          tablet: _buildGridView(3), // 3 items per row on tablet
          desktop: _buildGridView(6), // 6 items per row on desktop
        ),*/
      ),
    );
  }
}

/////////////
