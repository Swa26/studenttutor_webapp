import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/courseMaterial.dart';
import 'package:studenttutorapp/productsWidget.dart';
import 'package:studenttutorapp/studentProfile_view.dart';
import 'package:studenttutorapp/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

final String name = "Tata Digital";

class StudentHomeView extends HookConsumerWidget {
  final List<Widget> screens = [ProductsWidget(), StudentProfile()];
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
            MaterialButton(
              elevation: 20.0,
              height: 50.0,
              minWidth: 200.0,
              color: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CourseMaterial(),
                ));
              },
              child: OpenSans(
                text: "Your Courses",
                color: Colors.black,
                size: 20.0,
              ),
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
        title: const Text('Tata Digital'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
        centerTitle: true,
      ),
      body: screens[_page.value],
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
