import 'dart:io';

import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:suraksha_app/Entrypage.dart';
import 'package:suraksha_app/Database.dart';
import 'package:toast/toast.dart';
class memberpage extends StatelessWidget{
  String text;
  memberpage({Key key, @required this.text}) : super(key: key);

  connectdat(String s,BuildContext context) async{
    List<String> bb = text.split(".");
    int b=int.parse(bb[0]);
    String c=bb[1];
    Map<String,dynamic> map;
    Database db = await databs.ins.database;
    bool ri;
    List<Map<String,dynamic>> pp = await db.query(databs.table2);
    print('pp');
    print(pp);
    for(int i=0;i<pp.length;i++)
    {
    bb[2]=="0"?ri=pp[i]['name']==c && pp[i]['mobno']==b:ri=pp[i]['name']==c;

        if(ri)
          {
            map=pp[i];
          }
      }


    print('map');
    print(map);

    if(map['adopted']=='not yet')
    {
      s="pending...";
    }
    else{
      s=map['adopted'];
    }
    print(s);
    return  Container(
            margin: EdgeInsets.only(left:60.0,top:80.0,right:60.0,bottom:80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(child:Container(child:Image.file(File(map['link'])))),
                Text("Name:"+map['name']),
                Text("Age:"+map['age'].toString()),
                Text("Description:"+map['description']),
                Text("Adopted by:"+s),
                bb[2]=="0"?Container():RaisedButton(
                    onPressed:
                    (){
                      Map<String, dynamic> newmap = Map<String, dynamic>.from(map);
                      newmap['adopted']=bb[3];
                      print(newmap);
                      db.update(databs.table2,newmap);
                      Navigator.pop(context);
                    },
                    child:Text("Adopt"))
              ],
            )
        );

  }


  Widget build(BuildContext context)
  {
    String s;
    return Material(
      child:
      FutureBuilder<dynamic>(
        builder: (context, snapshot){
          if(snapshot.hasData)
           { return snapshot.data;}

          return Center(child: CircularProgressIndicator());
       },
        future: connectdat(s,context)
     )
    );

  }
}