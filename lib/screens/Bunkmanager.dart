import 'package:flutter/material.dart';
import 'package:new_sample/screens/CalculateAtt.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const BunkManager());
}

class BunkManager extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  const BunkManager({Key? key}) : super(key: key);

  @override
  State<BunkManager> createState() => _BunkManagerState();
}

class _BunkManagerState extends State<BunkManager>
    with SingleTickerProviderStateMixin {
// ignore: prefer_const_constructors
  final TabBar _tabBar = TabBar(unselectedLabelColor: Colors.white, tabs: [
    const Tab(
      icon: Icon(
        Icons.calculate,
        color: Colors.white,
      ),
      text: 'Calculate',
    ),
    Tab(
      icon: const Icon(
        Icons.web_asset,
        color: Colors.white,
      ),
      text: 'WebView',
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('B U N K   M A N A G E R'),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.deepPurple, //<-- SEE HERE
                child: _tabBar,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: TabBarView(children: [const TakeInput(), Webviewer()]))
            ],
          ),
        ));
  }
}

class Webviewer extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Webviewer({super.key});

  @override
  State<Webviewer> createState() => _WebviewerState();
}

class _WebviewerState extends State<Webviewer>
    with AutomaticKeepAliveClientMixin {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          const Text("Loading....");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://studentscorner.vardhaman.org/'));

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }

  @override
  bool get wantKeepAlive => true;
}

class TakeInput extends StatefulWidget {
  const TakeInput({super.key});

  @override
  State<TakeInput> createState() => _TakeInputState();
}

class _TakeInputState extends State<TakeInput> {
  TextEditingController attended = TextEditingController();
  TextEditingController conducted = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: conducted,
                  decoration: const InputDecoration(
                    hintText: 'Enter total conducted Classes',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: attended,
                  decoration: const InputDecoration(
                    hintText: 'Enter total attended Classes',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _sendData(context);
                  },
                  child: const Text('Calculate'),
                ),
              ],
            )));
  }

  void _sendData(BuildContext context) {
    String att = attended.text;
    String con = conducted.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CalculateAtt(attended: att, conducted: con)));
  }
}
