import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled/Helper/ApiCalling.dart';
import 'package:untitled/Helper/ApiHelper.dart';
import 'package:untitled/pages/Login.dart';
import 'package:untitled/res/Colors.dart';
import 'package:untitled/Helper/enum.dart';
import 'package:untitled/service/SinupBloc.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  RadioOptionSignup? _radioOption = RadioOptionSignup.seeker;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  SignupBloc _signupBloc = SignupBloc();
  final _formKey = GlobalKey<FormState>();

  void set_selected_radio(RadioOptionSignup? val) {
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
                    "Signup",
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
                        child: RadioListTile<RadioOptionSignup>(
                          value: RadioOptionSignup.seeker,
                          groupValue: _radioOption,
                          onChanged: (RadioOptionSignup? val) {
                            set_selected_radio(val);
                          },
                          title: Text("Seeker",
                              style: TextStyle(
                                  color: _radioOption == RadioOptionSignup.seeker
                                      ? App_Colors.blue
                                      : App_Colors.text_color)),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<RadioOptionSignup>(
                          value: RadioOptionSignup.recruiter,
                          groupValue: _radioOption,
                          onChanged: (RadioOptionSignup? val) {
                            set_selected_radio(val);
                          },
                          title: Text("Recruiter",
                              style: TextStyle(
                                  color:
                                      _radioOption == RadioOptionSignup.recruiter
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
                        return 'please enter valid Email';
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
                      if(e!.length>0 ){
                        return null;
                      }else{
                        return 'please enter valid Name';
                      }
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    validator: (e){
                      if(e!.length>0 && e.length>10){
                        return null;
                      }else{
                        return 'please enter valid Number';
                      }
                    },
                    controller: _numberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Your Number',
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    validator: (e){
                      if(e!.length>0 && e.contains("@")){
                        return null;
                      }else{
                        return 'please enter valid Password';
                      }
                    },
                    controller: _passController,
                    obscureText: true,
                    //keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Your Password',
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  StreamBuilder<dynamic>(
                    stream: _signupBloc.signupStream,
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
                                "Please Check internet Connection",
                                style: TextStyle(fontSize: 16)),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      });
                        return Container(
                            height: size.height * 0.05,
                            width: size.width * 0.4,
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Map<String, String> data = {
                                    'type': _radioOption == RadioOptionSignup.recruiter
                                        ? 'recruiter'
                                        : 'seeker',
                                    'email': _emailController.text,
                                    'name': _nameController.text,
                                    'mno': _numberController.text,
                                    'ps': _passController.text
                                  };
                                  _signupBloc.signup_api(data);

                                  debugPrint("${_radioOption}");
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
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
                                  constraints: const BoxConstraints(
                                      minWidth: 88.0, minHeight: 36.0),
                                  // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Sign up',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ));
                      }
                      else if(snapshot.hasData && snapshot.data != null && snapshot.data.status == Status.COMPLETED)
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
                        return Container(
                            height: size.height * 0.05,
                            width: size.width * 0.4,
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Map<String, String> data = {
                                    'type': _radioOption == RadioOptionSignup.recruiter
                                        ? 'recruiter'
                                        : 'seeker',
                                    'email': _emailController.text,
                                    'name': _nameController.text,
                                    'mno': _numberController.text,
                                    'ps': _passController.text
                                  };
                                  _signupBloc.signup_api(data);

                                  debugPrint("${_radioOption}");
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
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
                                  constraints: const BoxConstraints(
                                      minWidth: 88.0, minHeight: 36.0),
                                  // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Sign up',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ));
                      }
                      else
                        {
                          return Container(
                              height: size.height * 0.05,
                              width: size.width * 0.4,
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Map<String, String> data = {
                                      'type': _radioOption == RadioOptionSignup.recruiter
                                          ? 'recruiter'
                                          : 'seeker',
                                      'email': _emailController.text,
                                      'name': _nameController.text,
                                      'mno': _numberController.text,
                                      'ps': _passController.text
                                    };
                                    _signupBloc.signup_api(data);

                                    debugPrint("${_radioOption}");
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
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
                                    constraints: const BoxConstraints(
                                        minWidth: 88.0, minHeight: 36.0),
                                    // min sizes for Material buttons
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Sign up',
                                      textAlign: TextAlign.center,
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              ));
                        }

                    }
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: App_Colors.blue, fontSize: 18),
                        ),
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

  Future<void> signup_status(dynamic response) async{
    if(response['staus'] == true)
    {
      
    }
  }
}
