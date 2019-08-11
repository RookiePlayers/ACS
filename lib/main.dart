import 'package:acs_app/AUTHENTICATION/REGISTER/UI/main.dart';
import 'package:acs_app/DATABASE/Auth/auth.dart';
import 'package:acs_app/DATABASE/Auth/auth_provider.dart';
import 'package:acs_app/DATABASE/Auth/root_page.dart';
import 'package:acs_app/NavigationControl.dart';
import 'package:acs_app/Settings/Setting.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class WaitingScreen extends StatefulWidget
{
  WaitingScreenState createState()=>new WaitingScreenState();
}
class WaitingScreenState extends State<WaitingScreen> with
    SingleTickerProviderStateMixin
{
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );
    _controller.addListener(glistener);
  }
  void glistener()
  {
    if (!_controller.isAnimating) {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
         
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Container(
                    width: 150.0,
                    height:150.0,
                    child:Center(
                      child: Text("UL ACS",style: TextStyle(color: Colors.white,fontSize: 48.0,)),
                    )),
                Text("African Caribean Society",style: TextStyle(color: Colors.white,fontSize: 18.0,))
              ]),

        ],
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Main();
  }
}

class Main extends StatefulWidget {
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  MainState() {
    // Auth().signInWithEmailAndPassword("olamidepeters@gmail.com", "artiscool");
  }
  Widget app=new WaitingScreen();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("firebase starting...");
    //  Setting setting=new Setting();
    // setting.loadSettings().then((c){setState(() {
    app=AuthProvider(
        auth: Auth(),
        child: new
              MaterialApp(
                title: 'Flutter Demo',
                home:
                new SplashScreen(), // user!=null ? HomePage():LoginActivityMain(),
                routes: <String, WidgetBuilder>{
                  '/RootPage': (BuildContext context) => new RootPage()
                },
              )
    );
    // });
    // });

    return app;
  

}
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  startTime() async {
    /*var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);*/
    Setting setting=Setting();

    //setting.loadSettings().then((n){
      

      Future.delayed(Duration(seconds: 1)).then((n){
        NavigationControl(nextPage: RootPage(setting: setting,)).replaceWith(context);
      });//});
  }

  AnimationController _controller;

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/RootPage');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );
    _controller.addListener(glistener);

    startTime();


  }
  void glistener()
  {
    if (!_controller.isAnimating) {

      if (_controller.isCompleted) {

        _controller.reverse();


      } else {

        _controller.forward();

      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Stack(
        children: <Widget>[
          
          Center(child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Container(
                    width: 150.0,
                    height:150.0,
                    child:Text("A.C.S",style: TextStyle(color: Colors.black,fontSize: 48.0,))),
                Text("Setting you up...",style: TextStyle(color: Colors.white54,fontSize: 18.0,))
              ])),

        ],
      ),
    );
  }
}
