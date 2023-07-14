import 'package:flutter/material.dart';
import 'dart:async';
import './../utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cheap_ride/NetworkCalls.dart';
import 'package:cheap_ride/Models.dart' ;
import 'package:shared_preferences/shared_preferences.dart';


class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: 0.002 * SyswideSharedProps.screenHeight,
      child: Container(

        color: Colors.black26,

      )
    );
  }
}

