import 'dart:async';
import 'dart:io';

import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/enums.dart';
import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/enumsToString.dart';
import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/toggles.dart';
import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/DATABASE/UL/courses.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class Registeration extends StatefulWidget {
  final VoidCallback onSignedIn;
  Registeration({Key key,this.onSignedIn}) : super(key: key);

  _RegisterationState createState() => _RegisterationState(onSignedIn:this.onSignedIn);
}

class _RegisterationState extends State<Registeration> {
final VoidCallback onSignedIn;
_RegisterationState({this.onSignedIn});
  final List<DropdownMenuItem<DegreeType>> _degreeOptions=[
    DropdownMenuItem(
      value: DegreeType.UNDERGRAD,
      child: Text("Under Graduate")
    ),
     DropdownMenuItem(
      value: DegreeType.MASTERS,
      child: Text("Masters")
    ),
     DropdownMenuItem(
      value: DegreeType.DOCTORAL,
      child: Text("Doctoral")
    ),

  ];
  final List<DropdownMenuItem<CollegeYear>> _yearOptions=[
    DropdownMenuItem(
      value: CollegeYear.FIRST,
      child: Text("I'm Just starting out")
    ),
     DropdownMenuItem(
      value: CollegeYear.SECOND,
      child: Text("Not My First Rodeo")
    ),
     DropdownMenuItem(
      value: CollegeYear.THIRD,
      child: Text("My Third Time Doing this")
    ),
     DropdownMenuItem(
      value: CollegeYear.FORTH,
      child: Text("Graduating this year")
    ),
     DropdownMenuItem(
      value: CollegeYear.FIFTH,
      child: Text("My Course is Extra Long")
    ),
    

  ];
   List<DropdownMenuItem<Course>> _courses=[

  ];

     Toggle showpassword=Toggle(init:false);
    Toggle selectGender=Toggle(init:false);
    Toggle selectLoginType=Toggle(init:false);
    bool login_P=true;
    bool login_Id=false;
    

    Gender _genderGroup=Gender.MALE;
    Relationship _relationship=Relationship.SINGLE;
    DegreeType _degree=DegreeType.UNDERGRAD;
    CollegeYear _year=CollegeYear.FIRST;
    EnumTranslator _translator=EnumTranslator();

  Country _selectedCupertinoCountry;

