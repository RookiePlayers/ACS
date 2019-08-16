import 'dart:io';

import 'package:acs_app/DATABASE/UL/courses.dart';
import 'package:acs_app/MAIN/Homepage/UI/homepage.dart';
import 'package:acs_app/NavigationControl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Profile{
  String id="";
  String email="";
  bool loginWithId=true;
  String image="";
  String first_name="";
  String last_name="";
  dynamic dob="";
  String country="";
  String gender="";
  String degree="";
  String year="";
  String course="";
  String bio="";
  String uid="";
  String instagram="";
  String facebook="";
  String snapchat="";
  String twitter="";
  String url="";
  String phone="";
  int paid=0;
  bool single=true;
  bool confirmed=false;
  bool online=false;
  List<String> friends=[];
  Profile({
    this.uid,
    this.id,
    this.confirmed,
    this.bio,
    this.country,
    this.course,
    this.degree,
    this.dob,
    this.email,
    this.first_name,
    this.last_name,
    this.gender,
    this.image,
    this.loginWithId,
    this.single,
    this.year,
    this.friends,
    this.facebook,
    this.instagram,
    this.paid,
    this.phone,
    this.snapchat,
    this.twitter,
    this.url,
    this.online
  });
  Profile.fromSnapshot(DataSnapshot s){
  id=s.value['id'];
  bio=s.value['bio'];
  country=s.value['country'];
  course=s.value['course'];
  degree=s.value['degree'];
  dob=s.value['dob'];
  email=s.value['email'];
  first_name=s.value['first_name'];
  last_name=s.value['last_name'];
  gender=s.value['gender'];
  image=s.value['image'];
  loginWithId=s.value['loginWithId'];
  single=s.value['single'];
  year=s.value['year'];
  confirmed=s.value['confirmed'];
  friends=s.value['friends'];
  facebook=s.value['facebook'];
  instagram=s.value['Instagram'];
  paid=s.value['paid'];
  phone=s.value['phone'];
  snapchat=s.value['snapchat'];
  twitter=s.value['twitter'];
  url=s.value['url'];
  online=s.value['online'];
 

  }
   Profile.fromJSon(Map<dynamic, dynamic> s){
  id=s['id'];
  bio=s['bio'];
  country=s['country'];
  course=s['course'];
  degree=s['degree'];
  dob=s['dob'];
  email=s['email'];
  first_name=s['first_name'];
  last_name=s['last_name'];
  gender=s['gender'];
  image=s['image'];
  loginWithId=s['loginWithId'];
  single=s['single'];
  year=s['year'];
  confirmed=s['confirmed'];
  friends=s['friends'];
  facebook=s['facebook'];
  instagram=s['Instagram'];
  paid=s['paid'];
  phone=s['phone'];
  snapchat=s['snapchat'];
  twitter=s['twitter'];
  url=s['url'];
  }
   Profile.fromJSON(dynamic s){
     print(s);
  id=s['id'];
  bio=s['bio'];
  country=s['country'];
  course=s['course'];
  degree=s['degree'];
  dob=s['dob'];
  email=s['email'];
  first_name=s['first_name'];
  last_name=s['last_name'];
  gender=s['gender'];
  image=s['image'];
  loginWithId=s['loginWithId'];
  single=s['single'];
  year=s['year'];
  confirmed=s['confirmed'];
  friends=s['friends'];
  facebook=s['facebook'];
  instagram=s['Instagram'];
  paid=s['paid'];
  phone=s['phone'];
  snapchat=s['snapchat'];
  twitter=s['twitter'];
  url=s['url'];
  //online=s.value['online'];
  }
  toJson(){
    return{
      'id':id,
      'bio':bio,
      'country':country,
      'course':course,
      'degree':degree,
      'dob':dob,
      'email':email,
      'first_name':first_name,
      'last_name':last_name,
      'gender':gender,
      'image':image,
      'loginWithId':loginWithId,
      'single':single,
      'year':year,
      'confirmed':confirmed,
      'friends':friends,
      'facebook':facebook,
      'Instagram':instagram,
      'paid':paid,
      'phone':phone,
      'snapchat':snapchat,
      'twitter':twitter,
      'url':url,
      'online':online
    };
  }
  @override
  String toString(){
    return "Profile{"+"id:"+id+"|email: "+email+"|First name: "+first_name+" |Last name: "+last_name+"}";
  }
}
class ProfileDB{
  BuildContext context;
  ProfileDB({this.context});
 DatabaseReference ref=FirebaseDatabase.instance.reference();
 Future<void> saveProfile(Profile profile,uid)
  async {
    print( ">> ${uid}");
     await ref.child("Profile").child(uid).
   push().set(profile.toJson());
   NavigationControl(nextPage: WelcomeSplashScreen(profile:profile)).navTo(context);
  }
 Profile p=new Profile(); 
 Future<Profile> getProfile(uid)async{
 ref.child("Profile")
.child(uid)
.once().then((DataSnapshot snapshot){
  Map<dynamic, dynamic> values = snapshot.value;
  print(snapshot.value);
    p= Profile.fromSnapshot(snapshot);
    p.uid=uid;
    return p;
 });
return p;
 //if(p==null)return getProfile(uid);
}

}
class AuthDB{
  BuildContext context;
  Profile profile;
  AuthDB({this.context,this.profile});
  Future<bool> saveAuth(String password, String email, File file) async {
    print("Username: $email, password: $password");
    var completed=false;
    var fb;
    try{
    fb= await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password).
        then((a){
        uploadImage(file,a.user.uid).then((url){
         profile.image="Profile/"+a.user.uid;
         ProfileDB(context:context).
        saveProfile(profile,a.user.uid);
        });
       
        a.user.sendEmailVerification();
          snackBar("An Email Varification has been sent to $email. Confirm then continue");
           completed=true;
        }).catchError((e){print(e);});
      
        
    }catch(e){print("error occured");}

   
    return completed;
  }
  Future<bool> login(String id,String password)async{

    FirebaseAuth.instance.signInWithEmailAndPassword(email:id.contains("@")?id:id+"@studentmail.ul.ie",password: password).then((a){
      ProfileDB(context:context).
        getProfile(a.user.uid).then(
          (p){

            NavigationControl(nextPage: WelcomeSplashScreen(profile:p)).navTo(context);
          }
        );
    });
    return true;
  }
  Future<String> uploadImage(File file,String uid)async{
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child("Profile").child(uid);
        StorageUploadTask uploadTask = storageRef.putFile(
      file,
      StorageMetadata(
        contentType:  'image/' +file.path.split(".")[file.path.split(".").length-1],
      ),

    );
          final StorageTaskSnapshot downloadUrl = 
      (await uploadTask.onComplete);
      final String url = (await downloadUrl.ref.getDownloadURL());
      print('URL Is $url');
      return url;
  }
  void snackBar(String msg)
{
  FirebaseUser user;
  final snackBar = SnackBar(
    duration: Duration(minutes: 5),
    content: Text(msg),action: SnackBarAction(
    label:"Resend",
    onPressed: (){user.sendEmailVerification();},
    
  ),);
  Scaffold.of(context).showSnackBar(snackBar);

}

}


class WelcomeSplashScreen extends StatefulWidget {
  Profile profile=new  Profile();
 WelcomeSplashScreen({this.profile});
  @override
  _WelcomeSplashScreenState createState() => new _WelcomeSplashScreenState(profile:profile);
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen>
    with SingleTickerProviderStateMixin {
      Profile profile;
      _WelcomeSplashScreenState({this.profile});
  startTime() async {
 
      Future.delayed(Duration(seconds: 10)).then((n){
        NavigationControl(nextPage: Homepage(profile:profile)).replaceWith(context);
      });//});
  }

  AnimationController _controller;

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/RootPage');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );
    _controller.addListener(glistener);

    startTime();


  }
  void glistener()
  {
    if (!_controller.isAnimating) {

      if (_controller.isCompleted) {

        _controller.reverse();


      } else {

        _controller.forward();

      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Stack(
        children: <Widget>[
          
          Center(child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Text(" Welcome",style: TextStyle(color: Colors.black,fontSize: 48.0)),
                Text("${profile.first_name}",style:TextStyle(color: Colors.black87,fontSize: 18.0)),
                Text("Setting you up...",style: TextStyle(color: Colors.white54,fontSize: 18.0,))
              ])),

        ],
      ),
    );
  }
}