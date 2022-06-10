import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'UpdateExpenses.dart';
import 'helpers/DataBaseHelper.dart';

class TransactionsData extends StatefulWidget {

  @override
  State<TransactionsData> createState() => _TransactionsDataState();
}

class _TransactionsDataState extends State<TransactionsData> {
  Future<List> alldata;

  getData() async
  {
    DataBaseHelper obj = new DataBaseHelper();
    setState(() {
      alldata = obj.getAllExpense();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  _createDialog(id) {
    AlertDialog alert = AlertDialog(
      title: Text("Are you Sure ?"),
      content: Text("Do you really want to delete permanently ?"),
      contentPadding: EdgeInsets.all(15.0),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(onPressed: () async {
                DataBaseHelper obj = new DataBaseHelper();
                int status = await obj.deleteexpense(id);
                print("Status :"+status.toString());
                Navigator.of(context).pop();
                if(status==1)
                {
                  print("Record Deleted");
                  Fluttertoast.showToast(
                      msg: "Record Deleted Permanently",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 20.0
                  );
                  getData();
                }
                else
                {
                  print("Error");
                }
              }, child: Text("Yes")),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ),
          ],
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: alldata,
          builder: (context,snapshots)
          {
            if(snapshots.hasData)
            {
              //  if data loaded
              if(snapshots.data.length<=0)
              {
                return Center(child: Text("No data"));
              }
              else
              {
                return ListView.builder(
                    itemCount:  snapshots.data.length,
                    itemBuilder: (context,index)
                    {
                      return Card(
                        color: (snapshots.data[index]["type"].toString()=="income")?Color(0xFFb2dfdb):Color(0xFFf8bbd0),
                        elevation: 20,
                        margin: EdgeInsets.all(10),
                        child:Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshots.data[index]["title"].toString(), style: TextStyle(fontSize: 20),),
                                  Text("Rs."+snapshots.data[index]["amount"].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(snapshots.data[index]["type"].toString(), style: TextStyle(fontSize: 18),),

                                  Text(snapshots.data[index]["datetime"].toString(), style: TextStyle(fontSize: 15),),
                                ],
                              ),


                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2.5,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          var id = snapshots.data[index]["eid"].toString();
                                          _createDialog(id);
                                        }, child: Text("Delete")),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2.5,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          var id = snapshots.data[index]["eid"].toString();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context)=>UpdateExpenses(updateEid: id))
                                          );
                                        },
                                        child: Text("Update")),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      );
                    }
                );
              }
            }
            else
            {
              //  data not loaded
              return Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }
}
