import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:new_sample/screens/SignUp.dart';

class otpVerification extends StatefulWidget {
  otpVerification(
      {super.key, required this.auth, required this.email, required this.pass});
  late EmailOTP auth;
  late String email;
  late String pass;

  @override
  State<otpVerification> createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify OTP",
          style: TextStyle(color: Colors.black),
        ),
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
      body: Container(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: SvgPicture.asset(
                  'assets/images/login.svg',
                  height: height * 0.3,
                  width: width - 60,
                )),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Verification',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Enter a 6 digit otp that was sent to',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.email,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) async {
                if (await widget.auth.verifyOTP(otp: verificationCode) ==
                    true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupPage(
                              email: widget.email, pass: widget.pass)));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP is verified"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Invalid OTP"),
                  ));
                }
              }, // end onSubmit
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '*Note : Check in the junk folder of your outlook ',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
