import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_sample/main.dart';
import 'package:new_sample/screens/SignUp_main.dart';
import 'package:new_sample/screens/color_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String Email = "", Pass = "";
  bool _isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Login Account",
                      style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Please login with registered account",
                      style: GoogleFonts.notoSans(textStyle: TextStyle()),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Email",
                  style: GoogleFonts.notoSans(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  //height: 60,

                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      Email = value;
                    },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Color.fromARGB(255, 246, 237, 237),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Color(0xFFA155B9),
                        ),
                        hintText: "Enter Your E-Mail"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
                  style: GoogleFonts.notoSans(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  //height: 60,
                  width: width - width * 0.1,
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      Pass = value;
                    },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Color.fromARGB(255, 246, 237, 237),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.key,
                          color: Color(0xFFA155B9),
                        ),
                        hintText: "Enter Password"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forget Password?",
                      style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                              color: color_constants.stage3,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? SpinKitThreeInOut(
                        color: Colors.purple,
                        size: 30.0,
                      )
                    : SizedBox(
                        width: width - 40,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  await _auth.signInWithEmailAndPassword(
                                      email: Email, password: Pass);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePage()));
                                } catch (e) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: Text(e.toString()),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                        );
                                      });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: color_constants.stage3,
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'notoSans',
                                )),
                            child: const Text("Sign In")),
                      ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?  ",
                      style: GoogleFonts.notoSans(textStyle: TextStyle()),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainSignUp()));
                      },
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.notoSans(
                            color: color_constants.stage3,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle()),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
