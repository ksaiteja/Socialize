import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_sample/screens/Login.dart';
import 'package:new_sample/screens/color_constants.dart';

import 'otpVerification.dart';

class MainSignUp extends StatefulWidget {
  const MainSignUp({Key? key}) : super(key: key);

  @override
  State<MainSignUp> createState() => _MainSignUpState();
}

class _MainSignUpState extends State<MainSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  EmailOTP myauth = EmailOTP();
  String Email = "", Pass = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Create your account with vardhaman Mail ID",
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
                SizedBox(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      } else if (value
                              .toLowerCase()
                              .contains('vardhaman.org') ==
                          false) {
                        return 'please enter valid vardhaman mail id';
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
                          color: Color(0xFFF765A3),
                        ),
                        hintText: "Enter Your E-Mail"),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                          color: Color(0xFFF765A3),
                        ),
                        hintText: "Enter Password"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Confirm Password",
                  style: GoogleFonts.notoSans(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value != Pass) {
                        return 'Password and confirm password does not match';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Color.fromARGB(255, 246, 237, 237),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.key,
                          color: Color(0xFFF765A3),
                        ),
                        hintText: "Confirm Password"),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                                myauth.setConfig(
                                    appEmail: "noreply@socialize.com",
                                    appName: "Socialize for vardhaman",
                                    userEmail: Email,
                                    otpLength: 6,
                                    otpType: OTPType.digitsOnly);
                                if (await myauth.sendOTP() == true) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => otpVerification(
                                              auth: myauth,
                                              email: Email,
                                              pass: Pass)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("OTP has been sent"),
                                  ));
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Oops, OTP send failed"),
                                  ));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: color_constants.stage4,
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'notoSans',
                                )),
                            child: const Text("Send OTP"))),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?  ",
                      style: GoogleFonts.notoSans(textStyle: TextStyle()),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.notoSans(
                            color: color_constants.stage4,
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
