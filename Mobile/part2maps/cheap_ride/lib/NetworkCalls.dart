import 'dart:async';


import 'dart:convert';
import 'package:cheap_ride/Models.dart';
import 'package:cheap_ride/utility.dart';


import 'package:http/http.dart';

class HttpService {

  static Future<LRes> requestOTP(String No) async {
    final response = await post(
      Uri.parse(SyswideSharedProps.baseURL +  'users/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'httpMethod' : 'POST'
       },
      body: jsonEncode(<String, String>{
        "phone" : No,
        "otp" : "",
        "resend" : ""
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body)) ;
      var res = LRes.fromJson(jsonDecode(response.body));
      print(res.code) ;
      return res ;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  static Future<LRes> verifyOTP(String  No, String OTP) async {
    print(No.toString() +  OTP.toString()) ;
    final response = await post(
      Uri.parse( SyswideSharedProps.baseURL +  'users/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'httpMethod' : 'POST'
      },
      body: jsonEncode(<String, String>{
        "phone" : No,
        "otp" : OTP,
        "resend" : ""
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body)) ;
      return LRes.fromJson(jsonDecode(response.body));
    } else {

      return LRes(
        status: "400",
        code: "NA",
        des : "NA",
        usertoken : "NA",

      ); ;
    }
  }

  //Create account
  static Future<LRes> createACC(String  No, String Name, String gender) async {
    print(No.toString() +  Name.toString()+ gender) ;
    final response = await put(
      Uri.parse( SyswideSharedProps.baseURL +  'users/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'httpMethod' : 'PUT'
      },
      body: jsonEncode(<String, String>{
        "username" : Name,
        "firstname" : Name,
        "lastname" : gender,
        "phone" : No,
        "email" : ""
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      try {
        print(jsonDecode(response.body)) ;
        return LRes.fromJson(jsonDecode(response.body));
      } catch(e) {
        print("invalid response");
        return LRes(
          status: "400",
          code: "NA",
          des: "NA",
          usertoken: "NA",

        );;
      }



    } else {
      print(jsonDecode(response.body)) ;

        return LRes(
          status: "400",
          code: "NA",
          des: "NA",
          usertoken: "NA",

        );;

    }
  }

//get drivers
  static Future<List<dynamic>> getDrivers(String  lat, String long) async {
    final response = await post(
      Uri.parse( SyswideSharedProps.baseURL + 'features/getDriversNearUSer/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'httpMethod' : 'POST'
      },
      body: jsonEncode(<String, String>{
        "usertoken": "LXI_NQCINBYTVVK0&8V0K0%41607066T",
        "lat" : lat ,
        "long" : long
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final parsedJson = jsonDecode(response.body);
      var keys = parsedJson.keys ;
      var DriversList = [] ;
      for (var key in  keys) {
        var driver = Drivers.fromJson(parsedJson[key]);
        DriversList.add( driver);

      }

      return DriversList ;



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