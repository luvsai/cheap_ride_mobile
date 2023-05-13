import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:share_plus/share_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  final appname = "cheapride" ;


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.appname),
        ),
        body: Center(

          child: Stack( children: [
            Column(
              children: [
                Expanded(
                  child: new Text('Datetime',
                      style: new TextStyle(color: Colors.grey)
                  ),
                ),
                // FittedBox(
                //   child: Image.asset('assets/images/back.png'),
                //   fit: BoxFit.fill,
                // )
                Image(image: AssetImage('assets/images/back.png'),fit: BoxFit.cover),
              ],
            ),

            Column(
              children: [
                GestureDetector(
                  // When the child is tapped, show a snackbar.
                  onTap: () {
                    // const snackBar = SnackBar(content: Text('Tap'));
                    //
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  // The custom button
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text('My Button'),
                  ),
                ),
                Text("CheapRide ..."),
                Lottie.network(
                    'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: FaIcon(FontAwesomeIcons.gamepad),
                    onPressed: () { print("Pressed"); }
                ),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: FaIcon(FontAwesomeIcons.chrome, color: Colors.purple,),
                    onPressed: () {
                      print("Pressed");
                      // Share.share('check out my website https://example.com');
                    }
                ),
              ],
            )
          ],)



        )
    );
  }
}



