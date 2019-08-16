import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/DATABASE/Home/messageBoards.dart';
import 'package:acs_app/MAIN/Homepage/UI/MessageBoards.dart';
import 'package:acs_app/MAIN/Homepage/UI/homepage.dart';
import 'package:acs_app/NavigationControl.dart';
import 'package:cache_image/cache_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';
class UploadeText extends StatefulWidget {
  final Profile profile;
  final Profile me;
  UploadeText({Key key,this.profile,this.me}) : super(key: key);

  _UploadeTextState createState() => _UploadeTextState(profile:profile,me:me);
}

class _UploadeTextState extends State<UploadeText> {
  final Profile profile;
  final Profile me;
  TextEditingController _title=TextEditingController();
    TextEditingController _message=TextEditingController();
    MessageBoard newPost;

  _UploadeTextState({this.profile,this.me});
  
  @override
  void initState() { 
    super.initState();
    print(profile);
    newPost =new MessageBoard(
      comments: [],
      desc:"",
      gif:"",
      messageId: Uuid().v1(),
      title:"",
      voice:"",
      postedOn: DateTime.now().millisecondsSinceEpoch,
      uploader: profile.uid,
      video: "",
      image: "",
      type: "Text",
      downvotes: [],
      upvote: [],

    );
    
  }
  @override
  Widget build(BuildContext context) {
    bool hideBottomSheet=false;
    return Scaffold(

       appBar: AppBar(
         title: Text("What's On Your Mind"),
      
       ),
       body: Card(
       child:  ListView(
        
     
         children: <Widget>[
         ListTile(
             contentPadding: EdgeInsets.only(top:5),
             leading: profile.image!=""?CacheImage.firebase(
                    path: profile!=null?profile.image:"",
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54
                    ),
                    placeholder: new CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: new Center(
                        child: new Text("",
                        style: TextStyle(
                          fontSize: 12,
                        


                        ),
                        ),
                      ),
                    )
             ): new CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: new Center(
                        child: new Text("",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,


                        ),
                        ),
                      ),
                    ),
             title: Wrap(
               children: <Widget>[
                 Text(
                   profile!=null?profile.first_name:"",
                     style: TextStyle(
                    fontSize: 16,
                   
                  ),
                 ),
                 Text(
                  " ~${profile!=null?profile.email+"":""}",
                   style:TextStyle(color: Colors.grey,fontSize: 10),
                 )
                
                
               ],
             ),
          
         
           ),
           Padding(
             padding: EdgeInsets.only(left: 30,right: 30),
             child:TextField(
             controller: _title,
              onChanged: (val){
                 print(val);
                 if(val[val.length-1]==("@")){
                     if(!hideBottomSheet)showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
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
                      child:StreamBuilder(
                      stream: FirebaseDatabase.instance.reference().child("Profile").onValue,
                      builder: (context, snapshot){
                       print("##############");
                        print(snapshot.data.snapshot.value);
                        if(!snapshot.hasData)return new Container(
                      
                                    child: Shimmer.fromColors(
                                    baseColor: Colors.white60,
                                    highlightColor: Colors.white12,
                                    child: Container()
                                    ),
                                  );
                        else {
                          DataSnapshot snap=snapshot.data.snapshot;
                          print(snap);
                           print("------------------------------");
                          List _item=[];
                          var _list=snap.value;
                         snap.value.forEach((k,v){
                           print("------------------------------");
                          v.forEach((key,val){
                              print(val);
                              _item.add(val);
                          });
                         
                           
                         });
                           return ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: _item.length,
                             itemBuilder: ((context,index){
                                return new Column(
                            children:<Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child:GestureDetector(
                                  onVerticalDragStart: (d){
                                   
                                print("|||||");
                                   setState(() { print(_item[index]['first_name']);
                                      _title.text+="(${_item[index]['first_name']})";
                                        print(_title.text);
                                      Navigator.pop(context);
                                   });
                                  
                                  print(_title.text);
                                   
                                  },
                                   onTap: (){
                                   
                                print("|||||");
                                   setState(() { print(_item[index]['first_name']);
                                      _title.text+="(${_item[index]['first_name']})";
                                        print(_title.text);
                                      Navigator.pop(context);
                                   });
                                  
                                  print(_title.text);
                                   
                                  },
                                  child:CircleAvatar(
                                radius: 40,
                                child: Text('@'),//Icon(FontAwesomeIcons.tag),
                                backgroundImage:NetworkImage(_item[index]['url']),
                              ))),
                              Text(_item[index]['first_name'],style: TextStyle(color: Colors.white),)
                            ]);
                            
                             })
                           );
                        }
                    }));
                });
              }
              },
             decoration: const InputDecoration(
               border: InputBorder.none,
            
               hintText: "Caption text"
             ),
             maxLines:3,
             maxLength: 100,
            
             maxLengthEnforced: true,
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 20

             ),

           ),
           ),
           Padding(
             padding: EdgeInsets.only(left: 30,right: 30),
             child:TextField(
              
             controller: _message,
             decoration: const InputDecoration(
               border: OutlineInputBorder(),
              helperText: "* You can leave this blank",
               hintText: "What's the full story"
             ),
             maxLines: 10,
             style: TextStyle(
             

             ),

           ),
           ),
            Padding(
             padding: EdgeInsets.all(20),
             child:Center(
             child: RaisedButton(
               child: Text("Post",style: TextStyle(color:Colors.white),),
               onPressed:(){
                 newPost.title=_title.text;
                 newPost.desc=_message.text;
                 saveToDatabase();
               },
               color: Colors.purple,
               
             )
            ),
           )

           
           
           
         ],
       )
       ),
    );
  }
  void saveToDatabase(){
    print("Saving...");
    MessageBoardDB().savePost(newPost, context);
  }
}