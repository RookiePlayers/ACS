import 'package:flutter/material.dart';
import 'package:location/location.dart';
class LocationSample extends StatefulWidget {
  LocationSample({Key key}) : super(key: key);

  _LocationSampleState createState() => _LocationSampleState();
}

class _LocationSampleState extends State<LocationSample> {
   Location location = Location();
  LocationData userLocation;

  @override
  void initState() { 
    super.initState();
   location.onLocationChanged().listen((value) {
      setState(() {
        print("--------------------");
        print(value);
        userLocation = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:${userLocation.latitude} ${userLocation.longitude}"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                },
                color: Colors.blue,
                child: Text("Get Location", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),)
    );
  }
    Future<LocationData> _getLocation() async {
    var currentLocation;
    try {
      print("--------------------");
        print(currentLocation);
      currentLocation = await location.getLocation();
    } catch (e) {
       print("xxxxxxxxxxxxxxxxxxxxxxxxxxx");
        print(e);
      currentLocation = null;
    }
    return currentLocation;
  }
}