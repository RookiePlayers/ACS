import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessageBoard {
  String messageId;
  String uploader;
  String title;
  String desc;
  dynamic postedOn;
  String type;
  String image;
  String video;
  String voice;
  String gif;
  List<dynamic> upvote;
  List<dynamic> downvotes;
  List<dynamic> comments;

  MessageBoard(
    {
      this.desc,
      this.downvotes,
      this.image,
      this.postedOn,
      this.title,
      this.type,
      this.uploader,
      this.upvote,
      this.video,
      this.voice,
      this.gif,
      this.comments,
      this.messageId
    }
  );

  MessageBoard.fromSnapshot(DataSnapshot ds):
  this.desc=ds.value['desc'],
  this.title=ds.value['title'],
  this.downvotes=ds.value['downvotes'],
  this.image=ds.value['image'],
  this.postedOn=ds.value['postedOn'],
  this.type=ds.value['type'],
  this.uploader=ds.value['uploader'],
  this.upvote=ds.value['upvote'],
  this.video=ds.value['video'],
  this.messageId=ds.value['messageId'],
  this.voice=ds.value['voice'],
  this.gif=ds.value['gif'],
  this.comments=ds.value['comments'];

  MessageBoard.fromJSon(Map<dynamic,dynamic> ds):
  this.desc=ds['desc'],
  this.title=ds['title'],
  this.downvotes=ds['downvotes'],
  this.image=ds['image'],
  this.postedOn=ds['postedOn'],
  this.type=ds['type'],
  this.uploader=ds['uploader'],
  this.upvote=ds['upvote'],
  this.video=ds['video'],
  this.voice=ds['voice'],
  this.gif=ds['gif'],
  this.messageId=ds['messageId'],
  this.comments=ds['comments'];

  toJson(){
    var _commentsJ=[];
    comments.forEach((c){
      _commentsJ.add(c.toJson());
    });
    return {
      'desc':desc,
      'messageId':messageId,
      'title':title,
      'downvotes':downvotes,
      'image':image,
      'postedOn':postedOn,
      'type':type,
      'uploader':uploader,
      'upvote':upvote,
      'video':video,
      'voice':voice,
      'gif':gif,
      "comments":comments
    };
  }
  
}
class Comment{
  String commentId;
  String text;
  String image;
  String gif;
  String type;
  String video;
  String user;
  dynamic date;
  List<dynamic> comments;
  List<dynamic> upvote;
  List<dynamic> downvotes;

  Comment.fromSnapshot(DataSnapshot ds):
  commentId=ds.value['commentId'],
  text=ds.value['text'],
  image=ds.value['image'],
  gif=ds.value['gif'],
  type=ds.value['type'],
  video=ds.value['video'],
  user=ds.value['user'],
  date=ds.value['date'],
  comments=ds.value['comments'],
  upvote=ds.value['upvote'],
  downvotes=ds.value['downvotes'];

    Comment.fromJsom(Map<dynamic,dynamic> ds){
      commentId=ds['commentId'];
  text=ds['text'];
  image=ds['image'];
  gif=ds['gif'];
  type=ds['type'];
  video=ds['video'];
  user=ds['user'];
  date=ds['date'];
  comments=ds['comments'];
  upvote=ds['upvote'];
  downvotes=ds['downvotes'];
    }

  toJson(){
    return {
       'commentId':commentId,
  'text':text,
  'image':image,
  'gif':gif,
  'type':type,
  'video':video,
  'user':user,
  'date':date,
  'comments':comments,
  'upvote':upvote,
  'downvotes':downvotes
    };
  }

}
class MessageBoardDB{
  Future<void> savePost(MessageBoard post,BuildContext context)async{
    Firestore.instance.collection("MessageBoard").add(post.toJson()).then((r){
      Navigator.pop(context);
    });
    Future<void> addComment({String parentId,Comment child})async{
      var db=Firestore.instance;
      Map<String,String> pair={};
      pair.putIfAbsent("pid",()=>parentId);
      

      await db.collection("MessageBoard").where("messageId",isEqualTo:parentId).getDocuments().then((snapshot){
        snapshot.documents.forEach((doc){
          var comments=doc.data['comments'];
          db.collection("MessageBoard").document(doc.documentID).updateData({'comments':comments}).then((response){

          }).catchError((e){});

        });
      });
      db.collection("MessageComments")
      .document(child.commentId)
      .setData({"parentId":parentId,"body":child.toJson(),"id":child.commentId}).then((r){

      }).catchError((e){});

    }
    Future<void> addReply({String parentId,Comment child})async{
      var db=Firestore.instance;
      Map<String,String> pair={};
      pair.putIfAbsent("pid",()=>parentId);
      

    await db.collection("MessageComments").where("id",isEqualTo:parentId).getDocuments().then((snapshot){
        snapshot.documents.forEach((doc){
          var body=doc.data['body'];
         body['comments'].push(pair);
          db.collection("MessageComments").document(parentId).updateData({'body':body}).then((response){

          }).catchError((e){});

        });
      });
      db.collection("MessageComments")
      .document(child.commentId)
      .setData({"parentId":parentId,"body":child.toJson(),"id":child.commentId}).then((r){

      }).catchError((e){});

    }

    /*DatabaseReference ref=FirebaseDatabase.instance.reference();
    await ref.child("Profile").child(uid).
   push().set(profile.toJson());
   NavigationControl(nextPage: WelcomeSplashScreen(profile:profile)).navTo(context);*/
  }
}