  StreamSubscription _subscription;
  Course _course;
  TextEditingController studentIdText=new TextEditingController();
    TextEditingController passwordText=new TextEditingController();
      TextEditingController fullnameText=new TextEditingController();
        TextEditingController birthdayText=new TextEditingController();
          TextEditingController countryText=new TextEditingController();
            TextEditingController bioText=new TextEditingController();


@override
    void dispose()
    {
      if(_subscription!=null)
      _subscription.cancel;
    }
  @override
  void initState()
  {
    initializeDateFormatting("en_EN");
    print("-------------");
    CourseDB cdb=CourseDB();
    cdb.getCourses(_updateCourseList).then((StreamSubscription s) => _subscription = s);
    super.initState();
  }
  void _updateCourseList(Course c) {

    setState(() {

      //for (Course c in courses.courses) {
        print(">>>"+c.name);
        _courses.add(
          DropdownMenuItem(
              value: c,
              child: Text(c.name)
          ),
        );
     // }


    });
  }
   File _image=null;
   DateTime _date=DateTime.now();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
 
 
    return Scaffold(
        
        body:Container(
    // color: Colors.red.withOpacity(0.7),
          child: Center(

            child:ListView(
             //shrinkWrap: true,
             children: <Widget>[
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 
                 children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121)
                      ),
                    )
                  ), 
                  
                    Form(
                    
                      child:Container(
                     
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: studentIdText,
                            decoration: InputDecoration(
                              icon: Icon(Icons.account_box),
                              labelText: "Student ID",
                              hintText: "e.g 1234567",
                              helperText: "check your student card"

                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                            TextFormField(
                              controller: passwordText,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: "Password",
                              hintText: "e.g *******",
                              helperText: "",
                              suffixIcon: IconButton(icon: Icon(!showpassword.isOn?Icons.visibility:Icons.visibility_off),onPressed: (){
                                
                                setState(() {
                                  showpassword.toggle();
                                });
                              },)

                            ),
                            obscureText: !showpassword.isOn,
                          
                          ),
                        /*
                          ButtonBar(
                          children: <Widget>[
                            RaisedButton(onPressed: (){
                              setState(() {
                                 login_P=true;login_Id=false;
                              });}
                             ,
                            key: Key("loginWithPassword"),
                            color: login_P?Colors.blue:Colors.white54,
                            textColor:login_P?Colors.white:Colors.black,
                            child: Text(
                              "Login with Password"
                            ),
                            ),
                            RaisedButton(onPressed: (){
                            setState(() {
                              login_P=false;login_Id=true;
                            });
                              
                            
                            },
                            key: Key("loginWithId"),
                            color:login_Id?Colors.blue:Colors.white54,
                             textColor:login_Id?Colors.white:Colors.black,
                            child: Text(
                              "Login with ID"
                            ),
                            )
                          ],  
                      ),*/
                          Align(
                            alignment: Alignment.center,
                             child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: GestureDetector(
                                  onTap:getImage,
                                    child:CircleAvatar(
                                    radius: 50, 
                                    backgroundImage:  _image!=null?FileImage(_image):null,
                                    child: _image!=null?Container():Icon(Icons.add_a_photo),
                                     
                                  )
                                  )
                            ),
                          ),
                          TextFormField(
                            controller: fullnameText,
                            decoration: InputDecoration(
                              icon: Icon(Icons.perm_identity),
                              labelText: "Full Name",
                              hintText: "e.g John Doe",
                              helperText: "Firstname Secondname"

                            ),
                          ),
                          TextFormField(
                            controller: birthdayText,
                              decoration: InputDecoration(
                                icon: Icon(Icons.cake),
                                labelText: "What's Your Birthday?",
                                suffixIcon: IconButton(icon: Icon(Icons.calendar_today),onPressed: (){
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1955, 1, 1),
                                      maxTime: DateTime.now(), onChanged: (date) {
                                        _date=date;
                                    print('change $date');
                                    birthdayText.text=new DateFormat.yMMMd().format(date);
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    _date=date;
                                      birthdayText.text=new DateFormat.yMMMd().format(date);

                                  }, currentTime: DateTime(2002,1,1), locale: LocaleType.en);
                                                               },

                              ),
                            )
                          ),
                           TextFormField(
                             controller: countryText,
                              decoration: InputDecoration(
                                icon: Icon(FontAwesomeIcons.globeAfrica),
                                labelText: "What's Your Country of Origin?",
                                helperText: "click the flag for options",
                                suffixIcon: IconButton(icon: Icon(Icons.flag),onPressed: (){
                                 _openCupertinoCountryPicker();
                              },

                              ),
                            )
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                          Align(
                            alignment: Alignment.center,
                             child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Text("Are you",style: TextStyle(color: Colors.black54, fontSize: 20,fontFamily: "Helvetica"),)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                              Row(
                                children:<Widget>[
                           Radio(
                               groupValue: _genderGroup,
                               value: Gender.MALE,
                               onChanged: ((type){
                                 setState(() {
                                   _genderGroup=type;
                                 });
                                 
                               }),
                             ),
                               Text("Male",style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Helvetica")),
                                ]),
                               Text("or",style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Helvetica")),
                               Row(
                                children:<Widget>[
                                Radio(
                               groupValue: _genderGroup,
                               value: Gender.FEMALE,
                               onChanged: ((type){
                                setState(() {
                                   _genderGroup=type;
                                 });
                               }),
                              
                             ),
                               Text("Female",style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Helvetica")),
                                ])
                            ]),
                           Align(
                            alignment: Alignment.center,
                             child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Text("What's your Level of Study: ",style: TextStyle(color: Colors.black54, fontSize: 20,fontFamily: "Helvetica"),)
                            ),
                          ),
                          ListTile(
                            trailing: Text(""),
                            title: DropdownButton<DegreeType>(
                              value: _degree,
                              onChanged: (type){
                                setState(() {
                                  _degree=type;
                                });
                              },
                              items:this._degreeOptions ,
                            ),
                          ),
                           Align(
                            alignment: Alignment.center,
                             child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Text("What Year are you in: ",style: TextStyle(color: Colors.black54, fontSize: 20,fontFamily: "Helvetica"),)
                            ),
                          ),
                          ListTile(
                            trailing: Text(""),
                            title: DropdownButton<CollegeYear>(
                              value: _year,
                              onChanged: (type){
                                setState(() {
                                  _year=type;
                                });
                              },
                              items:this._yearOptions ,
                            ),
                          ),
                           ListTile(
                            trailing: Text(""),
                            title: DropdownButton<Course>(
                              value: _course,
                              hint: Text("What Course do you study?"),
                              onChanged: (type){
                                setState(() {
                                  _course=type;
                                });
                              },
                              items:this._courses ,
                            ),
                          ),
                           Align(
                            alignment: Alignment.center,
                             child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Text("Bio ",style: TextStyle(color: Colors.black54, fontSize: 20,fontFamily: "Helvetica"),)
                            ),
                          ),
                          TextFormField(
                            controller: bioText,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Tell us about yourself",
                              helperText: "Keep it short.",
                              labelText: "About You"
                            ),
                            maxLines: 4,
                          ),
                            Align(
                            alignment: Alignment.center,
                             child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Text("For the Record, Are you  ",style: TextStyle(color: Colors.black54, fontSize: 20,fontFamily: "Helvetica"),)
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                           Row(
                           
                            children: <Widget>[
                             Radio(
                               groupValue: _relationship,
                               value: Relationship.SINGLE,
                               onChanged: ((type){
                                 setState(() {
                                   _relationship=type;
                                 });
                               }),
                             ),
                               Text("Single",style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Helvetica")),
                            ]),
                               Text("or",style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Helvetica")),
                            Row(
                              children:<Widget>[
                              Radio(
                               groupValue: _relationship,
                               value: Relationship.TAKEN,
                               onChanged: ((type){
                                setState(() {
                                   _relationship=type;
                                 });
                               }),
                              
                             ),
                               Text("In a Relationship",style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Helvetica")),
                            ])
                            ],
                          ),
                         
                          RaisedButton(
                            child: Text("REGISTER"),
                            onPressed: (){
                              _register();
                            },
                          ),
                          RaisedButton(
                            child: Text("Save Courses"),
                            onPressed: (){
                              _saveCourses();
                            },
                          ),
                          
                        ],
                      ),
                    )
                    
                  ),
                 ],
               )
              
             
              
            ],
          )
          ) 
        ),
      
    );
  }
   void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: 300.0,
          onValuePicked: (Country country) =>
              setState((){_selectedCupertinoCountry = country;countryText.text=country.name;}),
        );
      });
      void _register(){
        var fn,sn;
        List<String> fullname=fullnameText.text.split(" ");
        var i=0;
        for (var s in fullname) {
          switch (i) {
            case 0:
              fn=s;
              break;
            default:sn=s;
          }
          i++;
        }
      print("-------------------");
        Profile profile=Profile(
          bio:bioText.text,
          id: studentIdText.text,
          country: countryText.text,
          course: _course.code,
          degree: _translator.degree(_degree),
          dob: _date.millisecondsSinceEpoch,
          email: studentIdText.text+"@studentmail.ul.ie",
          first_name: fn,
          last_name: sn,
          gender: _translator.gender(_genderGroup),
          image:_image!=null?_image.path:"",
          loginWithId: login_Id,
          single: _translator.relationship_bool(_relationship),
          year: _translator.collegeYear(_year),
          friends: [],
          confirmed: false
          
        );
        print(profile.toString());
        AuthDB(profile:profile,context: context).saveAuth(passwordText.text, profile.id+"@studentmail.ul.ie",_image);
      }
      void _saveCourses(){
        List<Course> courses=[
      new Course(code: "LM121",name:"Computer Science",discipline: "Engineering",length: 4,leader: "Chris Exton"),
      new Course(code: "LM063",name:"Technology Management",discipline: "Engineering",length: 4,leader: "Dr Alan Ryan"),
      new Course(code: "LM076",name:"Product Design and Technology",discipline: "Engineering",length: 4,leader: "Dermot Mclnerney"),
      new Course(code: "LM121",name:"Aeronautical Engineering",discipline: "Engineering",length: 4,leader: "Ronan O Higgins"),

    ];
    for (var c in courses) {
       CourseDB().saveCourses(c);
    }
   


 
}
}