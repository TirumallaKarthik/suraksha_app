import "package:flutter/material.dart";
import 'package:suraksha_app/Login.dart';
import 'package:suraksha_app/Registeruser.dart';
import 'package:suraksha_app/registerngo.dart';
class opening extends StatelessWidget{
  Widget build(BuildContext context)
  {
     AssetImage img = AssetImage('assets/logo.png');
     Image lo = Image(image:img);
     return Material(
        child: Container(
          margin: EdgeInsets.only(left:60.0,top:150.0,right:60.0,bottom:200.0),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  lo,
                  Text(
                   'SURAKSHA',
                    style: TextStyle(fontFamily: 'JosefinSans',fontSize: 30),
               ),
               Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: <Widget> [
                     Flexible(child:
                       RaisedButton(
                           child: Text('Register'),
                           onPressed:
                           () {
                             Navigator.push(
                                 context, MaterialPageRoute(builder:
                                 (context) => register()));
                           }
                           )
                     ),
                      Flexible(child:
                       RaisedButton(
                         child: Text('Login'),
                         onPressed:
                         (){
                           Navigator.push(context,MaterialPageRoute(builder:
                           (context)=>login()));
                         }
                      )
                      ),
                     Flexible(child:
                     RaisedButton(
                         child: Text('Register NGO'),
                         onPressed:
                             (){
                           Navigator.push(context,MaterialPageRoute(builder:
                               (context)=>registerngo()));
                         }
                     )
                     )
                   ],
                 ),
                 )
          ],
          ),
        ),
        );
  }
}