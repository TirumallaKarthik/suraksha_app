import 'dart:ui';
import 'package:suraksha_app/Database.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:suraksha_app/Entrypage.dart';
import 'package:suraksha_app/Memberpage.dart';


class newentry extends StatefulWidget {

  String text;
  newentry({Key key, @required this.text}) : super(key: key);
  @override
  _newentryState createState() => _newentryState(text);
}

class _newentryState extends State<newentry> {
  String text;
  int p=0;
  _newentryState(String text)
  {
    this.text = text;
  }
  String stat;


  connectdat(String bb) async {
    List<Map<String, String>> cc = new List<Map<String, String>>();
    Database db = await databs.ins.database;

    Map<String,String> kk = new Map<String,String>();
    String sql;
    List<String> uu = bb.split(",");
    bb = uu[0];
    uu[1]=="0"?
    sql = "Select * from entry where mobno="+bb
    :
    sql = "Select * from entry";
    List<Map<String,dynamic>> y = await db.rawQuery(sql);
    setState(() {
      if (y.isEmpty) {
        p = 0;
//        return mm;
      }
      else {
        p = 1;
        for (Map<String, dynamic> z in y) {
          kk = {
            'name': z['name'],
            'adopted': z['adopted']
          };
          cc.add(kk);
        }
//
      }
    });
    return cc as List<Map<String,String>>;
//    return y;
  }

  displaylist() async {

    List<Map<String, String>> mm = new List<Map<String, String>>();
    List<String> mo = text.split(".");

    mm = await connectdat(mo[1]+","+mo[2]);


    return p==0?Container(child:Text("No Entries")):
    Flexible(child: Scaffold(
      body:
          ListView.builder(
              itemCount: mm.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (ctxt,index)
              {
                if(mm[index]['adopted']=='not yet')
                {
                  stat = 'pending...';
                }
                else{
                  stat = mm[index]['adopted'];
                }
                return ListTile(
                    leading: Icon(Icons.account_box_rounded),
                    title: Text(mm[index]['name']),
                    subtitle: Text('Adopted by $stat'),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder:
                          (context)=>memberpage(text: mo[1]+"."+mm[index]['name']+"."+mo[2]+"."+mo[0])));
                    }
                );
              })
      ),
    );

  }

  Widget build(BuildContext context) {

    List<String> mo = text.split(".");

//    setState(() {

//    });
    AssetImage img = AssetImage('assets/logo.png');
    Image lo = Image(image: img);
    String v = mo[0];

      return Material(
          child: Container(
              margin: EdgeInsets.only(
                  left: 50.0, top: 70.0, right: 50.0, bottom: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(onPressed: null),
                          RaisedButton(onPressed: null),
                          RaisedButton(onPressed: null),
                          RaisedButton(
                              child: Text("Logout"),
                              onPressed:
                                  () {
                                Navigator.pop(context);
                              }
                          )
                        ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Hi $v',
                                style: TextStyle(
                                    fontFamily: 'JosefinSans', fontSize: 20),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Welcome to Suraksha',
                                style: TextStyle(
                                    fontFamily: 'JosefinSans', fontSize: 20),
                              )
                            ]
                        ),
                        lo
                      ],
                    ),

                    mo[2]=="0"?
                    Container(
                        margin: EdgeInsets.only(
                            left: 0.0, top: 20.0, right: 150.0, bottom: 0.0),
                        child:
                        RaisedButton(
                            child: Text('Add New Entry'),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) => entrypage(text: text)));
                            }
                        )
                    )
                    : Container(),

                    FutureBuilder<dynamic>(
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return snapshot.data;

                          return Container(child: CircularProgressIndicator());
                        },
                        future: displaylist()
                    )

                  ]
              )
          )
      );

  }
}