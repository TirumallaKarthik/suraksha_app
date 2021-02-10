import 'dart:async';
import "package:flutter/material.dart";
import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class databs extends StatelessWidget{
   static String databasena = 'datadb.db';
   static int databaseve = 1;
   static String table = 'userngo';
   static String col1 = 'name';
   static String col2 = 'mobno';
   static String col3 = 'aadharno';
   static String col4 = 'mpin';
   static String col5 = 'regid';
   static String table2 = 'entry';
   static String col11 = 'name';
   static String col21 = 'mobno';
   static String col31 = 'age';
   static String col41 = 'link';
   static String col51 = 'description';
   static String col61 = 'adopted';
   databs._privateConstructor();
   static databs ins = databs._privateConstructor();
   Database _database;
   Future<Database> get database async {
     if (_database != null) return _database;
     _database = await _initDatabase();
     return _database;
   }
   _initDatabase() async {
     Directory documentsDirectory = await getApplicationDocumentsDirectory();
     String path = join(documentsDirectory.path, databasena);
     return await openDatabase(path,version: databaseve, onCreate: _onCreate);
   }
   Future _onCreate(Database db, int version) async {
     await db.execute('''
          CREATE TABLE $table2 (
            $col11 TEXT NOT NULL,
            $col21 INTEGER NOT NULL,
            $col31 INTEGER NOT NULL,
            $col41 TEXT NOT NULL,
            $col51 TEXT NOT NULL,
            $col61 TEXT NOT NULL
          )
          ''');

     await db.execute('''
          CREATE TABLE $table (
            $col1 TEXT NOT NULL,
            $col2 INTEGER PRIMARY KEY,
            $col3 INTEGER NOT NULL,
            $col4 INTEGER NOT NULL,
            $col5 INTEGER NOT NULL
          )
          ''');

   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
