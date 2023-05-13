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