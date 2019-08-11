import 'dart:convert';

import 'package:acs_app/APIModels/Gif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
class GifPicker extends StatefulWidget {
  Function update;
  GifPicker({Key key,this.update}) : super(key: key);

  _GifPickerState createState() => _GifPickerState(update: update);
}

class _GifPickerState extends State<GifPicker> {
  Function update;
  _GifPickerState({this.update});
  var _searchGif= TextEditingController();
  var options=['LOL','Clap','Thumbs Up','What','Awww','Facepalm','Seriously','KMT','OMG','Ok','SMH','seriously','Yes'];
  int pick=0;
  String search='LOL';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.purple[700],
      title: TextField(
            onChanged: (val){
              setState(() {
                search=val;
              });
            },
             controller: _searchGif,
             style: TextStyle(
               color: Colors.white
             ),
             decoration: InputDecoration(
               border: InputBorder.none,
               hintText: "Search Giphy..",
               labelText: "Search Giphy",
               labelStyle: TextStyle(
                 color:Colors.grey
               )
             ),
           )
    ),
    backgroundColor: Colors.blueGrey[900],
      body:Column(
       children: <Widget>[Padding(
         padding: EdgeInsets.all(5),
         child: Wrap(
           children: List<Widget>.generate(
             options.length,
             (index){
               return Padding(
                 padding:EdgeInsets.all(5),
               child:  ChoiceChip(
                 backgroundColor: Colors.purpleAccent[200].withOpacity(0.5),
                 labelStyle: TextStyle(
                   color:pick==index?Colors.white:Colors.blueGrey
                 ),
                 selectedColor: Colors.purpleAccent[200],
                 
                 label: Text(options[index]),
                 selected:pick==index,
                 onSelected: (bool selected){
                   setState(() {
                     pick = selected ? index : null;
                    search=options[pick];
                   });
                 },
               ));
             }
           ).toList()
           ,
         ),
       ),
     Expanded(
       child: FutureBuilder<Giphy>(
           future: getGifs(search, 200),
        
           builder: ( context,  snapshot) {
                print("----------------");
                
               if (snapshot.hasData) {
                 print("----------------");
                
                return /*GridView.count(crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                children: List.generate(snapshot.data.data.length, (index){
                  print(index);
                  return Container(
                    width: 50,
                    height: 50,
                    child:FadeInImage.assetNetwork(
                      placeholder:'assets/loader1.gif',
                      image: snapshot.data.data[index].images.url,
                    ) ,
                  );
                }),
                ); ListTile(
                  title: snapshot.data.data.length>=1?Text(snapshot.data.data[0].images.url):Container(),
                );*/
                 StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (BuildContext context, int index) => 
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          update(snapshot.data.data[index].images.url);
                          Navigator.pop(context);
                        });
                      },
                      child:FadeInImage.assetNetwork(
                      placeholder:'assets/loader1.gif',
                      image: snapshot.data.data[index].images.url,
                    )),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(2, index.isEven ? 2 : 1),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Container(
                child:Center(child:CircularProgressIndicator()));
           },
         )),

       
       ],
       
    ));
  }
  Future<Giphy> getGifs(search,limit)async{
    print(search);
    final response=await http.get('http://api.giphy.com/v1/gifs/search?q=${search.replaceAll(" ","+").toLowerCase()}&api_key=aO8F8N8hYtN6sYd3xucGxcLqvVu0gcPS&limit=$limit');
  if(response.statusCode==200){
    print(json.decode(response.body));
  var gifs=   Giphy.fromJson(json.decode(response.body));
  for(var g in gifs.data){
print(g.images.url);
  }
  return gifs;
  
  }else{
    throw Exception('Field to load post');
  }
  }
}