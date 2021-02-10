import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:suraksha_app/Database.dart';
import 'package:toast/toast.dart';

import 'Newentry.dart';
class login extends StatelessWidget{
  Widget build(BuildContext context)
  {
    String k=null;
    TextEditingController mobno = new TextEditingController();
    TextEditingController mpin = new TextEditingController();
    return Material(
      child: Container(
        margin: EdgeInsets.only(left:80.0,top:150.0,right:80.0,bottom:150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Center(
                child: Text(
                  'Login Here',
                  style: TextStyle(fontFamily: 'JosefinSans',fontSize: 45),
                )
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
                  labelText: 'MPin/SecurityPIN',
                  hintText: 'Enter your mpin/securitypin',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              controller: mpin,
            ),
            RaisedButton(
                child: Text('Login Now'),
                onPressed:
                  () async
                  {
                    k = await validate(mobno.text, mpin.text);
                    if(k!=null) {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context) => newentry(text: k)));
                    }
                    else{
                      Toast.show('Incorrect Username or Password', context);
                    }
                  }
            )

          ],
        ),
      ),
    );
  }
  validate(String mobno,String mpin) async
  {
    int m,n;
    String l;
    Database db = await databs.ins.database;
     String sql = "Select mpin,name,regid from userngo where mobno=$mobno";
     List<Map<String,dynamic>> map = await db.rawQuery(sql);
     for(Map<String,dynamic> z in map)
     {
        m = z['mpin'];
        l = z['name'];
        n = z['regid'];
     }
     if(m==int.parse(mpin))
       {
         return l+"."+mobno+"."+n.toString();
       }
     else{
       return null;
     }
  }
}