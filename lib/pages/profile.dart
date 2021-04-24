import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bookservice/apis/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../constanc.dart';
import 'home.dart';

class Profile extends StatefulWidget {

  bool dialogNav = false;

  @override
  MapScreenState createState() => MapScreenState();

  Profile({Key key, @required this.dialogNav}) : super(key: key);

}



enum Gender { Male, Female }

class MapScreenState extends State<Profile>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  bool _fnamevalidate=false;
  bool _emailvalidate=false;
  bool _mobilevalidate=false;

  var _emailError="";
  int userID=0;
  var _fnameError="First name should not be empty";
  var _mobileError="Enter a valid mobile number (+971 xx xxxxxxx)";
  final FocusNode myFocusNode = FocusNode();

  Gender _character = Gender.Male;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchAlbum().then((profile) {
    ProfileDetails  pd =profile;
    userID = profile.id;

    setState(() {
      fnameController.text = profile.first_name;
      lnameController.text = profile.last_name;
      emailController.text = profile.email;
      mobileController.text = profile.phone_number;

      if (profile.gender == 1) {
        _character = Gender.Male;
      }
      else {
        _character = Gender.Female;
      }
    });

    });


  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(backgroundColor: Color(0xFF213c56),
          title: Text("Profile",style: TextStyle(color: Colors.white,fontFamily: 'Amiko', fontSize: 17),),
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 190.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/images/user_profile.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            // Padding(
                            //     padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            //     child: new Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: <Widget>[
                            //         // new CircleAvatar(
                            //         //   backgroundColor: Colors.red,
                            //         //   radius: 25.0,
                            //         //   child: new Icon(
                            //         //     Icons.camera_alt,
                            //         //     color: Colors.white,
                            //         //   ),
                            //         // )
                            //       ],
                            //     )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'First Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      decoration:  InputDecoration(
                                        hintText: "Enter Your First Name",
                                        errorText: _fnamevalidate ? _fnameError : null,
                                      ),
                                      style: TextStyle(
                                        color: _status ? Colors.grey : Colors.black
                                      ),
                                      controller: fnameController,
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Last Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter your Last Name"),
                                      style: TextStyle(
                                          color: _status ? Colors.grey : Colors.black
                                      ),
                                      controller: lnameController,
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      decoration:  InputDecoration(
                                          hintText: "Enter Email ID",
                                        errorText: _emailvalidate ? _emailError : null,),
                                      style: TextStyle(
                                          color: _status ? Colors.grey : Colors.black
                                      ),
                                      enabled: !_status,
                                      controller: emailController,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration:  InputDecoration(
                                      hintText: "Enter Mobile Number (+971 xx xxxxxxx)",
                                        errorText: _mobilevalidate ? _mobileError : null,),
                                      enabled: !_status,
                                      style: TextStyle(
                                          color: _status ? Colors.grey : Colors.black
                                      ),
                                      controller: mobileController,
                                    ),
                                  ),
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new ListTile(
                                        title: const Text('Male'),
                                        leading: Radio(
                                          value: Gender.Male,
                                          groupValue: _character,
                                          onChanged: (Gender value) {
                                            setState(() {
                                              if(_status==false){
                                                _character = value;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new ListTile(
                                        title: const Text('Female'),
                                        leading: Radio(
                                          value: Gender.Female,
                                          groupValue: _character,
                                          onChanged: (Gender value) {
                                            setState(() {
                                              if(_status==false){
                                                _character = value;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          // Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 25.0, right: 25.0, top: 2.0),
                          //     child: new Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: <Widget>[
                          //         Flexible(
                          //           child: Padding(
                          //             padding: EdgeInsets.only(right: 10.0),
                          //             child: new TextField(
                          //               decoration: const InputDecoration(
                          //                   hintText: "Enter Pin Code"),
                          //               enabled: !_status,
                          //             ),
                          //           ),
                          //           flex: 2,
                          //         ),
                          //         Flexible(
                          //           child: new TextField(
                          //             decoration: const InputDecoration(
                          //                 hintText: "Enter State"),
                          //             enabled: !_status,
                          //           ),
                          //           flex: 2,
                          //         ),
                          //       ],
                          //     )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }



  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {

                        _submit();

                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {

                         fnameController.text="";
                         lnameController.text="";
                         emailController.text="";
                         mobileController.text="";

                         _fnamevalidate=false;
                         _emailvalidate=false;
                         _mobilevalidate=false;

                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
  void _submit(){

    var fname=fnameController.text.toString();
    var lname=lnameController.text.toString();
    var email=emailController.text.toString();
    var mobile=mobileController.text.toString();
    var gender=_character.toString();

    setState(() {

      bool disableEdit=true;

      if ((fnameController.text.isEmpty)) {
        _fnamevalidate = true;

        disableEdit=false;

      }
      else{
        _fnamevalidate = false;
      }


      if (!(emailController.text.contains('@'))) {
        _emailvalidate = true;
        _emailError="Enter a valid email Id";

        disableEdit=false;

      }
      else{
        _emailvalidate = false;
      }

      if (!(mobileController.text.contains('+971')) || (mobileController.text.length < 12)) {
        _mobilevalidate = true;

        disableEdit=false;

      }
      else{
        _mobilevalidate = false;
      }

      if(disableEdit){
        _status = true;
        FocusScope.of(context).requestFocus(new FocusNode());


        postData();

        if(widget.dialogNav==true) {

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomePage()));

        }

      }

    });



  }

  Future<ProfileDetails> fetchAlbum() async {

    var token = await CacheService.instance.getToken();
    final response = await http.get(
      Constant.Host+'/profileDetails/info',
      headers: {HttpHeaders.authorizationHeader: token},
    );
    final responseJson = jsonDecode(response.body);

    print(responseJson);

    return ProfileDetails.fromJson(responseJson['result']);
  }

  Future<String> postData() async {

    var fname=fnameController.text.toString();
    var lname=lnameController.text.toString();
    var email=emailController.text.toString();
    var mobile=mobileController.text.toString();
    var gender=_character.toString();

    int _gender = 1;

    if(gender=="Gender.Male"){
      _gender =1;
    }
    else{
      _gender=2;
    }

    var jsonMap = {

      'first_name': fname,
      'last_name': lname,
      'email': email,
      'gender': _gender,
      'phone_number': mobile

    };

    String jsonStr = jsonEncode(jsonMap);
    print(jsonMap);

    var token = await CacheService.instance.getToken();

    var _result;
    http.put((Constant.Host+'profileDetails/$userID'+'/'), body: jsonStr , headers : {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
    }).then((result) {
      print(result.statusCode);

      if(result.statusCode==200){
        Toast.show("Profile details saved successfully.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
      else{
        Toast.show("Error while trying to save data.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }

      print(result.body);
      _result = result;
    });

    return _result.statusCode;
  }

  String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new InkWell(
        radius: 14.0,
        child: Text(
            'Edit',
          style: TextStyle(
              fontSize: 16.0,
            fontFamily: 'Amiko',
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}






