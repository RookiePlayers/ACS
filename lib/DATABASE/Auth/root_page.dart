import 'package:acs_app/AUTHENTICATION/LOGIN/UI/main.dart';
import 'package:acs_app/AUTHENTICATION/REGISTER/UI/main.dart';
import 'package:acs_app/DATABASE/Auth/auth_provider.dart';
import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/MAIN/Homepage/UI/homepage.dart';
import 'package:acs_app/Settings/Setting.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

import '../../NavigationControl.dart';
import '../../main.dart';





class RootPage extends StatefulWidget {
 final Setting setting;
  RootPage({this.setting});
  @override
  State<StatefulWidget> createState() => _RootPageState(setting: setting);
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;
 Profile p=null;
  final Setting setting;
  _RootPageState({this.setting});
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var auth = AuthProvider.of(context).auth;



    auth.currentUser().then((userId) {
      setState(() {
        authStatus =
        userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();

      case AuthStatus.notSignedIn:
        return new Login(
         
        );

      case AuthStatus.signedIn:
        {
               goHome();
              return p!=null? WelcomeSplashScreen(profile:p):WaitingScreen();
         
      }; /*new Homepage(
          onSignedOut: _signedOut,
          setting: setting,
        );*/
    }

    return Container();
  }
  Location location = Location();
                 LocationData userLocation;
  Future<void> goHome()async{
    print("line:89 root_page.dart:        called");
 FirebaseAuth.instance.currentUser().then((user){
     
         FirebaseDatabase.instance.reference().child("Profile")
          .child(user.uid).onChildAdded.listen((ds){
              print(ds.snapshot.value['course']);
             setState(() {
               p=Profile.fromSnapshot(ds.snapshot);
                 _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
             }); 

          });
     
  
   });
 

   
   
    
  }
  Future<LocationData> _getLocation() async {
    var currentLocation;
    try {
      print("--------------------");
        print(currentLocation);
      currentLocation = await location.getLocation();
    } catch (e) {
       print("xxxxxxxxxxxxxxxxxxxxxxxxxxx");
        print(e);
      currentLocation = null;
    }
    return currentLocation;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
