
import 'dart:convert';
import 'dart:io';
import 'package:suraksha_app/Database.dart';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:suraksha_app/Newentry.dart';

class entrypage extends StatefulWidget {
  String text;
  entrypage({Key key, @required this.text}) : super(key: key);
  @override
  _entrypageState createState() => _entrypageState(text);
}

class _entrypageState extends State<entrypage> {

  _entrypageState(String text)
  {
    this.va = text;
  }
  String va;
  File image;
  String url;
  bool flag = false;
  getchange() async{
    setState((){
      flag = true;
    });
  }
  getImage() async
  {
    final picker = ImagePicker();
//    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      url = pickedFile.path;
      getchange();
    }

  }

  insertdata(String na,String ag,String des) async
  {

      // get a reference to the database
      // because this is an expensive operation we use async and await
      Database db = await databs.ins.database;
      List<String> mo = va.split(".");
      // row to insert
      Map<String, dynamic> row = {
        databs.col11 : na,
        databs.col31  : int.parse(ag),
        databs.col51 : des,
        databs.col41 : url,
        databs.col21 : int.parse(mo[1]),
        databs.col61 : 'not yet'
      };

      // do the insert and get the id of the inserted row
      int id = await db.insert(databs.table2, row);

      // show the results: print all rows in the db
      print(await db.query(databs.table2));
    }



  @override
  Widget build(BuildContext context)
  {
    TextEditingController name = new TextEditingController();
    TextEditingController age = new TextEditingController();
    TextEditingController description = new TextEditingController();
    return Material(
      child: Container(
        margin: EdgeInsets.only(left:50.0,top:100.0,right:50.0,bottom:150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(
              'ENTRYPAGE',
              style: TextStyle(fontFamily: 'JosefinSans',fontSize: 20),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: name,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter his age range',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: age,
            ),
            flag? Flexible(
                child:
                Container(child: Image.file(image))
            ):
            Container(
              child:
              FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  onPressed:
                  () {
                    getImage();
                  }
              )
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Add a description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: description,
            ),
            RaisedButton(
                child: Text('Notify NGOs'),
                onPressed:
                    ()
                {
                  insertdata(name.text,age.text,description.text);
                  Navigator.pop(context);

                }
            )
          ],
        ),
      ),
    );
  }
}


