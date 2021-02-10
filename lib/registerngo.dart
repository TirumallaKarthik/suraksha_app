import 'dart:io';

import "package:flutter/material.dart";
import 'package:path_provider/path_provider.dart';
import 'package:suraksha_app/Database.dart';
import 'package:suraksha_app/Login.dart';
import 'package:suraksha_app/Newentry.dart';
import 'package:suraksha_app/Opening.dart';
import 'package:toast/toast.dart';
import 'package:sqflite/sqflite.dart';

class registerngo extends StatelessWidget{

  Widget build(BuildContext context)
  {
    bool k;
    TextEditingController ngoname = new TextEditingController();
    TextEditingController mobileno = new TextEditingController();
    TextEditingController registrationid = new TextEditingController();
    TextEditingController securitypin = new TextEditingController();

    return Material(
      child: Container(
        margin: EdgeInsets.only(left:60.0,top:70.0,right:60.0,bottom:50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Center(
                child: Text(
                  'Register Your NGO here',
                  style: TextStyle(fontFamily: 'JosefinSans',fontSize: 45),
                )
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'NGO Name',
                  hintText: 'Enter your ngo name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: ngoname,
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
              controller: mobileno,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Registration ID',
                  hintText: 'Enter your NGO registration ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: registrationid,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Security PIN',
                  hintText: 'Enter your securitypin _ _ _ _',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: securitypin,
            ),
            ElevatedButton(
                child: Text('Register Now'),
                onPressed:
                    () {
                  k=validate(ngoname.text,mobileno.text,securitypin.text);
                  if(k){
                    _insertngo(ngoname.text, mobileno.text, registrationid.text, securitypin.text);
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
  bool validate(String name,String mobno,String securityno)
  {
    if(mobno.length!=10)
    {
      return false;
    }

    if(securityno.length!=4)
    {
      return false;
    }

    if(name==null)
    {
      return false;
    }
    return true;

  }
  _insertngo(String ngoname,String mobno,String registrationno,String securitypin) async {

    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await databs.ins.database;

    // row to insert
    Map<String, dynamic> row = {
      databs.col1 : ngoname,
      databs.col2  : int.parse(mobno),
      databs.col3 : 0,
      databs.col4 : int.parse(securitypin),
      databs.col5 : int.parse(registrationno)
    };

    // do the insert and get the id of the inserted row
    int id = await db.insert(databs.table, row);

    // show the results: print all rows in the db
    print(await db.query(databs.table));
  }
}