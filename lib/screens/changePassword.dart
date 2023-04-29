import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String? _oldPassword;
  String? _newPassword;
  String? _confirmPassword;

  Future<void> _changePassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email.toString(),
        password: _oldPassword!,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(_newPassword!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password has been sucessfully changed"),
      ));
      Navigator.pop(context);
      // Password changed successfully
    } on FirebaseAuthException catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Old password does not match!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                onSaved: (value) => _oldPassword = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onChanged: (value) => _newPassword = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                onChanged: (value) => _confirmPassword = value,
                validator: (value) {
                  if (value != _newPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Confirm password does not match"),
                    ));
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    await _changePassword();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
