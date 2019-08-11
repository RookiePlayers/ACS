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

class Homepage extends StatefulWidget {
  final VoidCallback onSignedOut;
   final Setting setting;
  Homepage({Key key,this.onSignedOut,this.setting}) : super(key: key);

  _HomepageState createState() => _HomepageState(setting:setting);
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin{
  final VoidCallback onSignedOut;
   final Setting setting;
  PageController _pageController=new PageController(initialPage:2);
  _HomepageState({this.onSignedOut,this.setting});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        backgroundColor: Colors.purple,
        clipBehavior: Clip.antiAlias,
        onPressed: (){

                showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1,4.2],
                    colors: [Colors.blue,Colors.purple]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                
                  child:Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                       Text("Upload Type",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                    
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                            ),
                            child: IconButton(
                            icon: Icon(FontAwesomeIcons.microphone),
                            onPressed: (){},
                            splashColor: Colors.yellow[600],
                            color: Colors.blue[700],
                          ),
                        ),
                           
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text("Voice Note",style:TextStyle( color: Colors.white,fontSize: 12),)
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                         Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                            ),
                            child: IconButton(
                            icon: Icon(FontAwesomeIcons.video),
                            onPressed: (){},
                            splashColor: Colors.yellow[600],
                            color: Colors.blue[700],
                          ),
                        ),
                          Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text("Video",style:TextStyle( color: Colors.white,fontSize: 12),)
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                         Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                            ),
                            child: IconButton(
                            icon: Icon(FontAwesomeIcons.image),
                            onPressed: (){},
                            splashColor: Colors.yellow[600],
                            color: Colors.blue[700],
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text("Image",style:TextStyle( color: Colors.white,fontSize: 12),)
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                            ),
                            child: IconButton(
                            icon: Icon(Icons.library_books),
                            onPressed: (){NavigationControl(nextPage: UploadeText(profile: p)).navTo(context);},
                            splashColor: Colors.yellow[600],
                            color: Colors.blue[700],
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text("Text",style:TextStyle( color: Colors.white,fontSize: 12),)
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                                
                            ),
                            child: IconButton(
                            icon: Icon(Icons.gif),
                            onPressed: (){NavigationControl(nextPage: UploadGif(profile: p)).navTo(context);},
                        
                            splashColor: Colors.yellow[600],
                            color: Colors.blue[700],
                          ),
                        ),
                          Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text("Gif",style:TextStyle( color: Colors.white,fontSize: 12),)
                          )
                        ],
                      )
                    ],
                  )
                
                ])
                ),
              );
              });
        },
      ),
      body:NestedScrollView(
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
                        child: Text(p!=null?p.instagram!=""?p.instagram:"--":"--",style: TextStyle(color: Colors.white)),
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
                        child: Text(p!=null?p.snapchat!=""?p.snapchat:"--":"--",style: TextStyle(color: Colors.white)),
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
                        child: Text(p!=null?p.facebook!=""?p.facebook:"--":"--",style: TextStyle(color: Colors.white)),
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
                        child: Text(p!=null?p.twitter!=""?p.twitter:"--":"--",style: TextStyle(color: Colors.white)),
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
                    child: p!=null?p.image!=""?CacheImage.firebase(
                    path: p.image,
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
                        child: new Text(p!=null?"${p.first_name.length>1?p.first_name.substring(0,1).toUpperCase():""+p.last_name!=null?p.last_name.length>1?p.last_name.substring(0,1).toUpperCase():"":""}":"",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,


                        ),
                        ),
                      ),
                    )
                  ):new CircleAvatar(
                      
                      child: new Center(
                        child: new Text(p!=null?"${p.first_name.substring(0,1).toUpperCase()}"+" ${p.last_name!=null?p.last_name.substring(0,1).toUpperCase():""}":"",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,


                        ),
                        ),
                      ),
                    )
                    :new CircleAvatar(
                      
                      child: new Center(
                        child: new Text(p!=null?"${p.first_name.substring(0,1).toUpperCase()}+" "+${p.last_name!=null?p.last_name.substring(0,1).toUpperCase():""}":"",
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
                  child: Text(p!=null?"${p.first_name.toUpperCase()} | ${p.id}":"",style: TextStyle(fontSize: 16,fontFamily: "Helvetica",color: Colors.white,fontWeight: FontWeight.bold),)
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
             p!=null?Location(profile: p,):Center(child:CircularProgressIndicator()),
            
            p!=null?MessageBoardUI():Center(child:CircularProgressIndicator()),
                
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
 

  
  
  Profile p;
  @override
  void initState() { 
    _pageController=new PageController(initialPage:2);
     FirebaseAuth.instance.currentUser().then((user){
     
         FirebaseDatabase.instance.reference().child("Profile")
          .child(user.uid).onChildAdded.listen((ds){
              print(ds.snapshot.value['course']);
             
                setState(() {
                             p=Profile.fromSnapshot(ds.snapshot);
                             p.uid=user.uid;
                             print(">>>$p");
                });
          });
     
  
   });
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