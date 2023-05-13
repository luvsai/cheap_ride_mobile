import 'package:cheap_ride/Views/LoginScreens.dart';
import 'package:cheap_ride/Views/HomeScreens.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './../utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({Key? key}) : super(key: key);

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {

  late Widget dest ;

  void GoNextpage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   // prefs.setString('stringValue', "abc");
    String stringValue = prefs.getString('stringValue') ?? "";

    if (stringValue.isEmpty) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) =>
              SendOTP()
          )
      ) ;

    }else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) =>
              Home()
          )
      ) ;

    }
  }


  @override
  Widget build(BuildContext context) {
    print("system height : " + SyswideSharedProps.screenHeight.toString()) ;

    Timer(Duration(seconds: 4),
            ()=> GoNextpage()
    );
    return Scaffold(
      //backgroundColor: Color(0xFF7EF262),

      body: Stack(

        children: [

          //  Align(
          //   alignment: Alignment.center,
          //   child:  Text(widget.app_name),
          // )
//---
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF5FFFEB),
                    Colors.green,
                  ],
                )
            ),
          ),

          Align(
            alignment: Alignment.center,

            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/newlogo.png'), height: 140,
                  width: 140,
                  fit: BoxFit.fitHeight,),
                //Text("CheapAuto" ,style: TextStyle(fontSize: 20),)
              ],
            ),

          ),

          // Align(
          //   alignment: Alignment.bottomRight,
          //
          //   child:   SafeArea(
          //     child: InkWell(
          //
          //
          //       child:  Padding(
          //         padding: EdgeInsets.all(5),
          //         child: Ink(
          //
          //           width: 155,
          //           height: 48,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             color: Color(0xffff5612),
          //           ),
          //           padding:  EdgeInsets.all(8),
          //
          //           child: Column(
          //
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children:[
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 10, ),
          //
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children:[
          //                     Text(
          //                       "Next",
          //                       style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 16,
          //                         fontFamily: "SF Pro Text",
          //                         fontWeight: FontWeight.w600,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       onTap: ()  {
          //         print("Next clidked");
          //       },
          //     ),
          //   ),
          // ),

          //--
        ],

      ),
    );
  }
}
