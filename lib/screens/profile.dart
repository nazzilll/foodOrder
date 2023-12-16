import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/const/const.dart';
import 'package:flutter_eatit_new/strings/main_strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_eatit_new/screens/login.dart'; // Import your login screen

class Profile extends StatelessWidget {
  final FirebaseApp app;
  final User user;

  const Profile({Key? key, required this.app, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profileText,
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(COLOR_MENU_BG),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    child: CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: Color(COLOR_ICON_DRAWER),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome !",
              style: GoogleFonts.jetBrainsMono(
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "${user.email ?? "N/A"}",
              style: GoogleFonts.jetBrainsMono(
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            // Logout button
            InkWell(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login(app: app)),
                  );
                } catch (e) {
                  print("Error signing out: $e");
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.red, // You can change the color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Logout",
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
