import 'package:acs_app/DATABASE/Home/messageBoards.dart';
import 'package:acs_app/MAIN/Homepage/UI/messageBoardCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shimmer/shimmer.dart';
class MessageBoardUI extends StatefulWidget {
  MessageBoardUI({Key key}) : super(key: key);

  _MessageBoardState createState() => _MessageBoardState();
}

class _MessageBoardState extends State<MessageBoardUI> {

@override
void initState() { 
  
  super.initState();
  setState(() {
     
  });

  
}
 @override
  Widget build(BuildContext context) {
    print(">>");
 
    return Container(
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
        return new BoardCard(board: new MessageBoard.fromJSon(doc.data));
      }).toList());
      }
     
        }));
  }
}