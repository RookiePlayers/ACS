import 'dart:async';

import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/MAIN/Homepage/UI/location.dart';
import 'package:acs_app/NavigationControl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapLocator extends StatefulWidget {
  Profile profile;
  Profile me;
  MapLocator({Key key,this.profile,this.me}) : super(key: key);

  _MapLocatorState createState() => _MapLocatorState(profile:profile,me:me);
}

class _MapLocatorState extends State<MapLocator> {
  Profile profile;
  Profile me;
  _MapLocatorState({this.profile,this.me});
     static const LatLng _center = const LatLng(45.521563, -122.677433);
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  TextEditingController _searchFor=TextEditingController();
  String searched="";
  Widget currentList=Container();
  Widget getAllStudents(){
    return StreamBuilder(
                         stream: FirebaseDatabase.instance.reference().child("Profile").onValue,
                            builder: (context, snapshot){
                            
                              if(!snapshot.hasData)return new Container(
                                  height:100,
                                  width:100,
                                          child: CircularProgressIndicator()
                                        );
                              else {
                                DataSnapshot snap=snapshot.data.snapshot;
                              
                                List _item=[];
                                var _list=snap.value;
                              snap.value.forEach((k,v){
                              
                                v.forEach((key,val){
                                
                                    _item.add(val);
                                });
                             
                                
                              });
                                return Expanded(child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.all(10),
                                  itemCount: _item.length,
                                  itemBuilder: ((context,index){
                                      if(_item[index]['first_name'].toLowerCase().contains(searched.toLowerCase())||_item[index]['last_name'].toLowerCase().contains(searched.toLowerCase())||_item[index]['id'].toLowerCase().contains(searched.toLowerCase())){

                                      return ListTile(
                                        title:  Text(_item[index]['first_name']+" | "+_item[index]['id'],style: TextStyle(color: Colors.black,fontSize: 10),),
                                        leading:CircleAvatar(
                                      radius: 20,
                                      //child: Icon(Icons.location_searching,color:Colors.purpleAccent),//Icon(FontAwesomeIcons.tag),
                                      backgroundImage:NetworkImage(_item[index]['url']),
                                    )
                                      );
                                  }else return Container();
                                  
                                  })
                                ));
                              }
                          });
           
      
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children:<Widget>[
           Container(
             padding: EdgeInsets.only(left:20,right:20,top:10),
             child:TextField(
               onChanged: (val){
                 setState((){
                   searched=val;
                   currentList=getAllStudents();
                 });
               },
             decoration: InputDecoration(
               hintText: "Looking for Someone ?",
              helperText: "Enter name or student id"
             ),
           ),
           ),
           currentList,
           
           SafeArea(
             child:Center(

               child:GestureDetector(
                 onLongPress: (){
                   NavigationControl(nextPage: Location(profile: profile,)).navTo(context);
                 },
                 child:Container(
                   width: MediaQuery.of(context).size.width,
                   height: 200,
                  child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
               )),
              
             )
           )
         ]
       ),
    );
  }
}