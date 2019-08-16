import 'package:acs_app/AUTHENTICATION/REGISTER/UI/main.dart';
import 'package:acs_app/DATABASE/Auth/auth_provider.dart';
import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/MAIN/Homepage/UI/MessageBoards.dart';
import 'package:acs_app/MAIN/Homepage/UI/gifPicker.dart';
import 'package:acs_app/MAIN/Homepage/UI/location.dart';
import 'package:acs_app/MAIN/Homepage/UI/uploadGif.dart';
import 'package:acs_app/MAIN/Homepage/UI/uploadText.dart';
import 'package:acs_app/NavigationControl.dart';
import 'package:acs_app/Settings/Setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cache_image/cache_image.dart';

import 'map.dart';

class Homepage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final Profile profile;
  final Profile me;
   final Setting setting;
  Homepage({Key key,this.onSignedOut,this.setting,this.profile,this.me}) : super(key: key);

  _HomepageState createState() => _HomepageState(setting:setting,profile:profile,me:me);
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin{
  final VoidCallback onSignedOut;
   final Setting setting;
   final Profile profile,me;
  PageController _pageController=new PageController(initialPage:2);
  _HomepageState({this.onSignedOut,this.setting,this.profile,this.me});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     NestedScrollView(
        headerSliverBuilder: (BuildContext context, isScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight:280.0,
              floating:false,
              pinned:true,
              backgroundColor: Colors.purple,
            //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight:Radius.circular(200),bottomLeft:Radius.circular(200))),
              flexibleSpace:FlexibleSpaceBar(
                centerTitle: true,
  
                background: 
                Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.purple,Colors.pink])
                      ),
                    ),
                       Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   
                  children: <Widget>[
                    Column(
                        children: <Widget>[

                        IconButton
                        (
                         icon:Icon(FontAwesomeIcons.instagram,color: Colors.white,),
                          onPressed: (){},  
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                        child: Text(profile.instagram!=null?profile.instagram!=""?profile.instagram:"--":"--",style: TextStyle(color: Colors.white)),
                        ),


                      ],
                    ),
                     Column(
                        children: <Widget>[

                        IconButton
                        (
                         icon:Icon(FontAwesomeIcons.snapchat,color: Colors.white,),
                          onPressed: (){},  
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                        child: Text(profile.snapchat!=null?profile.snapchat!=""?profile.snapchat:"--":"--",style: TextStyle(color: Colors.white)),
                        ),


                      ],
                    ),
                    Column(
                        children: <Widget>[

                        IconButton
                        (
                         icon:Icon(FontAwesomeIcons.facebook,color: Colors.white,),
                          onPressed: (){},  
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                        child: Text(profile.facebook!=null?profile.facebook!=""?profile.facebook:"--":"--",style: TextStyle(color: Colors.white)),
                        ),


                      ],
                    ),
                    Column(
                        children: <Widget>[

                        IconButton
                        (
                         icon:Icon(FontAwesomeIcons.twitter,color: Colors.white,),
                           onPressed: (){},  
                         ),
                         Padding(
                           padding: const EdgeInsets.all(0),
                        child: Text(profile.twitter!=null?profile.twitter:"--",style: TextStyle(color: Colors.white)),
                        ),


                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child:  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                       border: Border.all(color: Colors.white,width: 2)
                           
                      
                    ),
                    child: profile!=null?
                    profile.image!=""?
                    CacheImage.firebase(
                    path: profile.image,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                      border: Border.all(width:2, color:Colors.white)
                    ),
                    placeholder: new CircleAvatar(
                      
                      child: new Center(
                        child: new Text(profile!=null?"${profile.first_name.length>1?profile.first_name.substring(0,1).toUpperCase():""+profile.last_name!=null?profile.last_name.length>1?profile.last_name.substring(0,1).toUpperCase():"":""}":"",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,


                        ),
                        ),
                      ),
                    )
                  ):new CircleAvatar(
                      
                      child: new Center(
                        child: new Text(profile!=null?"${profile.first_name.substring(0,1).toUpperCase()}"+" ${profile.last_name!=null?profile.last_name.substring(0,1).toUpperCase():""}":"",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,


                        ),
                        ),
                      ),
                    ):
                 new CircleAvatar(
                      
                      child: new Center(
                        child: new Text(profile!=null?"${profile.first_name.substring(0,1).toUpperCase()}"+" ${profile.last_name!=null?profile.last_name.substring(0,1).toUpperCase():""}":"",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,


                        ),
                        ),
                      ),
                    )

                    ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(profile!=null?"${profile.first_name.toUpperCase()} | ${profile.id}":"",style: TextStyle(fontSize: 16,fontFamily: "Helvetica",color: Colors.white,fontWeight: FontWeight.bold),)
                ),
                
                  
              ]),
          
                  ],
                ),
                  titlePadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("ACS | Home",style: TextStyle(fontSize: 20),),
                  Row(
                    children: <Widget>[
                    IconButton(
                                icon: Icon(Icons.settings),
                                onPressed: (){
                                  
                                },
                                    ),
                      IconButton(
                    onPressed: (){
                      signOut(context);
                    },
                    icon:Icon(FontAwesomeIcons.signOutAlt)
                  )
                    ],
                  )
                ],
              ) ,
              ),
            
            )
            ];
            },
       body: PageView(
         controller: _pageController,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Messages")
              ],
            ),
             profile!=null?MapLocator(profile: profile,):Center(child:CircularProgressIndicator()),
            
            profile!=null?MessageBoardUI(profile:profile):Center(child:CircularProgressIndicator()),
                
            Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Campus Activities")
              ],
            ),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("ACS Activities")
              ],
            ),
          
          ],
  
        
       ),

    ));
    //p==null?Container():WelcomeSplashScreen(profile: p);
  }
  
  
  @override
  void initState() { 
    _pageController=new PageController(initialPage:2);
  /*   FirebaseAuth.instance.currentUser().then((user){
     
         FirebaseDatabase.instance.reference().child("Profile")
          .child(user.uid).onChildAdded.listen((ds){
              print(ds.snapshot.value['course']);
             
                setState(() {
                             p=Profile.fromSnapshot(ds.snapshot);
                             p.uid=user.uid;
                             print(">>>$p");
                });
          });
     
  
   });*/
  }
 final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  
GoogleSignIn _googleSignIn = GoogleSignIn(

  scopes: <String>[

    'email',

    'https://www.googleapis.com/auth/contacts.readonly',

  ],

);
  GoogleSignInAccount _currentUser;
   Future<void> signOut([BuildContext c]) async {
    print("*************");
    print(c);
    NavigationControl(nextPage: Registeration()).navTo(c);
    _googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }
  void _signOut(BuildContext context) async {
    try {
      print("------");
      print(context);
      var auth = AuthProvider.of(context).auth;

      await auth.signOut();

      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}