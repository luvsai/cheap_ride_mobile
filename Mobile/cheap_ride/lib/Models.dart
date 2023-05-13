import 'package:flutter/foundation.dart';


class LRes {

   final String status , code, des , usertoken  ;

  const LRes({required this.status, required this.code , required this.des, required this.usertoken});

  factory LRes.fromJson(Map<String, dynamic> json) {
    return LRes(
      status: json['status'],
      code: json['code'],
      des : json['des'],
      usertoken : json['usertoken'],

    );
  }
}

class Drivers {
  // {"id": "1", "lat": 12.9322, "long": 77.69829, "vehicle": "auto"}
  final String id  , vehicle  ;

  final double lat, long;

  const Drivers({required this.id, required this.lat , required this.long, required this.vehicle});

  factory Drivers.fromJson(Map<String, dynamic> json) {
    return Drivers(
      id: json['id'],
      lat: json['lat'],
      long : json['long'],
      vehicle : json['vehicle'],

    );
  }
}













// Note :: rough for sample procedure *IGnore*
class Post {
  int userId =0;
  int id =0;
  String title ="";
  String body ="";

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}