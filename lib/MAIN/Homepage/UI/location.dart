import 'dart:async';
import 'dart:math';

import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/toggles.dart';
import 'package:acs_app/DATABASE/Auth/registerDB.dart';
import 'package:acs_app/MISC/page.dart';
import 'package:acs_app/MISC/place_marker.dart';
import 'package:cache_image/cache_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Location extends StatefulWidget {
  final Profile profile;
  final Profile me;
  Location({Key key,this.profile,this.me}) : super(key: key);

  _LocationState createState() => _LocationState(profile: profile);
}

class _LocationState extends State<Location> {
    String searched="161";
  Widget currentList=Container();
  Toggle toggler=Toggle(init: true);
  Completer<GoogleMapController> _controller = Completer();
 Profile profile=new Profile();


 Profile me;
  _LocationState({Key key,this.profile,this.me});
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        
           
         body: Stack(
  children: <Widget>[
    GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      mapType: MapType.normal,
      markers: Set<Marker>.of(markers.values),
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
        
      ),
    ),
    
     
                
   
     Padding(
      padding: const EdgeInsets.only(top:36.0),
      child: Align(
        alignment: Alignment.topLeft,
        child:Container(
          width:MediaQuery.of(context).size.width/2,
          child:TextField(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search...",
              prefixIcon: Icon(Icons.place),
               hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal
            ),
            ),
          )
        )
      )
      ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          
          children:<Widget>[
             Padding(padding: EdgeInsets.all(20),),
          FloatingActionButton(
          heroTag: '3',
          onPressed: () => print('button pressed'),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.green,
          child: const Icon(Icons.map, size: 36.0),
          ),
          Padding(padding: EdgeInsets.all(10),),
          profile!=null?
             profile.image!= ""?CacheImage.firebase(
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
                        child: new Text(profile.first_name.substring(0,1),
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
                    ):
                    new CircleAvatar(
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
                     Padding(padding: EdgeInsets.all(20),),
                        FloatingActionButton(
                         heroTag: '4',
                          child:  Icon(toggler.isOn?Icons.pin_drop:Icons.cancel),
                         onPressed: (){setState((){
                           toggler.toggle();
                            if(toggler.isOn){_add();}
                            else{_remove();};});},
                        ),
                         Padding(padding: EdgeInsets.all(20),),
                       FloatingActionButton(
                          heroTag: '5',
                          child: const Icon(Icons.cancel),
                          onPressed: _remove,
                        ),
                        
                    
                        ]),
                
         
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child:Container(
          height: 150,
        
          decoration:BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(0.0,-1.0))]
          ),
          child:Column(
            
            children:<Widget>[
              Container(
                width:300,
                height: 50,
                child:TextField(
                  onChanged: (val){
                    setState((){
                      searched=val;
                    });
                  },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border:InputBorder.none,
                  hintText: "Enter name / student id",
                  labelText: "Locate",
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    fontSize: 12
                  ),
                 suffixIcon: Icon(Icons.location_searching,size: 20,)
                ),
              ),
              ),
             
                StreamBuilder(
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
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _item.length,
                                  itemBuilder: ((context,index){
                                       if(!_item[index]['first_name'].toLowerCase().contains(profile.first_name.toLowerCase())||!_item[index]['last_name'].toLowerCase().contains(profile.last_name.toLowerCase())||!_item[index]['id'].toLowerCase().contains(profile.id.toLowerCase()))
                                        if(_item[index]['first_name'].toLowerCase().contains(searched.toLowerCase())||_item[index]['last_name'].toLowerCase().contains(searched.toLowerCase())||_item[index]['id'].toLowerCase().contains(searched.toLowerCase()))

                                      return new Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                      radius: 30,
                                      //child:
                                      
                                      // CachedNetworkImage(imageUrl:_item[index]['url'],placeholder: (c,url)=>new Container(),),
                                    ))),
                                    Text(_item[index]['first_name'],style: TextStyle(color: Colors.black,fontSize: 10),)
                                  ]);
                                  else return Container();
                                  
                                  })
                                ));
                              }
                          })])
        
          
        )
      )
      
    ],
    ),
  
    );
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static final LatLng center =_center;

  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  

  @override
  void dispose() {
    super.dispose();
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _add() {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _remove() {
    setState(() {
      if (markers.containsKey(selectedMarker)) {
        markers.remove(selectedMarker);
      }
    });
  }

  void _changePosition() {
    final Marker marker = markers[selectedMarker];
    final LatLng current = marker.position;
    final Offset offset = Offset(
      center.latitude - current.latitude,
      center.longitude - current.longitude,
    );
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        positionParam: LatLng(
          center.latitude + offset.dy,
          center.longitude + offset.dx,
        ),
      );
    });
  }

  void _changeAnchor() {
    final Marker marker = markers[selectedMarker];
    final Offset currentAnchor = marker.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        anchorParam: newAnchor,
      );
    });
  }

  Future<void> _changeInfoAnchor() async {
    final Marker marker = markers[selectedMarker];
    final Offset currentAnchor = marker.infoWindow.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        infoWindowParam: marker.infoWindow.copyWith(
          anchorParam: newAnchor,
        ),
      );
    });
  }

  Future<void> _toggleDraggable() async {
    final Marker marker = markers[selectedMarker];
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        draggableParam: !marker.draggable,
      );
    });
  }

  Future<void> _toggleFlat() async {
    final Marker marker = markers[selectedMarker];
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        flatParam: !marker.flat,
      );
    });
  }

  Future<void> _changeInfo() async {
    final Marker marker = markers[selectedMarker];
    final String newSnippet = marker.infoWindow.snippet + '*';
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        infoWindowParam: marker.infoWindow.copyWith(
          snippetParam: newSnippet,
        ),
      );
    });
  }

  Future<void> _changeAlpha() async {
    final Marker marker = markers[selectedMarker];
    final double current = marker.alpha;
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        alphaParam: current < 0.1 ? 1.0 : current * 0.75,
      );
    });
  }

  Future<void> _changeRotation() async {
    final Marker marker = markers[selectedMarker];
    final double current = marker.rotation;
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        rotationParam: current == 330.0 ? 0.0 : current + 30.0,
      );
    });
  }

  Future<void> _toggleVisible() async {
    final Marker marker = markers[selectedMarker];
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        visibleParam: !marker.visible,
      );
    });
  }

  Future<void> _changeZIndex() async {
    final Marker marker = markers[selectedMarker];
    final double current = marker.zIndex;
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        zIndexParam: current == 12.0 ? 0.0 : current + 1.0,
      );
    });
  }

