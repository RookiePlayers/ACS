import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Setting.dart';

class SettingsPage extends StatefulWidget
{
  Setting setting;
  Profile user=null;
  SettingsPage({
    this.setting,
    this.user
  });

  SettingState createState()=>SettingState(setting: setting,user:user);
}
class SettingState extends State<SettingsPage>
{
  Profile user;
  Setting setting;
  SettingState({
    this.setting,
    this.user
  });

  bool midnight=true;
  bool daylight=false;
  bool evening=false;
  bool disableNotifications=false;

  @override
  void initState() {
    // TODO: implement initState
   
    disableNotifications=!setting.notification;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
        appBar:AppBar(
          title: new Text("Settings"),
          leading: new Icon(Icons.settings),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body:new ListView(

          padding: const EdgeInsets.all(8),
          children: <Widget>[
           
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Padding(
                    padding: const EdgeInsets.only(top:10),
                    child:Text("Notifications",style: new TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Theme.of(context).accentColor,))),

                Switch(onChanged:_allNotifications,value:setting.notification)
              ],),
            Divider(color: Theme.of(context).accentColor,),
        
            Padding(
                padding: const EdgeInsets.only(top:10),
                child:Text("Visibility",style: new TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Theme.of(context).accentColor,))),
            Divider(color: Theme.of(context).accentColor,),

            ListTile(
              onTap: (){setState(() {
                if(setting.location)setting.location=false;
                else setting.location=true;
                _locationChanged(setting.location);
              });},
              title: Text("Location"),
              trailing: Switch(value: setting.location,onChanged:_locationChanged),
              subtitle: Text(setting.location?"Your location is on":"Your location is off"),
            ),


            Text("My Account",style: new TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color:Theme.of(context).accentColor)),
            Divider(color:Theme.of(context).accentColor),
            user!=null?
            ListTile(
              title: Text("Sign out",style: TextStyle(color: Colors.red),),
              subtitle:Column(
                  children:<Widget>[
                    ListTile(
                        title:Text("Name"),
                        subtitle:Text("${user.first_name} ${user.last_name}"
                        )),
                    Divider(),
                    ListTile(
                        title:Text("currently Signed in with ID"),
                        subtitle:Text("${user.id}"
                        )),
                    Divider(),
                    ListTile(
                        title:Text("Email"),
                        subtitle:Text("${user.email}"
                        )),
                    Divider(),
                    ListTile(
                        title:Text("Birthday"),
                        subtitle:Text("${user.dob}")),

                  ]),
            ):

            ListTile(
              title: Text("Login/Register",style: TextStyle(color: Colors.teal),),
              subtitle: Text("You are currently not signed in"),
            ),


            Text("About",style: new TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color:Theme.of(context).accentColor)),
            Divider(color:Theme.of(context).accentColor),
            ListTile(
              title: Text("Version"),
              subtitle: Text("version 0.0.1"),
              enabled: false,
            ),
            Divider(),
            ListTile(
              title: Text("Third-party Software"),
              subtitle: Text("A big thanks to all these wonderful software"),
            ),
            Divider(),
            ListTile(
              title: Text("T&Ts"),
              subtitle: Text("Terms and conditions"),
            ),
            Divider(),
            ListTile(
              title: Text("Privacy Policy"),
              subtitle: Text("see more"),
            ),

          ],

        )
    );
  }
  var _radioValue=0;
  void _allNotifications(bool value)
  {
    if(value)
    {
      setState((){
        disableNotifications=false;
        setting.notification=true;
       

        setting.saveSettings();
      });
    }
    else{
      setState((){
        disableNotifications=true;
        setting.notification=false;
        
        setting.saveSettings();
      });
    }
  }
  void _locationChanged(bool value) => setState((){setting.location = value; setting.saveSettings();});



}