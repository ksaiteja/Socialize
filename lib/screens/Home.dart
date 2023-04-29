// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_sample/screens/askQuestion.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.userData});
  late Map<String, dynamic> userData = new Map();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(children: [
        HeaderWithButton(userData: widget.userData),
        SizedBox(
          height: 20,
        ),
        TextWithMoreButton(text: 'General Queries'),
        ScrollableGeneralQueries(width: width, height: height),
        TextWithMoreButton(text: 'Study Related Queries'),
        ScrollableStudyQueries(width: width, height: height)
      ]),
    );
  }
}

class ScrollableStudyQueries extends StatelessWidget {
  const ScrollableStudyQueries({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ContainerWithQuery(
              width: width,
              height: height,
              query:
                  'What is the formula of salt?What is the formula of salt?What is the formula of salt?What is the formula of salt?What is the formula of salt?What is the formula of salt?What is the formula of salt?What is the formula of salt?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the formula of salt?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the formula of salt?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the formula of salt?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the formula of salt?',
              press: () {}),
        ],
      ),
    );
  }
}

class ScrollableGeneralQueries extends StatelessWidget {
  const ScrollableGeneralQueries({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the meaning of mercy?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the meaning of mercy?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the meaning of mercy?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the meaning of mercy?',
              press: () {}),
          ContainerWithQuery(
              width: width,
              height: height,
              query: 'What is the meaning of mercy?',
              press: () {}),
        ],
      ),
    );
  }
}

class ContainerWithQuery extends StatelessWidget {
  final String query;
  const ContainerWithQuery(
      {super.key,
      required this.width,
      required this.height,
      required this.query,
      required this.press});

  final double width;
  final double height;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: width * 0.5,
        height: height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2.5, 2.5),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '$query',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextWithMoreButton extends StatelessWidget {
  late String text;
  TextWithMoreButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          TitleWithUnderLine(title: "$text"),
          const Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(color: Colors.white)),
              onPressed: () {},
              child: const Text('More'))
        ],
      ),
    );
  }
}

class TitleWithUnderLine extends StatelessWidget {
  late String title;
  TitleWithUnderLine({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              '$title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(right: 4),
                height: 5,
                color: Colors.deepPurple.withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}

class HeaderWithButton extends StatelessWidget {
  HeaderWithButton({super.key, required this.userData});

  Map<String, dynamic> userData = new Map();
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height * 0.3,
            child: Stack(children: [
              Container(
                width: width,
                height: (height * 0.3) - 27,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text("Hello " + userData['lname'],
                              style: GoogleFonts.poppins(
                                // ignore: prefer_const_constructors
                                textStyle: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text('Whats on your mind?',
                            style: GoogleFonts.poppins(
                              // ignore: prefer_const_constructors
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text('Get it out....',
                            style: GoogleFonts.poppins(
                              // ignore: prefer_const_constructors
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            )),
                      )
                    ]),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AskQuestionPage(userData: userData)));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.all(15),
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    child: const Text('Ask a Query'),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

// class GetUserName extends StatelessWidget {
//   final String documentId;

//   GetUserName(this.documentId);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Hello User!",
//               style: GoogleFonts.poppins(
//                 // ignore: prefer_const_constructors
//                 textStyle: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 4,
//                 ),
//               ));
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Hello User!",
//               style: GoogleFonts.poppins(
//                 // ignore: prefer_const_constructors
//                 textStyle: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 4,
//                 ),
//               ));
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Hello ${data['lname']}!",
//               style: GoogleFonts.poppins(
//                 // ignore: prefer_const_constructors
//                 textStyle: TextStyle(
//                   fontSize: 30,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 4,
//                 ),
//               ));
//         }

//         return Text("loading",
//             style: GoogleFonts.poppins(
//                 // ignore: prefer_const_constructors
//                 textStyle: TextStyle(
//               fontSize: 30,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 4,
//             )));
//       },
//     );
//   }
// }
