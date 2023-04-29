import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_sample/main.dart';
import 'package:new_sample/screens/Login.dart';
import 'package:new_sample/screens/SignUp.dart';
import 'package:new_sample/screens/SignUp_main.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFF9D1D1),
        body: Container(
          margin: const EdgeInsets.only(top: 55, left: 30, right: 30),
          height: height,
          width: width,
          child: Column(children: [
            Text(
              "Welcome to Socialize",
              style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            ImageSlideshow(
              height: height * 0.45,
              initialPage: 0,
              indicatorColor: const Color.fromARGB(255, 214, 56, 185),
              indicatorBackgroundColor: Colors.grey,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 50),
                  child: SvgPicture.asset(
                    'assets/images/discussion.svg',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 50),
                  child: SvgPicture.asset(
                    'assets/images/Group_chat.svg',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 50),
                  child: SvgPicture.asset(
                    'assets/images/social_friends.svg',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 50),
                  child: SvgPicture.asset(
                    'assets/images/social.svg',
                  ),
                ),
              ],
              onPageChanged: (value) {},
              autoPlayInterval: 5000,
              isLoop: true,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Clear your mind",
              style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Get your doubts solved, Ask questions and ",
              style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(fontSize: 15)),
            ),
            Text(
              "get the answers ",
              style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(fontSize: 15)),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: width - 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Color(0xFFA155B9),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'notoSans',
                      )),
                  child: const Text("Login")),
            ),
            const SizedBox(height: 15),
            Container(
              width: width - 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainSignUp()));
                  },
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Color(0xFFF765A3),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'notoSans',
                      )),
                  child: const Text(
                    "Signup",
                  )),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
              },
              child: const Text(
                'Skip for Now',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
