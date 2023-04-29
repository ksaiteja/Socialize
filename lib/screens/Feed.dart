import 'package:flutter/material.dart';

void main(){
  runApp(const FeedPage());
}

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is Feed page'),
      ),
    );
  }
}
