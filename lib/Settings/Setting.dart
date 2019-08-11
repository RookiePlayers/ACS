import 'dart:io';

import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
class Setting
{
   bool notification=false;
   bool location=false;
   bool appearOnline=false;



  
  final String filename="setting.txt";
  Setting({
    
    this.notification,
    this.location,
    this.appearOnline
 

  });

  

  Future<String> get _localPath async{
    final dir=await getApplicationDocumentsDirectory();
    print("path:${dir.path}");
    return dir.path;
  }
  Future<File> get _localFile async{
    final path=await _localPath;
    return File('$path/'+filename);
  }
 
  String saveData()
  {
     
     String result='';
    
     
    switch(notification){
      case true:
      {
        result+='true';
      
      }
      break;
      case false:result+='false';break;
    }
     switch(location){
      case true:result+='\ntrue';break;
      case false:result+='\nfalse';break;
    }
     switch(appearOnline){
      case true:result+='\ntrue';break;
      case false:result+='\nfalse';break;
    }
     
    return result; 
  }
  @override
  String toString()
  {
   
  }

  void parseString(String s)
  {
    List<String>strs=s.split('\n');
   
    for(String str in strs)
    print("+$str");
    if(strs.length>9)
    { print(strs.length);
        
        String notification_str=strs[2];
     
        String appearOnline_str=strs[6];

        
        String loc_str=strs[8];
        
        

       
      switch(notification_str){
        case 'true':notification=true;break;
        case 'false':notification=false;break;
      }
     
      switch(appearOnline_str){
        case 'true':appearOnline=true;break;
        case 'false':appearOnline=false;break;
      }
      switch(loc_str){
        case 'true':location=true;break;
        case 'false':location=false;break;
      }
     
    
  
    }
   
    print("Notification: $notification");
   
  }
  
  Future<File> saveSettings()async
  {
   
    final file =await _localFile;
    print(file.lastModified().toString());
    return file.writeAsString(saveData());

  }
  Future<void> loadSettings() async
  {
      String contents;
    try{
      final file=await _localFile;
       contents=await file.readAsString();
       print("Hers the file content: $contents");
      
    }catch(e){
       contents='';
       print('creating file..');
    
        notification=false;
       
        appearOnline=false;
        location=false;
      
        saveSettings();


    }
    parseString(contents);
  }

}