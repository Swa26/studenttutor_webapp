import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studenttutorapp/chatRoom.dart';
import 'package:studenttutorapp/components.dart';
import 'package:studenttutorapp/coursesDetail_screen.dart';
import 'package:studenttutorapp/view_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _text = TextEditingController();
  String chatRoomID(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _fireStore
        .collection('Users')
        .where('email', isEqualTo: _text.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Tata Digital'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
          ),
        ],
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
        child: SafeArea(
          child: Column(
            children: [
              TextForm(
                text: "Search User",
                containerWidhth: width / 1.5,
                hinttext: "Search User You Want",
                controller: _text,
                onChanged: (text) => null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                onPressed: onSearch,
                color: const Color(0xffcceeed),
                child: OpenSans(
                  text: "Search",
                  color: Colors.black,
                  size: 15.0,
                ),
              ),
              userMap != null
                  ? ListTile(
                      onTap: () {
                        String roomID = chatRoomID(
                            _auth.currentUser!.displayName!, userMap!['name']);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ChatRoom(
                            chatRoomID: roomID,
                            userMap: userMap!,
                          ),
                        ));
                      },
                      leading:
                          const Icon(Icons.account_box, color: Colors.black),
                      title: Text(userMap!['name']),
                      subtitle: Text(userMap!['email']),
                      trailing: const Icon(
                        Icons.chat,
                        color: Colors.black,
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
