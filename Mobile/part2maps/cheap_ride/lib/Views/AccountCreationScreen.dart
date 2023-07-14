import 'dart:ui';

import 'package:cheap_ride/UIReusable.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './../utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cheap_ride/NetworkCalls.dart';
import 'package:cheap_ride/Models.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreens.dart';

//Account CreationWidget
class ACC extends StatefulWidget {
  String Ph ;
   ACC({Key? key, this.Ph = ""}) : super(key: key);

  @override
  State<ACC> createState() => _ACCState();
}

class _ACCState extends State<ACC> {
  TextEditingController nameController = TextEditingController();
  String? selectedGender ;
  String userName = "" ;
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = nameController.value.text;
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
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 255, sigmaY: 255),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 255, sigmaY: 255),
                        child: Container(
                          color: Colors.transparent,
                          width: SyswideSharedProps.screenWidth,
                          height: SyswideSharedProps.screenHeight,
                        ),
                      ),

                    ),
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
                              // Align(
                              //     alignment: Alignment.topLeft,
                              //     child : const Text("Create Account", style: TextStyle(color: Color(0xFF000000), fontSize: 24, fontWeight: FontWeight.bold  ),)
                              // ),
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
                          height: SyswideSharedProps.screenHeight * 0.7,
                          decoration: BoxDecoration( color: Color(0xFFFFFBF1) , borderRadius: BorderRadius.circular(22)  ,border: Border.all(color: Color(0xFFFFEBB7),
                            width: 1, //                   <--- border width here
                          ), ),
                          child: ListView(

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
                                            print("help Tapped"+SyswideSharedProps.screenWidth.toString())

                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.question_circle,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              const Text("Help", style: TextStyle(color: Colors.black, fontSize: 18 , fontWeight: FontWeight.bold ),) ,

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

                                      const Text("Create your Account", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),),
                                      SizedBox(height: 0.025 * SyswideSharedProps.screenHeight,),
                                      //Customer name field
                                      Row(
                                        children: [
                                          Text("What name would you like us to call you?", style: TextStyle(color: Colors.black54, fontSize: (16 * ( SyswideSharedProps.screenWidth /393)) ),),

                                      const Text("*", style: TextStyle(color: Colors.red, fontSize: 16 ),),
                      ],
                                      ),

                                      SizedBox(height: 0.01 * SyswideSharedProps.screenHeight,),


                                      Container (
                                        padding: EdgeInsets.fromLTRB(10,  0.0005 * SyswideSharedProps.screenHeight, 0,  0.005 * SyswideSharedProps.screenHeight),
                                        decoration: BoxDecoration( color: Colors.white , borderRadius: BorderRadius.circular(5)  ,border: Border.all(color: Color(0xFFC1C1C1),
                                          width: 1, //                   <--- border width here
                                        ), ),

                                        child: Row(

                                          children: [
                                            SizedBox(width: 10,),
                                            // const Text(":", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold ),),
                                            // SizedBox(width: 13,),

                                            SizedBox(
                                              width: SyswideSharedProps.screenWidth * 0.6,
                                              child:   TextField (

                                                controller: nameController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    userName = text;

                                                  });
                                                },
                                                keyboardType: TextInputType.name,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
                                                ], // Only nu
                                                decoration: InputDecoration(
                                                  errorText: _errorText,
                                                  border: InputBorder.none,
                                                  //labelText: 'Enter Number' ,
                                                  hintStyle: TextStyle(fontSize: 20 , letterSpacing: 2),

                                                  hintText: 'Enter Name',
                                                ),
                                                style: TextStyle(fontSize: 20 , letterSpacing: 2),

                                              ),
                                            )


                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 0.03 * SyswideSharedProps.screenHeight,),
                                      DividerLine(),
                                      //Customer Gender field
                                      SizedBox(height: 0.015 * SyswideSharedProps.screenHeight,),
                                      const Text("Gender ?", style: TextStyle(color: Colors.black54, fontSize: 16 ),),
                                      SizedBox(height: 0.01 * SyswideSharedProps.screenHeight,),


                                      Container (
                                        padding: EdgeInsets.fromLTRB(4,  0.0001 * SyswideSharedProps.screenHeight, 0,  0.005 * SyswideSharedProps.screenHeight),
                                        decoration: BoxDecoration( color: Colors.white , borderRadius: BorderRadius.circular(8)  ,border: Border.all(color: Color(0xFFC1C1C1),
                                          width: 1, //                   <--- border width here
                                        ), ),

                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              // filled: true,
                                              // fillColor: Colors.grey[200],
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            ),
                                            value: selectedGender,
                                            hint: Text('Select gender'),
                                            items: [
                                              DropdownMenuItem(
                                                value: 'Male',
                                                child: Text('Male'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Female',
                                                child: Text('Female'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Prefer not to say',
                                                child: Text('Prefer not to say'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Other',
                                                child: Text('Other'),
                                          ),

                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value ;
                                    });
                                  },
                                ),
                                        ),
                                      ),




                                      SizedBox(height: 0.01 * SyswideSharedProps.screenHeight,),
                                      DividerLine(),
                                      SizedBox(height: 0.05 * SyswideSharedProps.screenHeight,),
                                      const Text("**By continuing you are agreeing to our terms and policy at CheapRide", style: TextStyle(color: Color(0xFF9D9B9B), fontSize: 14 ),),

                                      // submit Button
                                      SizedBox(height: 0.03 * SyswideSharedProps.screenHeight,),
                                      Align(
                                        alignment: Alignment.center,

                                        child: SizedBox(
                                          width: SyswideSharedProps.screenWidth * 0.6,
                                          height: SyswideSharedProps.screenHeight * 0.05,
                                          child:
                                      ElevatedButton(
                                      style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5), // <-- Radius
                                      ), textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold ) , backgroundColor: (userName == "") ? Colors.grey : Color(0xFFFF5712) )
                                      ,
                                      onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      //verify the phone number and do the required error handling
                                      //print(phoneNo) ;

                                      if (userName == "") {

//HTTP calls


                                      }

                                      //if user shared his user name than we can proceed
                                      else {
                                      _showloading("Creating Account");
                                      print(userName+ "  " + (selectedGender ?? "Prefer not to say") );

                                          HttpService.createACC(widget.Ph,userName,(selectedGender ?? "Prefer not to say")).then((res) {
                                            print("in func: " + res.code);
                                            if (res.code == "2") {
                                              // go to verify page
                                              Navigator.of(context).pop();
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          Home()
                                                  )
                                              );
                                            }
                                            else {
                                              //some network error TODO
                                              Navigator.of(context).pop();


                                            }
                                          }
                                          ) ;
                                      }
                                      },
                                      child: const Text('Create'),
                                      )

    //
                                          ,
                                        )
                                        ,
                                      ),

                                      SizedBox(height: 0.08 * SyswideSharedProps.screenHeight * (375/393),),
                                    ],
                                  )
                              ),

                              //space at bottom
                              SizedBox(height: 10* (SyswideSharedProps.screenWidth/393),),
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
