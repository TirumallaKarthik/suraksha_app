import 'dart:io';

import "package:flutter/material.dart";
import 'package:path_provider/path_provider.dart';
import 'package:suraksha_app/Database.dart';
import 'package:suraksha_app/Login.dart';
import 'package:suraksha_app/Newentry.dart';
import 'package:suraksha_app/Opening.dart';
import 'package:toast/toast.dart';
import 'package:sqflite/sqflite.dart';
class register extends StatelessWidget{

  Widget build(BuildContext context)
  {
    bool k;
    TextEditingController name = new TextEditingController();
    TextEditingController mobno = new TextEditingController();
    TextEditingController aadharno = new TextEditingController();
    TextEditingController mpin = new TextEditingController();

    return Material(
      child: Container(
        margin: EdgeInsets.only(left:80.0,top:70.0,right:80.0,bottom:50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Center(
                child: Text(
              'Register Here',
              style: TextStyle(fontFamily: 'JosefinSans',fontSize: 45),
            )
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
              controller: name,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: mobno,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Aadhar Number',
                  hintText: 'Enter your aadhar number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: aadharno,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'MPin',
                  hintText: 'Enter your mpin _ _ _ _',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: mpin,
            ),
            ElevatedButton(
                child: Text('Register Now'),
                onPressed:
                () {
                  k=validate(name.text,mobno.text,aadharno.text,mpin.text);
                  if(k){
                    _insert(name.text, mobno.text, aadharno.text, mpin.text);
                    Toast.show('Successfully Registered', context);
                    Navigator.pop(context);
                  }
                  else{
                    Toast.show('Refill the form', context);
                  }
                }
            )

          ],
        ),
      ),
    );
  }
  bool validate(String name,String mobno,String aadharno,String mpin)
  {
     if(mobno.length!=10)
       {
         return false;
       }

     if(aadharno.length!=12)
       {
         return false;
       }

     if(mpin.length!=4)
     {
       return false;
     }

     if(name==null)
     {
       return false;
     }
     return true;

  }
  _insert(String name,String mobno,String aadharno,String mpin) async {

    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await databs.ins.database;

    // row to insert
    Map<String, dynamic> row = {
      databs.col1 : name,
      databs.col2  : int.parse(mobno),
      databs.col3 : int.parse(aadharno),
      databs.col4 : int.parse(mpin),
      databs.col5 : 0,
    };

    // do the insert and get the id of the inserted row
    int id = await db.insert(databs.table, row);

    // show the results: print all rows in the db
   print(await db.query(databs.table));
  }
}