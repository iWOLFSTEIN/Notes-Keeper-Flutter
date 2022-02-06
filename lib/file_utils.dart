
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileUtilts {


  

  static Future<String> get fileDirectory async {
    final filePath = await getApplicationDocumentsDirectory();

    return filePath.path;
  }

  static Future<File> saveToFile(String name, String data) async {

     var time = DateTime.now();
     var dateTime = DateTime(time.year, time.month, time.day, time.hour,time.minute);

      final path = await fileDirectory;

    var file = await File("$path/$name.txt");

    data = dateTime.toString()+'\n'+data;
    debugPrint(data);

    return file.writeAsString(data);
  }

  

  static Future<String> readFromFile(String name) async {
    final path = await fileDirectory;
    var file = await File("$path/$name.txt");

    try {
      String content = await file.readAsString();

   
      return content;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

 static void deleteFile(String name) async{

      final path = await fileDirectory;
    var file = await File("$path/$name.txt");

    file.delete();

  }

static  dateAndTimeTrimmer(String data) {
 
 String content = data.substring(0,data.indexOf('\n'));

 return content;

}
static dataTrimmer(String data){

 String content = data.substring(data.indexOf('\n')+1);

 return content;

}

  
static Future<List> myFuction() async {
 List personalList = [];

 List names = [];
 List dateTime =  [];
 List data=[];
    final filePath = await getApplicationDocumentsDirectory();
 Stream<FileSystemEntity> entityList =
      filePath.list(recursive: true, followLinks: false);

      await for(var entity in entityList){
         if (entity.path.contains(".txt")){
          
            
            

            names.add(titleTrimmer(entity.path));
           
           
            String content = await readFromFile(titleTrimmer(entity.path));
            
             dateTime.add(dateAndTimeTrimmer(content));
           
             data.add(dataTrimmer(content));
             
       
         }
      }

      personalList.add(names);
      personalList.add(dateTime);
      personalList.add(data);
    return personalList;
}

static String titleTrimmer(String data){

var arr = data.split('/');

data = arr[arr.length-1];

arr = data.split('.');

return arr[0];

}


}

