import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_sample/screens/EditProfile.dart';
import 'package:new_sample/screens/Opening.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_sample/screens/changePassword.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.userData});
  late Map<String, dynamic> userData = new Map();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final imagesRef = FirebaseStorage.instance
      .ref()
      .child(FirebaseAuth.instance.currentUser!.uid.toString() + ".jpeg");
  late Future<String> url = imagesRef.getDownloadURL();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(53)),
                  ),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: widget.userData['purl'] == ''
                        ? widget.userData['gender'] == 'Female'
                            ? SvgPicture.asset(
                                'assets/images/profile_female.svg',
                                height: 100,
                                width: 100,
                              )
                            : SvgPicture.asset(
                                'assets/images/profile_male.svg',
                                height: 100,
                                width: 100,
                              )
                        : CachedNetworkImage(
                            imageUrl: widget.userData['purl'],
                            height: 100,
                            width: 100,
                            placeholder: (context, url) => SpinKitPulse(
                              color: Colors.purpleAccent,
                              size: 50.0,
                            ),
                          )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.userData['fname'] + ' ' + widget.userData['lname'],
                style: GoogleFonts.poppins(
                  // ignore: prefer_const_constructors
                  textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              height: 60,
            ),
            SelectOpWidget(
                width: width,
                title: "Edit Profile",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfilePage(userData: widget.userData)));
                }),
            SelectOpWidget(width: width, title: "Your Question", press: () {}),
            SelectOpWidget(width: width, title: "Your Answers", press: () {}),
            SelectOpWidget(
                width: width,
                title: "Change Password",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordPage()));
                }),
            SelectOpWidget(
                width: width,
                title: "Logout",
                press: () {
                  Logout();
                }),
            // Text(FirebaseAuth.instance.currentUser!.name.toString()),
          ],
        ),
      ),
    );
  }

  Future<void> Logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OpeningPage()));
  }
}

class SelectOpWidget extends StatelessWidget {
  const SelectOpWidget({
    super.key,
    required this.width,
    required this.title,
    required this.press,
  });

  final double width;
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: InkWell(
            onTap: () {
              press();
            },
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              padding: EdgeInsets.only(top: 20, bottom: 10),
              width: width,
              height: 60,
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: width * 0.9,
          height: 1,
          decoration: BoxDecoration(color: Colors.black),
        )
      ],
    );
  }
}

class GetFullName extends StatelessWidget {
  final String documentId;

  GetFullName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Loading",
              style: GoogleFonts.poppins(
                // ignore: prefer_const_constructors
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Name hasn't set yet",
              style: GoogleFonts.poppins(
                // ignore: prefer_const_constructors
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 255, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data['fname']} ${data['lname']}",
              style: GoogleFonts.poppins(
                // ignore: prefer_const_constructors
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ));
        }

        return Text("Loading",
            style: GoogleFonts.poppins(
              // ignore: prefer_const_constructors
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ));
      },
    );
  }
}
