
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiCalling{
  static final ApiCalling _apiCalling = ApiCalling._internal();

  factory ApiCalling() {
    return _apiCalling;
  }

  ApiCalling._internal();



  Future<dynamic> signup_api(Map<String,String> body) async
  {
    var request = http.MultipartRequest('POST', Uri.parse('https://career-finder.aaratechnologies.in/job/api/signUp'));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json_response  = jsonDecode(await response.stream.bytesToString());
      print(json_response['message']);
      return json_response;
    }
  }
  Future<dynamic> login_api(Map<String,String> body) async
  {
    var request = http.MultipartRequest('POST', Uri.parse('https://career-finder.aaratechnologies.in/job/api/login'));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json_response  =  jsonDecode(await response.stream.bytesToString());
      debugPrint("$json_response");
      return json_response;
    }
  }
  Future<dynamic> get_job() async
  {
    var request = http.Request('GET', Uri.parse('https://career-finder.aaratechnologies.in/job/api/all_job'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json_response  =  jsonDecode(await response.stream.bytesToString());
      return json_response;
    }
  }
}