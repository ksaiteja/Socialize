import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AskQuestionPage extends StatefulWidget {
  AskQuestionPage({super.key, required this.userData});
  late Map<String, dynamic> userData = new Map();

  @override
  State<AskQuestionPage> createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  List<String> categories = [
    'General Query',
    'Study Related Query',
    'others'
  ]; // Option 2
  late String fullname =
      widget.userData['lname'] + ' ' + widget.userData['fname'];
  late List<String> AnsweredByList = ['Anonymous', fullname];
  String? _selectCategory;
  String? answerAs;
  String? query;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      await _firestore.collection('queries').doc(_selectCategory!).set({
        'category': _selectCategory,
        'query': query,
        'id': userId,
        'answeredAs': answerAs,
        'date': DateTime.now().toString(),
      });
      await _firestore.collection('users').doc(userId).set({});
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Query posted succesfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask a Question..'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: width * 0.8,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                      'Select query category'), // Not necessary for Option 1
                  value: _selectCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectCategory = newValue;
                    });
                  },
                  items: categories.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                width: width * 0.8,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text('Answer as'), // Not necessary for Option 1
                  value: answerAs,
                  onChanged: (newValue) {
                    setState(() {
                      answerAs = newValue;
                    });
                  },
                  items: AnsweredByList.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.8,
              child: TextFormField(
                maxLines: 5,
                minLines: 1,
                onChanged: (value) {
                  query = value;
                },
                decoration: InputDecoration(
                    hintText: 'Enter your Query..',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: width * 0.6,
              child: ElevatedButton(
                  onPressed: () {
                    _submit;
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 244, 96, 224),
                      padding: const EdgeInsets.all(15),
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  child: Text('POST')),
            )
          ]),
        ),
      ),
    );
  }
}
