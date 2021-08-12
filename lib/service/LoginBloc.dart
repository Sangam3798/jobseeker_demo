


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Helper/ApiCalling.dart';
import 'package:untitled/Helper/ApiHelper.dart';

class LoginBloc
{
  ApiCalling? _apiCalling_login_job;
  StreamController? _streamController;

  StreamSink<dynamic> get loginSink => _streamController!.sink;

  Stream<dynamic> get loginStream => _streamController!.stream;

  LoginBloc()
  {
    _apiCalling_login_job =  ApiCalling();
    _streamController = StreamController<ApiResponseHelper<dynamic>>();
  }

  login_api(Map<String,String>body)
  async {
    loginSink.add(ApiResponseHelper.loading('Fetching Blocked Users'));
    try {
      var   users = await _apiCalling_login_job!.login_api(body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool value  =  await prefs.setString('signupStatus', "${users['staus']}");

      debugPrint("value of $value");
      loginSink.add(ApiResponseHelper.completed(users));
    } catch (e) {
      loginSink.add(ApiResponseHelper.error(e.toString()));
      debugPrint("$e");
    }
  }

  void disposeStream()
  {
    _streamController?.close();
  }
}