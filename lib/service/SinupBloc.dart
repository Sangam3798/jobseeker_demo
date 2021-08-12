


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/Helper/ApiCalling.dart';
import 'package:untitled/Helper/ApiHelper.dart';

class SignupBloc
{
  ApiCalling? _apiCalling_signup_job;
  StreamController? _streamController;

  StreamSink<dynamic> get signupSink => _streamController!.sink;

  Stream<dynamic> get signupStream => _streamController!.stream;

  SignupBloc()
  {
    _apiCalling_signup_job =  ApiCalling();
    _streamController = StreamController<ApiResponseHelper<dynamic>>();
  }

  signup_api(Map<String,String>body)
  async {
    signupSink.add(ApiResponseHelper.loading('Fetching Blocked Users'));
    try {
      var   users = await _apiCalling_signup_job!.signup_api(body);
      signupSink.add(ApiResponseHelper.completed(users));
    } catch (e) {
      signupSink.add(ApiResponseHelper.error(e.toString()));
      debugPrint("$e");
    }
  }

  void disposeStream()
  {
    _streamController?.close();
  }
}