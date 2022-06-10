import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper
{
  Database db;

  //Database Create
  Future<Database> create_db() async
  {
    //  database already exist
    if(db!=null)
    {
      return db;
    }
    else
    {
      //database create
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path,"shopdb");
      var db = await openDatabase(path,version: 1,onCreate: create_table);
      return db;
    }
  }
  create_table(Database db,int version) async
  {
    // create table
    db.execute("create table expense (eid integer primary key autoincrement,title text,amount double,type text,datetime text)");
    print("Table created");

  }



  Future<int> addexpense(title,amount,_select,finaldate) async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into expense (title,amount,type,datetime) values(?,?,?,?)",[title,amount,_select,finaldate]);
    return id;
  }

  Future<int> updateexpense(title,amount,_select,finaldate,updateEid) async
  {
    var db = await create_db();
    // var id = await db.rawInsert("insert into student (Name,Rollno,S1,S2,S3,Total,Percent) values(?,?,?,?,?,?,?)",[name,rollno,s1,s2,s3,total,percent]);
    var status= await db.rawUpdate("update expense set title=?,amount=?,type=?,datetime=? where eid=?",[title,amount,_select,finaldate,updateEid]);
    return status;
  }



  Future<List> getAllExpense() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from expense");
    return data.toList();
  }

  Future<int> deleteexpense(id) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from expense where eid=?",[id]);
    return status;
  }


  Future<List> getsingleexpense(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from expense where eid=?",[id]);
    return data.toList();
  }


}