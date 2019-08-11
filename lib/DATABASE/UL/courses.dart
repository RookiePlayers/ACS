
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class Course
{
   String name="";
   String code="";
   String discipline="";
   int length=4;
   String leader="";
  Course({this.name,this.code,this.discipline,this.length,this.leader});
  Course.fromSnapshot(DataSnapshot s):
  name=s.value['name'],
  code=s.value['code'],
  discipline=s.value['discipline'],
  length=s.value['length'],
  leader=s.value['leader'];
  toJson(){
    return{
      'name':name,
      'code':code,
      'discipline':discipline,
      'length':length,
      'leader':leader
    };


  }
}
class Courses{
  List<Course> courses;
  Courses(List<Course> courses){
    this.courses=courses;
  }
  Courses.fromSnapshot(DataSnapshot ds){
  for(int i=0;i<ds.value['courses'].length;i++){
    print(ds.value['courses'][i]);
    Course c=new Course(
        name:ds.value['courses'][i].name,
        code:ds.value['courses'][i].code,
        discipline:ds.value['courses'][i].discipline,
        length:ds.value['courses'][i].length,
        leader:ds.value['courses'][i].leader,

    );
    courses.add(c);
  }
    //this.courses=ds.value['courses'];
  }
  toJson(){
      List<dynamic> crs=new List<dynamic>();
    for(Course c in courses)
    {
    
      crs.add(c.toJson());
    }
    return {
      'courses':crs
    };
  }
}
class CourseDB{
  StreamSubscription _subscription;
 DatabaseReference ref=FirebaseDatabase.instance.reference();
 Future<void> saveCourses(Course course)
  async {
     await ref.child("Course").
   push().set(course.toJson());
  }
 Future<StreamSubscription<Event>> getCourses(void onData(Course course))async{
      print("><><><><><><><><><><>");

    StreamSubscription<Event>subscription=FirebaseDatabase.instance
    .reference()
    .child("Course")
    .onChildAdded
    .listen((e){
   
      Course c=  Course.fromSnapshot(e.snapshot);
      onData(c); print(">>>>>\n$c");
    print("Comleted");
      });
    
    return subscription;
  }
  

}
class CourseCreator {
  main(List<String> args) {
    List<Course> courses=[
      new Course(code: "LM121",name:"Computer Science",discipline: "Engineering",length: 4,leader: "Chris Exton"),
      new Course(code: "LM063",name:"Technology Management",discipline: "Engineering",length: 4,leader: "Dr Alan Ryan"),
      new Course(code: "LM076",name:"Product Design and Technology",discipline: "Engineering",length: 4,leader: "Dermot Mclnerney"),
      new Course(code: "LM121",name:"Aeronautical Engineering",discipline: "Engineering",length: 4,leader: "Ronan O Higgins"),

    ];
    //CourseDB().saveCourses(Course(courses));
  }
  
    
  
}