// A breaking change to the ImageStreamListener API affects this sample.
// I've updates the sample to use the new API, but as we cannot use the new
// API before it makes it to stable I'm commenting out this sample for now
// TODO(amirh): uncomment this one the ImageStream API change makes it to stable.
// https://github.com/flutter/flutter/issues/33438
//
//  void _setMarkerIcon(BitmapDescriptor assetIcon) {
//    if (selectedMarker == null) {
//      return;
//    }
//
//    final Marker marker = markers[selectedMarker];
//    setState(() {
//      markers[selectedMarker] = marker.copyWith(
//        iconParam: assetIcon,
//      );
//    });
//  }
//
//  Future<BitmapDescriptor> _getAssetIcon(BuildContext context) async {
//    final Completer<BitmapDescriptor> bitmapIcon =
//        Completer<BitmapDescriptor>();
//    final ImageConfiguration config = createLocalImageConfiguration(context);
//
//    const AssetImage('assets/red_square.png')
//        .resolve(config)
//        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
//      final ByteData bytes =
//          await image.image.toByteData(format: ImageByteFormat.png);
//      final BitmapDescriptor bitmap =
//          BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
//      bitmapIcon.complete(bitmap);
//    }));
//
//    return await bitmapIcon.future;
//  }
 
}
typedef Marker MarkerUpdateAction(Marker marker);
class PlaceMarkerPage extends Page {
  PlaceMarkerPage() : super(const Icon(Icons.place), 'Place marker');

  @override
  Widget build(BuildContext context) {
    return const PlaceMarkerBody();
  }
}

class PlaceMarkerBody extends StatefulWidget {
  const PlaceMarkerBody();

  @override
  State<StatefulWidget> createState() => PlaceMarkerBodyState();
}