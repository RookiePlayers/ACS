import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/enums.dart';
import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/enumsToString.dart';
import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/toggles.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Registeration extends StatefulWidget {
  Registeration({Key key}) : super(key: key);

  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {

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

  
  @override
  Widget build(BuildContext context) {
 
    Toggle showpassword=Toggle(init:false);
    Toggle selectGender=Toggle(init:false);
    Gender _genderGroup=Gender.MALE;
    DegreeType _degree=DegreeType.UNDERGRAD;
    CollegeYear _year=CollegeYear.FIRST;
    EnumTranslator _translator=EnumTranslator();


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
                            decoration: InputDecoration(
                              icon: Icon(Icons.account_box),
                              labelText: "Student ID",
                              hintText: "e.g 1234567",
                              helperText: "check your student card"

                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                            TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: "Password",
                              hintText: "e.g 1234567",
                              helperText: "",
                              suffixIcon: IconButton(icon: Icon(!showpassword.isOn?Icons.visibility:Icons.visibility_off),onPressed: (){
                                
                                setState(() {
                                  showpassword.toggle();
                                });
                              },)

                            ),
                            obscureText: !showpassword.isOn,
                          
                          ),
                        
                          ButtonBar(
                          children: <Widget>[
                            RaisedButton(onPressed: ()=>{},
                            key: Key("loginWithPassword"),
                            child: Text(
                              "Login with Password"
                            ),
                            ),
                            RaisedButton(onPressed: ()=>{},
                            key: Key("loginWithId"),
                            child: Text(
                              "Login with ID"
                            ),
                            )
                          ],  
                          ),
                          TextFormField(
                      
                            decoration: InputDecoration(
                              icon: Icon(Icons.perm_identity),
                              labelText: "Full Name",
                              hintText: "e.g John Doe",
                              helperText: "Firstname Secondname"

                            ),
                          ),
                          TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.cake),
                                labelText: "What's Your Birthday?",
                                suffixIcon: IconButton(icon: Icon(Icons.calendar_today),onPressed: (){
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1955, 1, 1),
                                      maxTime: DateTime.now(), onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                  }, currentTime: DateTime(2002,1,1), locale: LocaleType.en);
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
                            children: <Widget>[
                              RaisedButton(
                              child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child:Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.male, color: Colors.white),
                                  Text("Male",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                  ),
                                  
                                ],
                              )),
                              onPressed: (){

                              },
                              color: Colors.blue
                              ),
                               Text("or",style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Helvetica")),
                              RaisedButton(
                                child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child:Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.female, color: Colors.white ),
                                  Text("Female",
                                  style: TextStyle(
                                    color: Colors.white
                                  )),
                                 
                                ],
                              )
                              ),
                               color: Colors.pink[200].withOpacity(0.5),
                               
                               onPressed: (){

                               },
                              ),
                              
                            ],
                          ),
                           Align(
                            alignment: Alignment.center,
                             child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Text("What's your Level of Study: ",style: TextStyle(color: Colors.black54, fontSize: 20,fontFamily: "Helvetica"),)
                            ),
                          ),
                          ListTile(
                            trailing: Text(_translator.degree(_degree)),
                            title: DropdownButton<DegreeType>(
                              value: DegreeType.UNDERGRAD,
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
                            trailing: Text(_year.toString()),
                            title: DropdownButton<CollegeYear>(
                              value: CollegeYear.FIRST,
                              onChanged: (type){
                                setState(() {
                                  _year=type;
                                });
                              },
                              items:this._yearOptions ,
                            ),
                          )
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
}