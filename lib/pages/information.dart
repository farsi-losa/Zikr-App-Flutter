import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInformation extends StatefulWidget {
  AppInformation({Key? key}) : super(key: key);
  @override
  _AppInformation createState() => _AppInformation();
}

class _AppInformation extends State<AppInformation> {
  // This widget is the root of your application.

  String appVersion = '0.0.0';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bgpattern.png"),
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeatY,
            ),
          ),
          child: Column(
            children: [
              Flexible(
                child: Center(
                  child: Container(
                    height: 300,
                    margin: const EdgeInsets.fromLTRB(35, 0, 35, 55),
                    padding: const EdgeInsets.all(35),
                    alignment: Alignment.center,
                    child: Column(children: [
                      Text(
                        'Dzikir Application',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff24573F), fontSize: 18),
                      ),
                      Spacer(),
                      Container(
                        width: 200,
                        child: Text(
                          'Dukung kami dengan memberikan penilaian di appstore',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff24573F), fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                        width: 147,
                        height: 34,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff93BC9C),
                          ),
                          child: Text(
                            'Review',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      Text(
                        'Version $appVersion',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xffAF9C4D), fontSize: 12),
                      ),
                    ]),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends StatelessWidget {
//   // int _counter = 0;

//   // void _incrementCounter() {
//   //   setState(() {
//   //     // This call to setState tells the Flutter framework that something has
//   //     // changed in this State, which causes it to rerun the build method below
//   //     // so that the display can reflect the updated values. If we changed
//   //     // _counter without calling setState(), then the build method would not be
//   //     // called again, and so nothing would appear to happen.
//   //     _counter++;
//   //   });
//   // }

//   void _onMenuClicked(type) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => type == 'auto' ? AutoCounter() : AppInformation(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           // color: Color(0xff0F0C0D),
//           image: DecorationImage(
//             image: AssetImage("assets/images/bgpattern.png"),
//             fit: BoxFit.contain,
//             repeat: ImageRepeat.repeatY,
//           ),
//         ),
//         child: Column(children: [
//           Spacer(),
//           GestureDetector(
//             onTap: () {
//               _onMenuClicked('auto');
//             },
//             child: Center(
//               child: Container(
//                 height: 150,
//                 width: 150,
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Automatic counter',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xff24573F),
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 3,
//                       offset: Offset(2, 2), // changes position of shadow
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: () {
//               _onMenuClicked('manual');
//             },
//             child: Center(
//               child: Container(
//                 height: 150,
//                 width: 150,
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Manual counter',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xffAF9C4D),
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 3,
//                       offset: Offset(2, 2), // changes position of shadow
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Spacer(),
//         ]),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _incrementCounter,
//       //   tooltip: 'Increment',
//       //   child: Icon(Icons.add),
//       // ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
