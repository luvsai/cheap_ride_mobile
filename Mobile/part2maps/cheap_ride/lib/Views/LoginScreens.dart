import 'package:flutter/material.dart';
import 'dart:async';
import './../utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cheap_ride/NetworkCalls.dart';
import 'package:cheap_ride/Models.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

import 'AccountCreationScreen.dart';
import 'HomeScreens.dart';

class SendOTP extends StatefulWidget {
  const SendOTP({Key? key}) : super(key: key);

  @override
  State<SendOTP> createState() => _SendOTPState();
}

class _SendOTPState extends State<SendOTP> {
  TextEditingController phoneController = TextEditingController();

  String phoneNo = "" ;
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = phoneController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    // if (text.isEmpty) {
    //   return 'Can\'t be empty';
    // }
    if ((text.length < 10 ) && text.length > 0) {
      //return 'Mobile should contain 10 digits';
    }
    // return null if the text is valid
    return null;
  }


  //show dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const  Text('Alert' , style: TextStyle(color: Colors.black),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
            Text('Phone Should be 10 digits' , style: TextStyle(color: Colors.red),),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //show view
  Future<void> _showloading(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(msg , style: TextStyle(color: Colors.black),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                //Text('Phone Should be 10 digits' , style: TextStyle(color: Colors.red),),
                Center(child :CircularProgressIndicator())
              ],
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('OK'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          // onHorizontalDragDown: (DragDownDetails details) {
          //   // Handle horizontal drag down gesture
          //
          //   // Add your custom logic here
          //   FocusManager.instance.primaryFocus?.unfocus();
          // },
        child:
           Scaffold(
        body: Stack(

            children : [
              Image(image: AssetImage('assets/images/loginback.jpg') ,fit: BoxFit.fitWidth ,width: SyswideSharedProps.screenWidth,),
              //logo and title
              SafeArea(
                  child: 
                    
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child : const Text("CheapRide", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 28, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic),)
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child : const Text("Login...", style: TextStyle(color: Color(0xFF000000), fontSize: 24, fontWeight: FontWeight.bold  ),)
                            ),
                          ],
                        )
              ),

              ),

              //code for bottom sheet
              Align(
                  alignment: Alignment.bottomCenter,
                  child :
                  Container (
                    padding: EdgeInsets.fromLTRB(20,  13, 20, 0),
                    decoration: BoxDecoration( color: Color(0xFFFFFBF1) , borderRadius: BorderRadius.circular(22)  ,border: Border.all(color: Color(0xFFFFEBB7),
                      width: 1, //                   <--- border width here
                    ), ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      crossAxisAlignment: CrossAxisAlignment.start,
                     // shrinkWrap: true,
                      children: [

                        //space on top
                        SizedBox(height: SyswideSharedProps.screenHeight * 0.01,),
                        //back and help controls
                        Row(
                          children: [
//                        back
                            Align(
                                alignment: Alignment.topRight,
                                child : Ink (
                                  child: InkWell(
                                      onTap: () => {
                                      SystemNavigator.pop()
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.chevron_left,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          const Text("Exit", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic),) ,

                                        ],)

                                  ),
                                )



                            ),
                            SizedBox(width: SyswideSharedProps.screenWidth * 0.5,),
                            Align(
                                alignment: Alignment.topRight,
                                child :
                                InkWell(
                                    onTap: () => {
                                      print("help Tapped!!!")
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.question_circle,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        const Text("Help", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),) ,

                                      ],)

                                )


                            ),
                          ],
                        ),

                        //rest
                        SizedBox(height: 15,),
                        Container (
                          padding: EdgeInsets.fromLTRB(10,  20, 10, 0),
                            child:
                                Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      const Text("Enter your Phone Number", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),),
                                      SizedBox(height: 0.025 * SyswideSharedProps.screenHeight,),
                                      const Text("OTP will be shared to this number", style: TextStyle(color: Colors.black, fontSize: 18 ),),
                                      SizedBox(height: 0.04 * SyswideSharedProps.screenHeight,),

                                      //phone no field
                                      Container (
                                        padding: EdgeInsets.fromLTRB(10,  0.01 * SyswideSharedProps.screenHeight, 0,  0.01 * SyswideSharedProps.screenHeight),
                                        decoration: BoxDecoration( color: Colors.white , borderRadius: BorderRadius.circular(10)  ,border: Border.all(color: Color(0xFFC1C1C1),
                                          width: 1, //                   <--- border width here
                                        ), ),

                                        child: Row(

                                          children: [
                                            SizedBox(width: 10,),
                                            const Text("+91", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),),
                                            SizedBox(width: 13,),

                                            SizedBox(
                                              width: SyswideSharedProps.screenWidth * 0.6,
                                              child:   TextField (

                                                controller: phoneController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    phoneNo = text;

                                                  });
                                                },
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(10),
                                                  FilteringTextInputFormatter.digitsOnly
                                                ], // Only nu
                                                decoration: InputDecoration(
                                                  errorText: _errorText,
                                                  border: InputBorder.none,
                                                  //labelText: 'Enter Number' ,


                                                  hintText: 'Enter Number',
                                                ),
                                                style: TextStyle(fontSize: 20 , letterSpacing: 3),

                                              ),
                                            )


                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 0.05 * SyswideSharedProps.screenHeight,),
                                      const Text("**By continuing you are agreeing to our terms and policy at CheapRide", style: TextStyle(color: Color(0xFF9D9B9B), fontSize: 14 ),),

                                      // submit Button
                                      SizedBox(height: 0.05 * SyswideSharedProps.screenHeight,),
                                      Align(
                                        alignment: Alignment.center,

                                        child: SizedBox(
                                          width: SyswideSharedProps.screenWidth * 0.6,
                                          height: SyswideSharedProps.screenHeight * 0.05,
                                          child:
                                          //

                                          ElevatedButton(
                                            style:  ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12), // <-- Radius
                                            ), textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold ) , backgroundColor: Color(0xFFFF5712)   )
                                            ,
                                            onPressed: () {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();

                                              //verify the phone number and do the required error handling
                                              //print(phoneNo) ;
                                              if (phoneNo.length < 10) {
                                                _showMyDialog();

//HTTP calls


                                              }

                                              //if phone no is valid request the server to send the otp to mobile number
                                              else {
                                                _showloading("Sending OTP");


                                                HttpService.requestOTP(phoneNo).then((res) {
                                                  print("in func: " + res.code);
                                                  if (res.code == "1") {
                                                    // go to verify page
                                                    Navigator.of(context).pop();
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                VerifyOTP(
                                                                  Ph: phoneNo,)
                                                        )
                                                    );
                                                  }
                                                  else {
                                                    //some network error TODO


                                                  }
                                                }
                                                ) ;
                                              }
                                            },
                                            child: const Text('Send OTP'),
                                          )
                                          //
                                          ,
                                        )
                                        ,
                                        ),

                                      SizedBox(height: 0.05 * SyswideSharedProps.screenHeight,),
                                    ],
                                    )
                              ),

                        //space at bottom
                        SizedBox(height: 15,),
                      ],
                    ),
                  )
                  ),


            ]

        )
    )
      );
  }
}

