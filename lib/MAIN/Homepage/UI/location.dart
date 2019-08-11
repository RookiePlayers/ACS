import 'dart:async';

import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Location extends StatefulWidget {
  Profile profile=new Profile();
  Location({Key key,this.profile}) : super(key: key);

  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  
  Completer<GoogleMapController> _controller = Completer();
 Profile profile=new Profile();
  _LocationState({Key key,this.profile});
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         body: Stack(
  children: <Widget>[
    GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topRight,
        child: FloatingActionButton(
          onPressed: () => print('button pressed'),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.green,
          child: const Icon(Icons.map, size: 36.0),
          ),
        ),
      ),
      Padding(
        padding:EdgeInsets.all(10),
        child:
           StreamBuilder(
                      stream: FirebaseDatabase.instance.reference().child("Profile").onValue,
                      builder: (context, snapshot){
                      
                        if(!snapshot.hasData)return new Container(
                      
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
                                 
                                   setState(() {
                                   
                                     
                                      Navigator.pop(context);
                                   });
                                  
                                 
                                   
                                  },
                                   onTap: (){
                                   
                               
                                   setState(() { print(_item[index]['first_name']);
                                    
                                      Navigator.pop(context);
                                   });
                                  
                                 
                                   
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
                    })
         
      )
    ],
    ),
  ),
    );
  }
  
}