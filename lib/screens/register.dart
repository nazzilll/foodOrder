import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_eatit_new/const/const.dart';

import 'package:flutter_eatit_new/screens/main.dart';
import 'package:flutter_eatit_new/screens/login.dart';
import 'package:flutter_eatit_new/services/firebase_auth_service.dart';

class Register extends StatefulWidget {
  final FirebaseApp app;

  const Register({Key? key, required this.app}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

final FirebaseAuthService _authService = FirebaseAuthService();

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _authService.signUpWithEmailandPassword(email, password, context);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User is successfully created"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(app: widget.app, user: user)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cannot create user"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: GoogleFonts.jetBrainsMono(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.0),
            _buildTextField(
              controller: _emailController,
              label: "Email Address",
              icon: Icons.email,
            ),
            SizedBox(height: 12.0),
            _buildTextField(
              controller: _passwordController,
              label: "Password",
              icon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            _buildElevatedButton(
              onPressed: register,
              label: "Sign up",
              color: Colors.deepPurple,
            ),
            SizedBox(height: 12.0),
            _buildLoginText(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      obscureText: obscureText,
    );
  }

  Widget _buildElevatedButton({
    required VoidCallback onPressed,
    required String label,
    required Color color,
  }) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(COLOR_MENU_BG)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?"),
        SizedBox(width: 4.0),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(app: widget.app),
              ),
            );
          },
          child: Text(
            "Login.",
            style: GoogleFonts.jetBrainsMono(
              color: Color(COLOR_MENU_BG),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
