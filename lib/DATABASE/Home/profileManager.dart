import 'dart:async';

import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileManager{
  static Future<StreamSubscription<Event>>getUser(String userKey,void onData(Profile profile)) async
  {
    print("-->"+userKey);
     StreamSubscription<Event> subscription = 
     FirebaseDatabase.instance
    .reference()
    .child("Profile")
    .child(userKey+"/")
    .onChildAdded
    .listen((event){
      print(">>");
      print(event.snapshot.key);

      var profile=new Profile.fromJSon(event.snapshot.value);
      
      print(profile);
      onData(profile);
    });
    return subscription;
  }
}