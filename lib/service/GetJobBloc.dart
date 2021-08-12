


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/Helper/ApiCalling.dart';
import 'package:untitled/Helper/ApiHelper.dart';

class GetJobBloc
{
  ApiCalling? _apiCalling_get_job;
  StreamController? _streamController;

  StreamSink<dynamic> get getJobSink => _streamController!.sink;

  Stream<dynamic> get getJobStream => _streamController!.stream;

  GetJobBloc()
  {
    _apiCalling_get_job =  ApiCalling();
    _streamController = StreamController<ApiResponseHelper<dynamic>>();
    get_job_from_api();
  }

  get_job_from_api()
  async {
    getJobSink.add(ApiResponseHelper.loading('Fetching Blocked Users'));
    try {
      var   users = await _apiCalling_get_job!.get_job();
      getJobSink.add(ApiResponseHelper.completed(users));
    } catch (e) {
      getJobSink.add(ApiResponseHelper.error(e.toString()));
      debugPrint("$e");
    }
  }

void disposeStream()
{
  _streamController?.close();
}
}