import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/toggles.dart';
import 'package:acs_app/AUTHENTICATION/REGISTER/UI/main.dart';
import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:flutter/material.dart';

import '../../../NavigationControl.dart';
class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   TextEditingController studentIdText=new TextEditingController();
    TextEditingController passwordText=new TextEditingController();
     Toggle showpassword=Toggle(init:false);
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
                      "Welcome back!",
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
                          RaisedButton(
                            child: Text("Login"),
                            onPressed: (){
                              _login(studentIdText.text, passwordText.text);
                            },
                          ),
                          FlatButton(
                            child: Text("Not Registered yet? Register here"),
                            textColor: Colors.blue[200],
                            onPressed: (){
                                 NavigationControl(nextPage: Registeration()).navTo(context);
                            },
                          )
                        ]
                      )

                      )

                    )
                 ]
               )
             ]

            )
          )
       ));


                       
  
  }
  _login(id,password){
   var auth= AuthDB(context: context);
   auth.login(id, password);
  }

}