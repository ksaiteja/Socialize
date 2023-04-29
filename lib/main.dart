import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/Home.dart';
import 'screens/Feed.dart';
import 'screens/Study.dart';
import 'screens/Profile.dart';
import 'screens/Opening.dart';
import 'screens/NavDrawer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socialize for vardhaman',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const MyHomePage();
          } else {
            return const OpeningPage();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static Map<String, dynamic> userInfo = new Map();
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    setState(() {
      userInfo['lname'] = data['lname'];
      userInfo['fname'] = data['fname'];
      userInfo['rollno'] = data['rollno'];
      userInfo['gender'] = data['gender'];
      userInfo['purl'] = data['purl'];
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(userData: userInfo),
    StudyPage(),
    FeedPage(),
    ProfilePage(userData: userInfo),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          drawer: NavDrawer(userData: userInfo),
          appBar: AppBar(
              elevation: 0,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(
                "S O C I A L I Z E",
                style: TextStyle(fontWeight: FontWeight.bold),
                // style: GoogleFonts.lobster(
                //   fontSize: 25,
                // ),
              )),
          body: userInfo.isEmpty
              ? SpinKitWave(
                  color: Colors.deepPurple,
                  size: 40.0,
                )
              : _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: GNav(
            tabMargin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            backgroundColor: Colors.deepPurple,
            haptic: true, // haptic feedback
            tabBorderRadius: 50,
            tabActiveBorder:
                Border.all(color: Colors.white, width: 1), // tab button border
            curve: Curves.easeOutCirc, // tab animation curves
            duration:
                const Duration(milliseconds: 250), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.white70, // unselected icon color
            activeColor: Colors.white, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: Colors.purpleAccent
                .withOpacity(0.1), // selected tab background color
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 11), // navigation bar padding
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                rippleColor:
                    Colors.purple, // tab button ripple color when pressed
                hoverColor: Colors.deepPurpleAccent,
              ),
              GButton(
                icon: LineIcons.bookReader,
                text: 'Study',
                rippleColor:
                    Colors.purple, // tab button ripple color when pressed
                hoverColor: Colors.deepPurpleAccent,
              ),
              GButton(
                icon: LineIcons.bell,
                text: 'Feed',
                rippleColor:
                    Colors.purple, // tab button ripple color when pressed
                hoverColor: Colors.deepPurpleAccent,
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
                rippleColor:
                    Colors.purple, // tab button ripple color when pressed
                hoverColor: Colors.deepPurpleAccent,
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
          ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
