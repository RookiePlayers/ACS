import 'package:acs_app/MAIN/Homepage/UI/homepage.dart';
import 'package:flutter/material.dart';
class NavigationControl
{
  dynamic nextPage=new Homepage();
  NavigationControl({this.nextPage});
  void showNext(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      ),
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
      navTo(context);
    });
  }
  void navTo(BuildContext context)
  {

    if(nextPage!=null)
      Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => nextPage,
      ));
  }
  void replaceWith(BuildContext context)
  {

    Navigator.pushReplacement(context, new MaterialPageRoute(
      builder: (BuildContext context) => nextPage,
    ));


  }

}
