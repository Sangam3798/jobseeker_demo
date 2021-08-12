
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled/Helper/ApiHelper.dart';
import 'package:untitled/pages/HomeScreen.dart';
import 'package:untitled/pages/SignupScreen.dart';
import 'package:untitled/res/Colors.dart';
import 'package:untitled/Helper/enum.dart';
import 'package:untitled/service/LoginBloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RadioOptionLogin? _radioOption = RadioOptionLogin.seeker;
  TextEditingController _emailController  = TextEditingController();
  TextEditingController _passController  =  TextEditingController();
  LoginBloc _loginBloc =  LoginBloc();
  final _formKey = GlobalKey<FormState>();


  void set_selected_radio(RadioOptionLogin? val) {
    setState(() {
      _radioOption = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: double.infinity,
          padding: EdgeInsets.only(
              top: size.height * 0.08, bottom: 20, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: App_Colors.blue,
                        fontSize: size.height * 0.03),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: RadioListTile<RadioOptionLogin>(
                          value: RadioOptionLogin.seeker,
                          groupValue: _radioOption,
                          onChanged: (RadioOptionLogin? val) {
                            set_selected_radio(val);
                          },
                          title: Text("Seeker",
                              style: TextStyle(
                                  color: _radioOption == RadioOptionLogin.seeker
                                      ? App_Colors.blue
                                      : App_Colors.text_color)),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<RadioOptionLogin>(
                          value: RadioOptionLogin.recruiter,
                          groupValue: _radioOption,
                          onChanged: (RadioOptionLogin? val) {
                            set_selected_radio(val);
                          },
                          title: Text("Recruiter",
                              style: TextStyle(
                                  color: _radioOption == RadioOptionLogin.recruiter
                                      ? App_Colors.blue
                                      : App_Colors.text_color)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    validator: (e){
                      if(e!.length>0 && e.contains("@")){
                        return null;
                      }else{
                        return 'please enter valid data';
                      }
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    validator: (e){
                      if(e!.length>0){
                        return null;
                      }else{
                        return 'please enter valid data';
                      }
                    },
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Your Password',
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  StreamBuilder<dynamic>(
                    stream: _loginBloc.loginStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData && snapshot.data != null && snapshot.data.status == Status.LOADING)
                      {
                        return CircularProgressIndicator();
                      }
                      else if(snapshot.hasData && snapshot.data != null && snapshot.data.status == Status.ERROR)
                      {
                        SchedulerBinding.instance!
                            .addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Please Check internet connection",
                                  style: TextStyle(fontSize: 16)),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        });
                        return CircularProgressIndicator();
                      }
                      else if(snapshot.hasData && snapshot.data != null && snapshot.data.status == Status.COMPLETED)
                      {

                        if(snapshot.data.data['staus'] == 'true')
                        {
                          WidgetsBinding.instance!.addPostFrameCallback((_){

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));

                          });
                        }
                        else
                          {
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      snapshot.data.data['message'],
                                      style: TextStyle(fontSize: 16)),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            });
                          }
                        return Container(
                            height: size.height*0.05,
                            width: size.width*0.4,
                            child: RaisedButton(
                              onPressed: () {
                                if(_formKey.currentState!.validate())
                                {
                                  _loginBloc.login_api({
                                    'type': _radioOption == RadioOptionSignup.recruiter
                                        ? 'recruiter'
                                        : 'seeker',
                                    'email': _emailController.text,
                                    'ps': _passController.text
                                  });
                                }
                                // else
                                // {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(content: Text("Field Cannot be empty")));
                                // }
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF42A5F5),
                                      Color(0xFF1976D2),
                                      Color(0xFF0D47A1),

                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white,fontSize: 20.0),
                                  ),
                                ),
                              ),
                            )
                        );
                      }
                      else
                        {
                          return Container(
                              height: size.height*0.05,
                              width: size.width*0.4,
                              child: RaisedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate())
                                  {
                                    _loginBloc.login_api({
                                      'type': _radioOption == RadioOptionSignup.recruiter
                                          ? 'recruiter'
                                          : 'seeker',
                                      'email': _emailController.text,
                                      'ps': _passController.text
                                    });
                                  }
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                padding: const EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF42A5F5),
                                        Color(0xFF1976D2),
                                        Color(0xFF0D47A1),

                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white,fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              )
                          );
                        }

                    }
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?",style: TextStyle(fontSize: 18),),
                      InkWell(
                        onTap: ()
                        {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                        },
                        child: Text("Register",style: TextStyle(color: App_Colors.blue,fontSize: 18),),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
