import 'dart:async';
import 'dart:core';

import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/toggles.dart';
import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/DATABASE/Home/messageBoards.dart';
import 'package:acs_app/DATABASE/Home/profileManager.dart';
import 'package:cache_image/cache_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';


class BoardCard extends StatefulWidget {
  final MessageBoard board;
  BoardCard({
    this.board
  });
 

  _BoardCardState createState() => _BoardCardState(board:board);
}

class _BoardCardState extends State<BoardCard> with SingleTickerProviderStateMixin {
  AnimationController anim_controller;
 final MessageBoard board;
  Profile _currentProfile = Profile();
  _BoardCardState({
    this.board
  });
 StreamSubscription _profileSubscription;
VideoPlayerController _controller;
String video_url;
  Future<void> _initializeVideoPlayerFuture;
 @override
 void initState() { 
  super.initState();
   // ProfileManager.getUser(board.uploader,_updateCurrentProfile).then((StreamSubscription s) => _profileSubscription = s);
 anim_controller=AnimationController(duration: Duration(milliseconds: 800),vsync: this);

    if(board.type=="Video"){   print("~~~~~~~~~~~~~"+board.video);
      _controller = VideoPlayerController.network(
      board.video);

      _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    }
    
   
   
 }
 @override
  void dispose() {
    // TODO: implement dispose
    anim_controller.dispose();
   if(_controller!=null) _controller.dispose();
    super.dispose();
  }
 void _updateCurrentProfile(Profile p)
 {
  

 }
  Widget captionText(String text){
    List<TextSpan> children=[];
    RegExp p1=new RegExp("([(a-zA-Z)]+)");
     RegExp p2=new RegExp("([a-zA-Z]+)");
  
    return RichText(
      text: TextSpan(
        style: TextStyle(),
        children: children
      ),
    );
  }
  
  Toggle overlay_toggler=new Toggle(init: false);
  Future<Profile> getProfile()async{
    await  FirebaseDatabase.instance.reference().child("Profile").child(board.uploader).once().then((ds){
      return Profile.fromJSon(ds.value);
    });
    return Profile();
  }
  @override
  Widget build(BuildContext context) {
    print("----------");
    print(board.upvote);
    return Card(
      child:Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      
       child:FutureBuilder(
         future:getProfile(),
         builder: (context, snapshot){
           
           if(!snapshot.hasData)return new Container(
                      height: 300,
                      color: Colors.black12,
                      /*child: Shimmer.fromColors(
                      baseColor: Colors.black26,
                      highlightColor: Colors.black12,
                      child: Container()
                      ),*/
                    );
          else {
             var _currentProfile=new Profile.fromJSon(snapshot.data.snapshot.value);
            return
       Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
           Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
                Icon(
                   Icons.timer,
                   color: Colors.grey,
                   size: 12,
                 ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                  child: Text(
                   "Posted "+timeago.format(new DateTime.now().subtract(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(board.postedOn)))),
                  style: TextStyle(
                    fontSize: 12
                  ),
                 )
                  )
                 
              ]),
           ListTile(
             contentPadding: EdgeInsets.only(top:5),
             leading: _currentProfile.image!= ""?CacheImage.firebase(
                    path: _currentProfile!=null?_currentProfile.image:"",
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
                          fontWeight: FontWeight.bold,


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
                   _currentProfile!=null?_currentProfile.first_name:"",
                     style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                 ),
                 Text(
                  " ~${_currentProfile!=null?_currentProfile.email+"":""}",
                   style:TextStyle(color: Colors.grey,fontSize: 10),
                 )
                
                
               ],
             ),
          
         
           ),
            board.title!=""?
         Padding(
           padding: EdgeInsets.all(10),
           child:SizedBox(
             width: double.infinity,
            child:Text(
           board.title,
           overflow: TextOverflow.fade,
           textAlign: TextAlign.left,
           style: TextStyle(
             
             color: Colors.black,
             
             fontSize: 18
           ),
         ))
         ):Container(),
         board.desc!=""?
          Padding(
           padding: EdgeInsets.all(10),
           child:SizedBox(
               width: double.infinity,
             child:Text(
           board.desc,
           overflow: TextOverflow.fade,
           textAlign: TextAlign.left,
           style: TextStyle(
             
             color: Colors.blueGrey[500],
             
             fontSize: 12
           ),
         ))
         ):Container(),
         board.type=="Image"?
         Expanded(
           child:Container(
             child:CacheImage.firebase(
                    path: board.image,
                    fit: BoxFit.cover,
                    placeholder: new Container(
        
                      child: Shimmer.fromColors(
                      baseColor: Colors.white60,
                      highlightColor: Colors.white12,
                      child: Container()
                      ),
                    )
             ),
           ) ,
         ):
         board.type=="Video"?
         VisibilityDetector(
           key:Key('video'),
           onVisibilityChanged: (VisibilityInfo info){
              setState(() {
                                // If the video is playing, pause it.
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller.play();
                                 
                                }
                              });
           },
           child:
         Container(
           height: 350,
           child: 
                Center(
               child:FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  print("---------------");
                  print(snapshot);
                  print(snapshot.connectionState);
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      
                      // Use the VideoPlayer widget to display the video.
                      child:GestureDetector(
                        onTap: (){
                          setState(() {
                            overlay_toggler.toggle();
                          });
                        },
                        child:Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        
                       overlay_toggler.isOn?
                         FadeTransition(
                           opacity: Tween<double>(begin: 1.0,end: 1.0).animate(this.anim_controller),     
                              
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end:Alignment.topCenter,
                                  colors: [Colors.black87,Colors.black12]
                                )
                              ),
                              child: Center(
                              child:  FloatingActionButton(
                                backgroundColor: Colors.black87,
                            onPressed: () {
                              // Wrap the play or pause in a call to `setState`. This ensures the
                              // correct icon is shown.
                              setState(() {
                                // If the video is playing, pause it.
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller.play();
                                  overlay_toggler.toggle();
                                }
                              });
                            },
                            // Display the correct icon depending on the state of the player.
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                       ),
                            )

                            
                         )
                  : FadeTransition(
                           opacity: Tween<double>(begin: 1.0,end: 0.0).animate(anim_controller),
                              
                              child: Container(),

                            )
                         
                      ],
                    )),
                    );
                  } else {
                    print(snapshot.data);
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return Center(child:
                      CircularProgressIndicator());//);
                  }
                },
              ),
               ),
             
         )):
         board.type=="Gif"?
         Container(
          width: double.infinity,
           child:FadeInImage(
                 image: NetworkImage(board.gif),
                 placeholder: AssetImage('assets/loader1.gif'),
                 fit: BoxFit.cover,
               )
         ):
         Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.thumbsUp),
                  onPressed: (){},
                ),
                Text(
                  "${board.upvote.length}"),
                    IconButton(
                  icon: Icon(FontAwesomeIcons.thumbsDown),
                  onPressed: (){},
                  iconSize: 14,
                ),
                Text(
                  "${board.downvotes.length}"),

              ],
            ),
             Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.comment),
                  onPressed: (){},
                  
                ),
                Text(
                  "${board.comments.length}"),
                    
                  
              ],
            ),
             Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.share),
                  onPressed: (){},
                  iconSize: 14,
                ),
                Text(
                  "Share"
                ),
                    
                  
              ],
            )
          ],
        )

         ]
         
       );
      }
       }) ,
    )
    );
  }
}