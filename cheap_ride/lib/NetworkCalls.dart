import 'dart:async';


import 'dart:convert';
import 'package:cheap_ride/Models.dart';


import 'package:http/http.dart';

class HttpService {

  static Future<LRes> requestOTP(String No) async {
    final response = await post(
      Uri.parse('http://127.0.0.1:8000/users/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "phone" : "8360476948",
        "otp" : "",
        "resend" : ""
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body)) ;
      return LRes.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
  //base url

  final String baseURL = "http://127.0.0.1:8000/users/" ;

  //using my aws flask Server
  final String citiesURL = "http://13.127.60.72:5000//cities";



  Future<List<String>> getCitys() async {
    Response res = await get( Uri.parse(citiesURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);





      List<String> cities =
      body.map( (dynamic item) => item as String,)
          .toList();

      print(cities);
      return cities;
    } else {
      throw "Unable to retrieve Cities.";
    }
  }




  /* IGnore***


   */
  Future<List<Post>> getPosts( ) async {
    Response res = await  get( Uri.parse(citiesURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);





      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
      )
          .toList();

      print(posts);
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}