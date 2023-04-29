import 'package:flutter/material.dart';
import 'package:new_sample/screens/StudyMaterials.dart';

void main() {
  runApp(const StudyPage());
}

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Study"),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  ContainerWithText(
                    width: width,
                    t: 'I',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StudyMaterialPage()));
                    },
                  ),
                  Spacer(),
                  ContainerWithText(
                    width: width,
                    t: 'II',
                    press: () {},
                  ),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  ContainerWithText(
                    width: width,
                    t: 'III',
                    press: () {},
                  ),
                  Spacer(),
                  ContainerWithText(
                    width: width,
                    t: 'IV',
                    press: () {},
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerWithText extends StatelessWidget {
  const ContainerWithText(
      {super.key, required this.width, required this.t, required this.press});

  final double width;
  final String t;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        press();
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        height: width * 0.4,
        width: width * 0.4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2.5, 2.5),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "B TECH",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "$t",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              Text(
                "YEAR",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassContainer extends StatelessWidget {
  const ClassContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: (width / 2),
      margin: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          child: Column(
            // add this
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/images/BunkManager.png',
                  width: 300,
                  height: 100,
                ),
              ),
              const ListTile(
                title: Center(
                  child: Text('Bunk Manager',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
