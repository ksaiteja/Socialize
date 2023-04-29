import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_sample/screens/Bunkmanager.dart';
import 'Opening.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({super.key, required this.userData});
  late Map<String, dynamic> userData = new Map();

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.userData['purl'] == ''
                        ? Container(
                            padding: EdgeInsets.all(3.5),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1.7,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: widget.userData['gender'] == 'Female'
                                  ? SvgPicture.asset(
                                      'assets/images/profile_female.svg',
                                      height: 85,
                                      width: 85,
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/profile_male.svg',
                                      height: 85,
                                      width: 85,
                                    ),
                            ))
                        : Container(
                            padding: EdgeInsets.all(3.5),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1.7,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: widget.userData['purl'],
                                  height: 85,
                                  width: 85,
                                  placeholder: (context, url) => SpinKitPulse(
                                    color: Colors.purpleAccent,
                                    size: 50.0,
                                  ),
                                )),
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.userData['fname'] +
                              ' ' +
                              widget.userData['lname']),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.userData['rollno'],
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ]),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Bunk Manager'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BunkManager()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Profile'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OpeningPage()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
                leading: const Icon(Icons.border_color),
                title: const Text('Feedback'),
                onTap: () => {}),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}
