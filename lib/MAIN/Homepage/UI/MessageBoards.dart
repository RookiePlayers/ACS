import 'package:acs_app/AUTHENTICATION/REGISTER/UI/main.dart';
import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/DATABASE/Home/messageBoards.dart';
import 'package:acs_app/MAIN/Homepage/UI/messageBoardCard.dart';
import 'package:acs_app/MAIN/Homepage/UI/uploadGif.dart';
import 'package:acs_app/MAIN/Homepage/UI/uploadText.dart';
import 'package:cache_image/cache_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shimmer/shimmer.dart';

import '../../../NavigationControl.dart';
class MessageBoardUI extends StatefulWidget {
  Profile profile,me;
  
  MessageBoardUI({Key key, this.profile,this.me}) : super(key: key);

  _MessageBoardState createState() => _MessageBoardState(profile:profile,me:me);
}

class _MessageBoardState extends State<MessageBoardUI> {
Profile profile,me;
  
  _MessageBoardState({Key key, this.profile,me});
@override
void initState() { 
  
  super.initState();
  setState(() {
     
  });

  
}
 @override
  Widget build(BuildContext context) {
    print(">>");
 
    return Container(child:Scaffold(

    
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
                            onPressed: (){NavigationControl(nextPage: UploadeText(profile: profile)).navTo(context);},
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
                            onPressed: (){NavigationControl(nextPage: UploadGif(profile: profile)).navTo(context);},
                        
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
      
      body:Container(
        padding: EdgeInsets.only(top:20),
      child:StreamBuilder<QuerySnapshot>
      (
        stream: Firestore.instance.collection('MessageBoard').orderBy('postedOn')
        .snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasError)
          return Center(child:Text("Oops Something went wrong. ${snapshot.error}"));
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Card(
                child: Container(height: 250,
                child:  Shimmer.fromColors(
                      baseColor: Colors.white60,
                      highlightColor: Colors.white12,
                      child: Container()
                      ),),

              );
              break;
            default: return ListView(
      children:snapshot.data.documents.reversed.map((doc){
      return  FutureBuilder<Profile>(
          future: getProfile(doc.data['uploader']),
          
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData){
              return new Text(doc.data['title']);
            }
            return  new BoardCard(board: new MessageBoard.fromJSon(doc.data),uploader: snapshot.data);
          },
       
       
        );
       
      }).toList());
      }
     
        })
    )));
  }
 
  Future<Profile> getProfile(uploader)async{
    Profile p=null;
    print("!!!!!!!!!!!");
    print(uploader);
    await  FirebaseDatabase.instance.reference().child("Profile").child(uploader).once().then((ds){
      print("line: 427 messageBoards.dart");
      Map <dynamic,dynamic> data=ds.value;
      data.forEach((k,v){
        print(v);
        print(v['id']);
        p=Profile.fromJSON(v);
        print(p);
        return Profile.fromJSON(v);
      });
     /* p= Profile.fromJSon(ds.value);
      if(currentProfile!=null) setState(() {
        currentProfile=p;
      
      return Profile.fromJSon(ds.snapshot.value);*/
     
    });
    return p;
  }
 
}