class VerifyOTP extends StatefulWidget {
  String Ph ;
  VerifyOTP({Key? key , this.Ph = ""}) : super(key: key );

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  TextEditingController phoneController = TextEditingController();

  String otp = "" ;
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = phoneController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    // if (text.isEmpty) {
    //   return 'Can\'t be empty';
    // }
    if ((text.length < 10 ) && text.length > 0) {
      //return 'Mobile should contain 10 digits';
    }
    // return null if the text is valid
    return null;
  }

  //show dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const  Text('Alert' , style: TextStyle(color: Colors.black),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('OTP Should be 6 digits' , style: TextStyle(color: Colors.red),),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //show view
  Future<void> _showloading(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(msg , style: TextStyle(color: Colors.black),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                //Text('Phone Should be 10 digits' , style: TextStyle(color: Colors.red),),
                Center(child :CircularProgressIndicator())
              ],
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('OK'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }

void takeHome(String token) async {

  SharedPreferences prefs =  await SharedPreferences.getInstance();
  prefs.setString('stringValue', token);
  //String stringValue = prefs.getString('stringValue') ?? "";

  Navigator.of(context).pop();

  Navigator.pushReplacement(context,
      MaterialPageRoute(builder:
          (context) =>
          SendOTP()
      )
  ) ;
}

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child:
          Scaffold(
              body: Stack(

                  children : [
                    Image(image: AssetImage('assets/images/loginback.jpg') ,fit: BoxFit.fitWidth ,width: SyswideSharedProps.screenWidth,),
                    //logo and title
                    SafeArea(
                      child:

                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child : const Text("CheapRide", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 28, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic),)
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child : const Text("Login...", style: TextStyle(color: Color(0xFF000000), fontSize: 24, fontWeight: FontWeight.bold  ),)
                              ),
                            ],
                          )
                      ),

                    ),

                    //code for bottom sheet
                    Align(
                        alignment: Alignment.bottomCenter,
                        child :
                        Container (
                          padding: EdgeInsets.fromLTRB(20,  13, 20, 0),
                          decoration: BoxDecoration( color: Color(0xFFFFFBF1) , borderRadius: BorderRadius.circular(22)  ,border: Border.all(color: Color(0xFFFFEBB7),
                            width: 1, //                   <--- border width here
                          ), ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            crossAxisAlignment: CrossAxisAlignment.start,
                            // shrinkWrap: true,
                            children: [

                              //space on top
                              SizedBox(height: SyswideSharedProps.screenHeight * 0.01,),
                              //back and help controls
                              Row(
                                children: [
//                        back
                                  Align(
                                      alignment: Alignment.topRight,
                                      child : Ink (
                                        child: InkWell(
                                            onTap: () => {
                                            Navigator.pop(context, 'Hello from the previous page') //going back to SendOTP screen
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.chevron_left,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                                const Text("Back", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic),) ,

                                              ],)

                                        ),
                                      )



                                  ),
                                  SizedBox(width: SyswideSharedProps.screenWidth * 0.5,),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child :
                                      InkWell(
                                          onTap: () => {
                                            print("help Tapped!!!")
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.question_circle,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              const Text("Help", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),) ,

                                            ],)

                                      )


                                  ),
                                ],
                              ),

                              //rest
                              SizedBox(height: 15,),
                              Container (
                                  padding: EdgeInsets.fromLTRB(10,  20, 10, 0),
                                  child:
                                  Column (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      const Text("Verify OTP", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),),
                                      SizedBox(height: 0.025 * SyswideSharedProps.screenHeight,),
                                       Text("OTP is sent to  " + (this.widget.Ph ?? "" )  , style: TextStyle(color: Colors.black, fontSize: 18 ),),
                                      SizedBox(height: 0.04 * SyswideSharedProps.screenHeight,),

                                      //phone no field
                                      Container (
                                        padding: EdgeInsets.fromLTRB(10,  0.01 * SyswideSharedProps.screenHeight, 0,  0.01 * SyswideSharedProps.screenHeight),
                                        decoration: BoxDecoration( color: Colors.white , borderRadius: BorderRadius.circular(10)  ,border: Border.all(color: Color(0xFFC1C1C1),
                                          width: 1, //                   <--- border width here
                                        ), ),

                                        child: Row(

                                          children: [
                                            SizedBox(width: 10,),
                                            const Text("", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),),
                                            SizedBox(width: 13,),

                                            SizedBox(
                                              width: SyswideSharedProps.screenWidth * 0.6,
                                              child:   TextField (

                                                controller: phoneController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    otp = text;

                                                  });
                                                },
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(6),
                                                  FilteringTextInputFormatter.digitsOnly
                                                ], // Only nu
                                                decoration: InputDecoration(
                                                  errorText: _errorText,
                                                  border: InputBorder.none,
                                                  //labelText: 'Enter Number' ,


                                                  hintText: 'Enter OTP',
                                                ),
                                                style: TextStyle(fontSize: 20 , letterSpacing: 5),

                                              ),
                                            )


                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 0.02 * SyswideSharedProps.screenHeight,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child:  Text("Resend OTP", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic),)

                                              ,
                                            onTap: () => {
                                              print("OTP is resending")

                                              //TODO call the resend function
                                            },
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 0.05 * SyswideSharedProps.screenHeight,),
                                      const Text("**By continuing you are agreeing to our terms and policy at CheapRide", style: TextStyle(color: Color(0xFF9D9B9B), fontSize: 14 ),),

                                      // submit Button
                                      SizedBox(height: 0.05 * SyswideSharedProps.screenHeight,),
                                      Align(
                                        alignment: Alignment.center,

                                        child: SizedBox(
                                          width: SyswideSharedProps.screenWidth * 0.6,
                                          height: SyswideSharedProps.screenHeight * 0.05,
                                          child:  ElevatedButton(
                                            style:  ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12), // <-- Radius
                                            ), textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold ) , backgroundColor: Color(0xFFFF5712)   )
                                            ,
                                            onPressed: () {
                                              FocusManager.instance.primaryFocus?.unfocus() ;

                                              //verify the phone number and do the required error handling
                                              //print(phoneNo) ;
                                              if (otp.length < 6) {
                                                _showMyDialog() ;
                                              }

                                              //if phone no is valid request the server to send the otp to mobile number
                                              else {
                                                _showloading("Verifying OTP");


                                                HttpService.verifyOTP(this.widget.Ph, this.otp).then((res) {
                                                  print("in func: " + res.code);
                                                  if (res.code == "2") {
                                                    // go to Home page
                                                    print("Goind to homepage");

                                                    Navigator.of(context).pop();
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                               Home()
                                                        )
                                                    );
                                                  }else if (res.code == "3") {
                                                  //    Route To Acc creation page
                                                    //TODO

                                                    Navigator.of(context).pop();
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ACC(Ph: this.widget.Ph,)
                                                        )
                                                    );
                                                  }
                                                  else {
                                                    //some network error
                                                    Navigator.of(context).pop();

                                                  }
                                                }
                                                ) ;
                                              }

                                            },
                                            child: const Text('Verify  OTP'),
                                          ),
                                        )
                                        ,
                                      ),

                                      SizedBox(height: 0.05 * SyswideSharedProps.screenHeight,),
                                    ],
                                  )
                              ),

                              //space at bottom
                              SizedBox(height: 15,),
                            ],
                          ),
                        )
                    ),


                  ]

              )
          )
      );
  }
}
 